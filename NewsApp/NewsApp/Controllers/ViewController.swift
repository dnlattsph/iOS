//
//  ViewController.swift
//  NewsApp
//
//  Created by D Naung Latt on 19/08/2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    var model = ArticleModel()
    var articles = [Article]()
    
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the ViewController as the datasource & delegate of the tableview
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Get the artcilies from the article Model
        model.delegate = self
        model.getArticles()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Detect the indexPath the user selected
        let indexPath = tableView.indexPathForSelectedRow
        
        guard indexPath != nil else {
            return
        }
        
        // Get the article user tapped on
        let article = articles[indexPath!.row]
        
        //Get a reference to the detail view Controller
        let detailVC = segue.destination as! DetailViewController
        
        // Pass the article URL to the Detail View Controller
        detailVC.articleURL = article.url 
        
    }
    

}

extension ViewController: ArticleModelProtocol {
    
    // MARK: - Article Model Protocol Methods
    
    func articleRetrieved(_ articles: [Article]) {
        
        // Set the articles property of the view controller to the article passed back from the model
        self.articles = articles
        
        
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return Number of Articles
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        // Get the article that the tableView is asking about
        let article = articles[indexPath.row]
        
        // TODO: Customise it
        cell.displayArticle(article)
        
        // Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // User has just selected a row, trigger the segue to go to detail
        performSegue(withIdentifier: "goToDetail", sender: self)
        
    }
    
}
