//
//  QuestionViewController.swift
//  Quiz
//
//  Created by Наталья Шарапова on 13.09.2021.
//

import UIKit

class QuestionViewController: UIViewController {
    
    // MARK: - Outlets:
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet weak var multiplyStackView: UIStackView!
    @IBOutlet var multiLabel: [UILabel]!
    @IBOutlet var multiSwitch: [UISwitch]!
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedSlider: UISlider!
    @IBOutlet var rangeLabel: [UILabel]!
    
    
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet var imageButtons: [UIButton]!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    // MARK: - Properties:
    
    var answersChosen: [Answer] = [] {
        didSet {
            print(#line, #function, answersChosen)
        }
    }
    var currentAnswers: [Answer] {
        currentQuestion.answers
    }
    
    var currentQuestion: Question {
        Question.all[questionIndex]
    }
    
    var questionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rangedSlider.maximumValue = 0.99999
        updateUI()
    }
    
    // MARK: - Update User Interface
    
    func updateUI () {
        
        func updateSingleStack () {
            singleStackView.isHidden = false
            for (index, button) in singleButtons.enumerated() {
                button.setTitle(nil, for: [])
                button.tag = index
            }
            for (button, answer) in zip(singleButtons, currentAnswers) {
                button.setTitle(answer.text, for: [])
            }
        }
        
        // MARK: - Update stacks
        
        func updateMultiplyStack () {
            multiplyStackView.isHidden = false
            for label in multiLabel {
                label.text = nil
            }
            for (label, answer) in zip(multiLabel, currentAnswers) {
                label.text = answer.text
            }
        }
        
        func updateRangeStack () {
            rangedStackView.isHidden = false
            rangeLabel.first?.text = currentAnswers.first?.text
            rangeLabel.last?.text = currentAnswers.last?.text
            print("\(currentQuestion)")
        }
        
        func updateImageStack() {
            imageStackView.isHidden = false
            let images = (0...3).compactMap { UIImage(named: "image\($0)") }
            
            for (index, button) in imageButtons.enumerated() {
                button.setTitle(nil, for: [])
                button.tag = index
                
                for (button, image) in zip(imageButtons, images) {
                    button.setBackgroundImage(image, for: UIControl.State.normal)
                    
                    for (button, answer) in zip(imageButtons, currentAnswers) {
                        button.setTitle(answer.text, for: [])
                        
                    }
                }
            }
        }
        
        for stackView in [singleStackView, multiplyStackView, rangedStackView, imageStackView] {
            stackView?.isHidden = true
        }
        
        let currentQuestion = Question.all[questionIndex]
        let totalProgress = Float(questionIndex) / Float(Question.all.count)
        
        
        // MARK: - Update navigationItem, questionLabel, questionProgressView:
        
        navigationItem.title = "Вопрос № \(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack()
        case .multiply:
            updateMultiplyStack()
        case .range:
            updateRangeStack()
        case .imageSingle:
            updateImageStack()
        }
    }
    
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < Question.all.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results segue", sender: nil)
        }
    }
    
    // MARK: - Actions:
    
    @IBAction func singleButtonPressed(_ sender: UIButton) {
        let answers = Question.all[questionIndex].answers
        let index = sender.tag
        guard  0 <= index && index < answers.count else {
            return
        }
        let answer = answers[index]
        answersChosen.append(answer)
        nextQuestion()
    }
    
    @IBAction func multiButtonPressed () {
        print(#line, #function)
        for (index, multiSwitch) in multiSwitch.enumerated(){
            if multiSwitch.isOn && index < currentAnswers.count {
                let answer = currentAnswers[index]
                answersChosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangeButtonPressed () {
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        if index < currentAnswers.count {
            let answer = currentAnswers[index]
            answersChosen.append(answer)
        }
        nextQuestion()
    }
    
    @IBAction func imageButtonPressed(_ sender: UIButton) {
        
        let answers = Question.all[questionIndex].answers
        let index = sender.tag
        guard  0 <= index && index < answers.count else {
            return
        }
        let answer = answers[index]
        answersChosen.append(answer)
        nextQuestion()
    }
    
    @IBSegueAction func resultsSegue(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, answers: answersChosen)
    }
    
}

