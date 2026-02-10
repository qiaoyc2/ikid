//
//  JokeViewController.swift
//  ikid
//
//  Created by Katharina Cheng on 2/9/26.
//

import UIKit

struct Joke {
    let question: String
    let answer: String
    let imageName: String? // optional for extra credit
}

final class JokeViewController: UIViewController {

    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!

    var jokes: [Joke] = []
    private var index = 0
    private var showingAnswer = false

    override func viewDidLoad() {
        super.viewDidLoad()
        jokeLabel.textAlignment = .center
        jokeLabel.numberOfLines = 0
        showQuestion()
    }

    @IBAction func nextTapped(_ sender: UIButton) {
        if showingAnswer {
            index = (index + 1) % jokes.count
            showQuestion(animated: true)
        } else {
            showAnswer(animated: true)
        }
    }

    private func showQuestion(animated: Bool = false) {
        showingAnswer = false
        setLabelText(jokes[index].question, animated: animated)
    }

    private func showAnswer(animated: Bool = false) {
        showingAnswer = true
        setLabelText(jokes[index].answer, animated: animated)
    }

    private func setLabelText(_ text: String, animated: Bool) {
        guard animated else {
            jokeLabel.text = text
            return
        }
        UIView.transition(with: jokeLabel,
                          duration: 0.35,
                          options: .transitionFlipFromRight,
                          animations: { self.jokeLabel.text = text },
                          completion: nil)
    }
}

