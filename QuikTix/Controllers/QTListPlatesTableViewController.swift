//
//  QTListPlatesTableViewController.swift
//  QuikTix
//
//  Created by Andre Creighton on 1/15/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import UIKit

class QTListPlatesTableViewController: UITableViewController {
  
    
    let dbManager = DatabaseManager()
    lazy var arrayOfViolations = [Violation]()
  
    // MARK: - Table view data source
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      
        return arrayOfViolations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "violation", for: indexPath) as! QTViolationTableViewCell

        cell.amountDueLabel.text = "$\(arrayOfViolations[indexPath.row].amountDue)"
        cell.dateLabel.text = arrayOfViolations[indexPath.row].issueDate
        cell.descriptionLabel.text = arrayOfViolations[indexPath.row].summary
      
        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    
        return 80
    
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "showDetails", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetails" {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        print("prepare for segue Array Count: \(arrayOfViolations.count)")
        let controller = segue.destination as! QTDetailTableViewController
        controller.violation = arrayOfViolations[indexPath.row]
      }

    }

  }

  
  func grabDataFromFirebase(){
    
    dbManager.pullDataFromFirebase { (array) in
      
      print("array count: \(array.count)")
      
      if array.count > 0 {
        
        for vio in array {
          
          if vio.amountDue == "0"{
            // do nothing
          }else{
            self.arrayOfViolations.append(vio)
            
          }
        }
        
        self.tableView.reloadData()
      
      }else{
        
        print("no tickets due")
        
      }
    }

    
  }
  
  @IBAction func whenBackButtonTapped(_ sender: Any) {
    
    print("backbuttontapped")
    self.navigationController?.popViewController(animated: true)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.barTintColor = UIColor.tealColor()
    self.navigationController?.isNavigationBarHidden = false
    
    
    tableView.register(UINib(nibName: "QTViolationTableViewCell", bundle: nil), forCellReuseIdentifier: "violation")
    
    
    grabDataFromFirebase()
    
  }
  
  
}
