//
//  WebViewController.swift
//  CocoaTouchNews
//
//  Created by Florin Uscatu on 11/8/17.
//  Copyright © 2017 Florin Uscatu. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var urlString = ""
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: urlString) {
            
            let request = URLRequest(url: url)
            
            webView.load(request)
        }
    }

}
