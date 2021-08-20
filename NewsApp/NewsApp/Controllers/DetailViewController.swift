//
//  DetailViewController.swift
//  NewsApp
//
//  Created by D Naung Latt on 19/08/2021.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    // MARK: - Properties
    var articleURL:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Check that there's a URL
        if articleURL != nil {
            
            // Create URL object
            let url = URL(string: articleURL!)
            
            guard url != nil else {
                // Coudln't create the URL object
                return
            }
            
            // Create URLRequest object
            let request = URLRequest(url: url!)
            
            // Start Spinner
            spinner.alpha = 1
            spinner.startAnimating()
            
            //Load it in the webview
            webView.load(request)
        }
        
        // Load it in the web view
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // Stop the spinner and hide it
        spinner.stopAnimating()
        spinner.alpha = 0
    }
}
