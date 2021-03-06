//
//  ResultsViewController.swift
//  Quiz
//
//  Created by Наталья Шарапова on 14.09.2021.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // MARK: - Outlets:
    
    @IBOutlet weak var animalLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var countOfAnswersLabel: UILabel!
    
    // MARK: - Properties:
    
    let answers: [Answer]
    let mostCommonAnswer = ""
    
    init? (coder: NSCoder, answers: [Answer]) {
        self.answers = answers
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("#line, #function init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculatePersonalityResult()
    }
    
    // MARK: - Find most common answer:
    
    func calculatePersonalityResult () {
        let frequencyOfAnswers = answers.reduce(into: [:]) { counts, answer in
            counts[answer.type, default: 0] += 1
        }
        
        let mostCommonAnswer = frequencyOfAnswers.sorted { pair1, pair2 in
            pair1.value > pair2.value }.first!.key
        updateUI(with: mostCommonAnswer)
    }
    
    // MARK: - Update user interface:
    
    func updateUI (with animal: AnimalType) {
        animalLabel.text = "Вы - \(animal.rawValue)"
        descriptionLabel.text = animal.definition
        
        let frOfAnswers = answers.reduce(into: [:]) { counts, answer in
            counts[answer.type.rawValue, default: 0] += 1
        }
        countOfAnswersLabel.text = ("\(frOfAnswers)")
    }
}

