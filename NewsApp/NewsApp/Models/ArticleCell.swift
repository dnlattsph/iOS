//
//  ArticleCell.swift
//  NewsApp
//
//  Created by D Naung Latt on 19/08/2021.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    
    @IBOutlet weak var headlineLabel: UILabel!
    
    @IBOutlet weak var articleImageView: UIImageView!
    
    // MARK: Properties
    
    var articleToDisplay:Article?
    
    func displayArticle(_ article:Article) {
        
        // Clean up the cell before displaying the next article
        articleImageView.image = nil
        articleImageView.alpha = 0
        headlineLabel.text = ""
        headlineLabel.alpha = 0
        
        // Keep a reference to the article
        articleToDisplay = article
        
        // Set the headline
        headlineLabel.text = articleToDisplay?.title
        
        // Animate the label into view
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            self.headlineLabel.alpha = 1
        }, completion:  nil)

        
        // Check that article has an image
        
        guard articleToDisplay!.urlToImage != nil else {
            return
        }
        
        // Download and display the Image
        
        // Create URL String
        let urlString = articleToDisplay!.urlToImage!
        
        // Check the cachemanager before downloading any image data
        if let imageData = CacheManager.retrieveData(urlString) {
            
            // There is image data, set the ImageView & return
            articleImageView.image = UIImage(data: imageData)
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                self.articleImageView.alpha = 1
            }, completion:  nil)
            
            return
        }
        
        // Create URL
        let url = URL(string: urlString)
        
        // Check that URl isn't nil
        guard url != nil else {
            print ("Couldn't create URL object")
            return
        }
        
        // Get a URLSession
        let session = URLSession.shared
        
        // Create a datatask
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //Check that there were no errors
            
            if error == nil && data != nil {
                
                // Save the data into cache
                
                CacheManager.saveData(urlString, data!)
                
                // Check if the URL string that the data task went of to download matches the article this cell is set to display
                if self.articleToDisplay!.urlToImage == urlString {
                    DispatchQueue.main.async {
                        // Display the image data in image view
                        self.articleImageView.image = UIImage(data: data!)
                        
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            self.articleImageView.alpha = 1
                        }, completion:  nil)
                    }
                }
                
            }
        }
        
        // Kick off the datatask
        dataTask.resume()
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
