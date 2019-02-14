//
//  QTEnterPlateViewController.swift
//  QuikTix
//
//  Created by Andre Creighton on 1/15/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import UIKit
import Network

class QTEnterPlateViewController: UIViewController, UITextFieldDelegate {
  

  // MARK: - Outlets, Constants, Variables
  @IBOutlet weak var titleOfAppLabel: UILabel!
  @IBOutlet weak var enterLicensePlatePromptLabel: UILabel!
  @IBOutlet weak var licensePlateTextField: UITextField!
  @IBOutlet weak var searchButton: UIButton!
  @IBOutlet weak var apiButton: UIButton!
  @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
  @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
  
  
  let appStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
  let apiClient = ParkingCameraViolationsClient()
  let dbManager = DatabaseManager()
  let monitor = NWPathMonitor()

  // MARK: - Actions
  
  @objc func whenTapRecognized(){
  
  licensePlateTextField.resignFirstResponder()
  
  }
  
  @IBAction func searchButtonTapped(_ sender: Any) {
  
    // TODO: Verify License Plate Number..Should be letters and numbers only.
   
    if let licenseNumber = licensePlateTextField.text, !(licenseNumber.isEmpty) {
      
      apiClient.pullDataFromAPIClientWithLicensePlate(number: licenseNumber) { [unowned self] (violationArray) in
        
        if(violationArray.count > 0){
          print("\(violationArray.count) listing(s) found!!")
        
          self.dbManager.pushDataToFirebaseUsing(violationArray, completion: { (success) in
            
            if(success){
              
              DispatchQueue.main.async {
                self.whenTapRecognized()
                self.goToVC()
              }
         
            }else{
              print("boo")
            }
            
          })
     

        }else{
          // Alert no data found
          DispatchQueue.main.async {
             self.alertUserOfNoRecord()
          }
          print("no data found")
        }

      }
      
    }else{
      
      print("No valid entry")
    }
  
  }
  // MARK: - F(X)
  
  func goToVC(){
    
    let tableViewController = storyboard?.instantiateViewController(withIdentifier: "tableVC") as! QTListPlatesTableViewController
    self.navigationController?.pushViewController(tableViewController, animated: true)
    
  }
  
  func alertUserOfNoRecord(){
    
    let alertVC = UIAlertController(title: "!!!", message: "License plate \(licensePlateTextField.text!.uppercased()) has no record of violations.", preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "Ok", style: .default) { (_) in
      self.licensePlateTextField.text = ""
      self.licensePlateTextField.becomeFirstResponder()
   
    }
  
    alertVC.addAction(alertAction)
    self.present(alertVC, animated: true, completion: nil)
    
  }
  
  func alertUserNoConnection(){
    
    
    let alertVC = UIAlertController(title: "!!!", message: "You are not connected", preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "Ok", style: .default) { (_) in
      
      self.licensePlateTextField.isUserInteractionEnabled = false
      self.searchButton.isUserInteractionEnabled = false
      self.apiButton.isUserInteractionEnabled = false
      
    }
    
    alertVC.addAction(alertAction)
    self.present(alertVC, animated: true, completion: nil)
    
    
    
  }
  
  @objc func respondToBeingActive(){
    
    print("ACTIVE")
    
    
  }
  
  func updateTheUI(){
  
    tapGestureRecognizer.addTarget(self, action: #selector(whenTapRecognized))
    licensePlateTextField.delegate = self
    searchActivityIndicator.isHidden = true
    searchActivityIndicator.stopAnimating()
    
    navigationController?.setNavigationBarHidden(true, animated: false)
    
    
  }
  
  func notificationsStack(){
    
    NotificationCenter.default.addObserver(self, selector: #selector(respondToBeingActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    
    
  }
  
  func networkSetup(){
    
    monitor.pathUpdateHandler = { path in
      if path.status == .satisfied{
        print("Connected")
        DispatchQueue.main.async {
          self.licensePlateTextField.isUserInteractionEnabled = true
          self.searchButton.isUserInteractionEnabled = true
          self.apiButton.isUserInteractionEnabled = true
        }
        
      }else if path.status == .unsatisfied {
        print("Not connected")
        DispatchQueue.main.async {
        self.alertUserNoConnection()
        }
        
      }
    
      print(path.isExpensive)
    }
    
  
    
  }
  // MARK: - VIEWDIDLOAD
  
    override func viewDidLoad() {
        super.viewDidLoad()
      updateTheUI()
      notificationsStack()
      networkSetup()
      let queue = DispatchQueue(label: "monitor")
      monitor.start(queue: queue)
    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    updateTheUI()
  }
 
}


extension UIColor {
  
  
  static func tealColor() -> UIColor {
    
    return UIColor(red: 0/255, green: 145/255, blue: 147/255, alpha: 1)
    
  }
  
}
