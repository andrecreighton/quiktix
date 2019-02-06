//
//  QTEnterPlateViewController.swift
//  QuikTix
//
//  Created by Andre Creighton on 1/15/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import UIKit

class QTEnterPlateViewController: UIViewController, UITextFieldDelegate {
  

  // MARK: - Outlets, Constants, Variables
  @IBOutlet weak var titleOfAppLabel: UILabel!
  @IBOutlet weak var enterLicensePlatePromptLabel: UILabel!
  @IBOutlet weak var licensePlateTextField: UITextField!
  @IBOutlet weak var searchButton: UIButton!
  @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
  @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
  
  
  let appStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
  let apiClient = ParkingCameraViolationsClient()
  let dbManager = DatabaseManager()

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
              print("Yay")
              
              
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
  
  func updateTheUI(){
  
    tapGestureRecognizer.addTarget(self, action: #selector(whenTapRecognized))
    
    licensePlateTextField.delegate = self
    
    searchActivityIndicator.isHidden = true
    searchActivityIndicator.stopAnimating()
    
    navigationController?.setNavigationBarHidden(true, animated: false)
    
    
  }
  // MARK: - VIEWDIDLOAD
  
    override func viewDidLoad() {
        super.viewDidLoad()
      updateTheUI()
      
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
