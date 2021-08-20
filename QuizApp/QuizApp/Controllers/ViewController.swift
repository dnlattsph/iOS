//
//  ViewController.swift
//  QuizApp
//
//  Created by D Naung Latt on 16/08/2021.
//

import UIKit

class ViewController: UIViewController, QuizProtocol, UITableViewDelegate, UITableViewDataSource, ResultViewControllerProtocol {
    
    
    @IBOutlet weak var stackViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var stackViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rootStackView: UIStackView!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var model = QuizModel()
    var questions = [Question]()
    var currentQuestionIndex = 0
    var numCorrect = 0

    var resultDialog:ResultViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init the result dialog
        resultDialog = storyboard?.instantiateViewController(identifier: "ResultVC") as? ResultViewController
        resultDialog?.modalPresentationStyle = .overCurrentContext
        resultDialog?.delegate = self
        
        // Set seft as the delegate and datasource for the tableView
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Dynanmic Row heights
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        // Set up the model
        
        model.delegate = self
        model.getQuestions()
    }
    
    func slideInQuestion() {
        
        // set the initial state
        stackViewTrailingConstraint.constant = -1000
        stackViewLeadingConstraint.constant = 1000
        rootStackView.alpha = 0
        
        view.layoutIfNeeded()
        
        // Animate it to the end state
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.stackViewLeadingConstraint.constant = 0
            self.stackViewTrailingConstraint.constant = 0
            self.rootStackView.alpha = 1
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func slideOutQuestion() {
        
        // set the initial state
        stackViewTrailingConstraint.constant = 0
        stackViewLeadingConstraint.constant = 0
        rootStackView.alpha = 1
        
        view.layoutIfNeeded()
        
        // Animate it to the end state
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.stackViewLeadingConstraint.constant = -1000
            self.stackViewTrailingConstraint.constant = 1000
            self.rootStackView.alpha = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func displayQuestion() {
        // Check if there are questions and check that the currentQuestionIndex is not out of bounds
        
        guard questions.count > 0 && currentQuestionIndex < questions.count else {
            return
        }
        
        //Display the question text
        questionLabel.text = questions[currentQuestionIndex].question
        
        // Reload the tableView
        tableView.reloadData()
        
        // Slide in the next question
        slideInQuestion()
    }

    // MARK: - QuizProtocol Methods
    func questionsRetrieved(_ questions: [Question]) {
        
        // Get a reference to the questions
        self.questions = questions
        
        // Check if we should restore the state, before showing question #1
        
        let savedIndex = StateManager.retrieveValue(key: StateManager.questionIndexKey) as? Int
        
        if savedIndex != nil && savedIndex! < self.questions.count {
            
            // Set the current question to Saved index
            currentQuestionIndex = savedIndex!
            
            // Retrieve the number correct from storage
            
            
            let saveNumCorrect = StateManager.retrieveValue(key: StateManager.numCorrectKey) as? Int
            
            if saveNumCorrect != nil {
                numCorrect = saveNumCorrect!
            }
            
        }
        
        // Dsiplay the first Question
        displayQuestion()
        
        
    }
    
    // MARK: - UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Make sure that the qeustions array at least a question
        
        guard questions.count > 0 else {
            return 0
        }
        
        // Return the number of answers for this question
        
        let currentQuestion = questions[currentQuestionIndex]
        
        if currentQuestion.answers != nil {
            return currentQuestion.answers!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        
        // Customize it
        let label = cell.viewWithTag(1) as? UILabel
        
        if label != nil {
            
            let question = questions[currentQuestionIndex]
            
            if question.answers != nil && indexPath.row < question.answers!.count {
                // Set the answer text for the label
                label!.text = question.answers![indexPath.row]
            }
            
            
        }
        
        // Return the cell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var titleText = ""
        
        // User has tapped on a row, check if it's the correct answer
        
        let question = questions[currentQuestionIndex]
        
        if question.correctAnswerIndex! == indexPath.row {
            
            // User got it right
            print("User got it right")
            titleText = "Correct"
            numCorrect += 1
            
        }
        else {
            
            // User got it wrong
            print("User got it wrong")
            titleText = "Wrong"
        }
        
        
        // Slide out the question
        DispatchQueue.main.async {
            self.slideOutQuestion()
        }
        
        // Show the popup
        
        if resultDialog != nil {
            
            // Customize the Dialog Text
            resultDialog!.titleText = titleText
            resultDialog!.feedbackText = question.feedback!
            resultDialog!.buttonText = "Next"
            
            
            DispatchQueue.main.async {
                // Pop up dialog
                self.present(self.resultDialog!, animated: true, completion: nil)
            }
            
            
        }
        
        
    }
    
    // MARK: - ResultViewControllerProtocol Methods
    
    func dialogDismissed() {
        
        // Increment the currentQuestionIndex
        currentQuestionIndex += 1
        
        if currentQuestionIndex == questions.count {
            
            // User has just answered the last question
            
            // Show a summary dialog
            
            if resultDialog != nil {
                
                // Customize the Dialog Text
                resultDialog!.titleText = "Summary"
                resultDialog!.feedbackText = "You out \(numCorrect) correct out of \(questions.count) questions!"
                resultDialog!.buttonText = "Restart"
                
                // Pop up dialog
                present(resultDialog!, animated: true, completion: nil)
                
                // Clear State
                StateManager.clearState()
                
            }
            
        }
        else if currentQuestionIndex > questions.count {
            
            //Restart
            numCorrect = 0
            currentQuestionIndex = 0
            displayQuestion()
        }
        else if currentQuestionIndex < questions.count {
            
            // More question to show
            
            // Display the next question
            displayQuestion()
            
            
            // Save the state
            
            StateManager.saveState(numCorrect: numCorrect, questionIndex: currentQuestionIndex)
        }
        
        
        
    }
}

