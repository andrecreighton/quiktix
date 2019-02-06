//
//  ParkingCameraVioationsAPI.swift
//  QuikTix
//
//  Created by Andre Creighton on 1/15/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import Foundation

class ParkingCameraViolationsClient : NSObject {
  
  func pullDataFromAPIClientWithLicensePlate(number licensePlate: String, completion: @escaping([Violation]) ->()) {
    
    var arrayOfViolations = [Violation]()
    
    let uppercased = licensePlate.uppercased()
    
    let urlString = "https://data.cityofnewyork.us/resource/uvbq-3m68.json?plate=\(uppercased)"
    
    guard let url = URL(string: urlString) else{
      print("Cannot be converted")
      return
    }
    
    print(url)
    
    let urlRequest = URLRequest(url: url) // make URLRequest
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    
    let dataTask = session.dataTask(with: urlRequest) { (data, response, err) in
      
      if let error = err {
        print(error.localizedDescription)
      }else{
        
        guard let dataRequest = data else{
          print("Did not recieve data")
          return
        }
        
        do {
          
          let arrayOfViolationDictionariesWithAllData = try JSONSerialization.jsonObject(with: dataRequest, options: .mutableContainers) as! [[String:Any]]
          
          
          for violationDictionary in arrayOfViolationDictionariesWithAllData {
            
            print("violationDictionary: \(violationDictionary["plate"])")
            
            let violation = Violation(summonsNumber: "", summary: "", state: "", plate: "", issueDate: "", violationTime: "", paymentAmount: "", amountDue: "")
            
            let violationAfterParse = violation.deserializeDataFromJSON(dataSet: violationDictionary)
            
            arrayOfViolations.append(violationAfterParse)
            
           
          }
          
          completion(arrayOfViolations)
        }catch{
          
          print("Data cannot be converted to JSON")
          
        }
        
      }
      
    }
    
    dataTask.resume()
    
    
  }
  
  
}
