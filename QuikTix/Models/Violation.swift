//
//  Violation.swift
//  QuikTix
//
//  Created by Andre Creighton on 1/15/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import Foundation


struct Violation {
  
  var summonsNumber: String
  var summary:String
  var state: String
  var plate: String
  var issueDate: String
  var violationTime: String
  var paymentAmount: String
  var amountDue:  String
  
  init(){
    
    self.summonsNumber = ""
    self.summary = ""
    self.state = ""
    self.plate = ""
    self.issueDate = ""
    self.violationTime = ""
    self.paymentAmount = ""
    self.amountDue = ""
    
  }

  
  init(summonsNumber:String, summary: String, state: String, plate: String, issueDate: String, violationTime: String, paymentAmount: String, amountDue: String){
    
    self.summonsNumber = summonsNumber
    self.summary = summary
    self.state = state
    self.plate = plate
    self.issueDate = issueDate
    self.violationTime = violationTime
    self.paymentAmount = paymentAmount
    self.amountDue = amountDue
    
  }
  
  
  func serialize() -> [String:String]{
    return ["summonsNumber": summonsNumber, "summary": summary, "state": state, "plate":plate, "issueDate":issueDate, "violationTime": violationTime, "paymentAmount":paymentAmount, "amountDue":amountDue]
  }

  
  // Deserialize data from JSON into Violation objects
  
  func deserializeDataFromJSON(dataSet data:[String:Any]) -> Violation{
    
    let summonsNumber = data["summons_number"] as? String ?? ""
    let summary = data["violation"] as? String ?? ""
    let state = data["state"] as? String ?? ""
    let plate = data["plate"] as? String ?? ""
    let issueDate = data["issue_date"] as? String ?? ""
    let violationTime = data["violation_time"] as? String ?? ""
    let paymentAmount = data["payment_amount"] as? String ?? ""
    let amountDue = data["amount_due"] as? String ?? ""
    
    
    let aViolation = Violation(summonsNumber: summonsNumber, summary: summary, state: state, plate: plate, issueDate: issueDate, violationTime: violationTime, paymentAmount: paymentAmount, amountDue: amountDue)
    
    return aViolation
  }
  
  
  func deserializeDataFromFirebase(dataSet data:[String:Any]) -> Violation{
    
    let summonsNumber = data["summonsNumber"] as? String ?? ""
    let summary = data["summary"] as? String ?? ""
    let state = data["state"] as? String ?? ""
    let plate = data["plate"] as? String ?? ""
    let issueDate = data["issueDate"] as? String ?? ""
    let violationTime = data["violationTime"] as? String ?? ""
    let paymentAmount = data["paymentAmount"] as? String ?? ""
    let amountDue = data["amountDue"] as? String ?? ""
    
    
    let aViolation = Violation(summonsNumber: summonsNumber, summary: summary, state: state, plate: plate, issueDate: issueDate, violationTime: violationTime, paymentAmount: paymentAmount, amountDue: amountDue)
    
    return aViolation
  }

  
}

