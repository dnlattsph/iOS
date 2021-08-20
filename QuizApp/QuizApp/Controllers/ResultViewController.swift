//
//  ResultViewController.swift
//  QuizApp
//
//  Created by D Naung Latt on 17/08/2021.
//

import UIKit

protocol ResultViewControllerProtocol {
    func dialogDismissed()
}

class ResultViewController: UIViewController {

    @IBOutlet weak var dimView: UIView!
    
    @IBOutlet weak var dialogView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    
    @IBOutlet weak var dismissButton: UIButton!
    
    var titleText = ""
    var feedbackText = ""
    var buttonText = ""
    
    var delegate:ResultViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Round the dialog box corners
        dialogView.layer.cornerRadius = 10
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Now that elemens have loaded, set the text
        titleLabel.text = titleText
        feedbackLabel.text = feedbackText
        dismissButton.setTitle(buttonText, for: .normal)
        
        // Hide the UI elements
        dimView.alpha = 0
        titleLabel.alpha = 0
        feedbackLabel.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Fade in elements
        
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            self.dimView.alpha = 1
            self.titleLabel.alpha = 1
            self.feedbackLabel.alpha = 1
        }, completion: nil)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func dismissTapped(_ sender: Any) {
        
        // Fade out the dim view and dismiss the popup
        
        UIView.animate(withDuration: 0.3, delay:0, options: .curveEaseOut, animations: {
            self.dimView.alpha = 0
        }) { (completed) in
            
            // dismiss the button
            self.dismiss(animated: true, completion: nil)
            
            // Notify delegate that popup was dismissed
            
            self.delegate?.dialogDismissed()
        }
        
    }
    

}
