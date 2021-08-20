//
//  QuizModel.swift
//  QuizApp
//
//  Created by D Naung Latt on 16/08/2021.
//

import Foundation

protocol QuizProtocol {
    
    func questionsRetrieved(_ questions:[Question])
}

class QuizModel {
    
    var delegate:QuizProtocol?
    
    func getQuestions() {
        
        // TODO: Fetch the questions
        //getLocalJsonfile()
        getRemoteJsonFile()
        
        
        
    }
    
    func getLocalJsonfile() {
        
        // Notify the delegate of the retrieved questions
        
        // Get Bundle apth to JSONfile
        
        let path = Bundle.main.path(forResource: "QuestionData", ofType: "json")
        
        // Double Check that the path isn't nil
        
        guard path != nil else {
            print("Coudln't find the json data file")
            return
        }
        
        // Create URL object from the path
        
        let url = URL(fileURLWithPath: path!)
        
        
        
        do {
            // Get the data from the URL
            let data = try Data(contentsOf: url)
            
            // Try to decode the data to objects
            let decoder = JSONDecoder()
            let array = try decoder.decode(
                [Question].self, from: data)
            
            delegate?.questionsRetrieved(array)
        }
        catch {
            // Error: Couldn't download the data the that URL
        }
        
        
        
        
        
    }
    
    func getRemoteJsonFile() {
        
        // Get a URL object
        let urlString = "https://codewithchris.com/code/QuestionData.json"
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            print ("Couldn't create the URL object")
            return
        }
        

        // Get a URL Session object
        let session = URLSession.shared
        
        // Get a Data task object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check that there wasn't an error
            
            if error == nil && data != nil {
                
                do {
                    // Creaet a JSON Decoder Object
                    let decoder = JSONDecoder()
                    
                    // Parse the JSON
                    let array = try decoder.decode([Question].self, from: data!)
                    
                    // Use the main thread to notify the view controller for UI Work
                    DispatchQueue.main.async {
                        // Notify the View Controller
                        self.delegate?.questionsRetrieved(array)
                    }
                    
                }
                catch {
                    print("Couldn't parse JSON")
                    
                }
                
                
            }
            
            
        }
        
        // Call resume on the data Task
        dataTask.resume()
        
    }
}
