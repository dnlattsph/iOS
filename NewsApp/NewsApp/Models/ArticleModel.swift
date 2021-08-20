//
//  ArticleModel.swift
//  NewsApp
//
//  Created by D Naung Latt on 19/08/2021.
//

import Foundation

protocol ArticleModelProtocol {
    func articleRetrieved(_ articles:[Article])
}

class ArticleModel {
    
    var delegate:ArticleModelProtocol?
    
    func getArticles() {
        
        // fire off the request to the API
    
        // Create a string URL
        let apiKey = "064e4690770a4bda8b399ac2a98bcc04"
        let stringURL = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=\(apiKey)"
        
        // Create a URL object
        let url = URL(string: stringURL)
        
        // Check that it isn't nil
        guard url != nil else {
            print("Couldn't create URL object")
            return
        }
        
        // Create the URL session
        let session = URLSession.shared
        
        // Create the Data Task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check that there are no errors and that there is data
            if error == nil && data != nil {
                
                let decoder = JSONDecoder()
                
                do {
                    // Parse the json to the Article Service
                    let articleService = try decoder.decode(ArticleService.self, from: data!)
                    
                    //Get the articles
                    let articles = articleService.articles!
                    
                    // Parse the returned JSON into the article instances and pass it back to the view controller with the protocol and delegate pattern
                    DispatchQueue.main.async {
                        self.delegate?.articleRetrieved(articles)
                    }
                    
                }
                catch {
                    print("Error parsing the json. Why am I here?")
                } // End Do Catch
                
            } // End if
            
        } // End Data Task
        
        // Start Data Task
        
        dataTask.resume()
        
        
    }
}
