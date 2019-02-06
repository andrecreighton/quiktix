//
//  QTDetailTableViewController.swift
//  QuikTix
//
//  Created by Andre Creighton on 1/22/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import UIKit

class QTDetailTableViewController: UITableViewController {
  
 
  var violation = Violation(summonsNumber: "", summary: "", state: "", plate: "", issueDate: "", violationTime: "", paymentAmount: "", amountDue: "")
  
  let violationTitle = ["Summons Number","Summary","State","Plate","Issue Date","Violation Time","Payment Amount", "Amount Due"]
  
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }
  
  override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    if section == 0 {
      return "These Open Parking and Camera Violations are issued by the City of New York. For payment options, please visit www.nyc.gov/finance."
    }
   return ""
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! QTDetailTableViewCell
    
    cell.selectionStyle = .none
    cell.detailTextLabel?.text = violationTitle[indexPath.row]
    cell.titleLabel.text = getValue(cell)
    
    
  
    return cell
  }

  func getValue(_ cell: QTDetailTableViewCell) -> String {
    
    switch cell.detailTextLabel?.text {
      
    case "Summons Number":
      return violation.summonsNumber
    case "Summary":
      return violation.summary
    case "State":
      return violation.state
    case "Plate":
      return violation.plate
    case "Violation Time":
      return violation.violationTime
    case "Issue Date":
      return violation.issueDate
    case "Payment Amount":
      return "$\(violation.paymentAmount)"
    case "Amount Due":
      return "$\(violation.amountDue)"
    default:
      return ""
    }
    
    
  }


  @IBAction func whenBackButtonTapped(_ sender: Any) {
    
    navigationController?.popViewController(animated: true)
    
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print("violation: \(violation.summonsNumber)")
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    
  }

  
}
