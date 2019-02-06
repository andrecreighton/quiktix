//
//  QTWebViewController.swift
//  QuikTix
//
//  Created by Andre Creighton on 1/17/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import UIKit
import WebKit

class QTWebViewController: UIViewController {

  @IBOutlet weak var webView: WKWebView!
 
  
  override func viewDidLoad() {
        super.viewDidLoad()
        webView.load("https://dev.socrata.com/foundry/data.cityofnewyork.us/uvbq-3m68")
    }
  
  @IBAction func whenBackButtonTapped(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  
  }
  
}

extension WKWebView {
  
  func load(_ urlString: String){
    if let url = URL(string: urlString){
      let request = URLRequest(url: url)
      load(request)
      
    }
  }

}
