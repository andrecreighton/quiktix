//
//  DatabaseManager.swift
//  QuikTix
//
//  Created by Andre Creighton on 1/20/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class DatabaseManager: NSObject {
  
  lazy var database = Firestore.firestore()
  var fixedViolationsArray = [Violation]()
  var id = ""
  
  var violation = Violation(summonsNumber: "", summary: "", state: "", plate: "", issueDate: "", violationTime: "", paymentAmount: "", amountDue: "")
  
  
  func pullDataFromFirebase(completion: @escaping([Violation]) ->()){

    id = self.getValue()
    
    database.collection(id).getDocuments { (snapshot, err) in
      
      if let error = err {
        print(error.localizedDescription)
      }else{
        
        print(snapshot?.documents)
        
        for document in snapshot!.documents {
       
          let newViolation = self.violation.deserializeDataFromFirebase(dataSet: document.data())
  
          self.fixedViolationsArray.append(newViolation)
          
          document.reference.delete()
        
        }
      }
      
      completion(self.fixedViolationsArray)
    }
  
  }
  
  func pushDataToFirebaseUsing(_ data:[Violation], completion: @escaping(Bool) ->()){
    
    let success = true
    
    let plate = data[0].plate
    self.saveToDefaults(plate)
    
    for violation in data {
      
      database.collection(plate).document().setData(violation.serialize()) { (err) in
        
        if let error = err {
          print(error.localizedDescription)
            completion(!success)
        }else{
          
          
        }
      
        
      }
      
    }
    
    completion(success)
    
  }
  
    
  
}

extension DatabaseManager {
  
  func saveToDefaults(_ string:String){
  
    let defaults = UserDefaults.standard
    defaults.set(string, forKey: "id")
    print("self:\(string)")
    
  }
  
  func getValue() -> String{
  
    let defaults = UserDefaults.standard
    let stringValue = defaults.object(forKey: "id") as? String ?? ""
    print("stringValue:\(stringValue)")
    
    return stringValue
  }

}


