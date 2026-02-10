//
//  JokeViewController.swift
//  ikid
//
//  Created by Katharina Cheng on 2/9/26.
//
import UIKit

struct Joke {
    let q: String
    let a: String
}

final class JokeViewController: UIViewController {



    @IBOutlet weak var jokeLabel: UILabel!
    
    private var showingAnswer = false
    private var index = 0
    private var jokes: [Joke] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        jokeLabel.numberOfLines = 0
        jokeLabel.textAlignment = .center

        loadJokesForThisTab()
        showQuestion()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // refresh when switching tabs
        loadJokesForThisTab()
        index = 0
        showingAnswer = false
        showQuestion()
    }

    private func loadJokesForThisTab() {
        let tag = tabBarItem.tag

        switch tag {
        case 0: // Good
            jokes = [
                Joke(q: "Why don’t skeletons fight each other?",
                     a: "They don’t have the guts.")
            ]
        case 1: // Pun
            jokes = [
                Joke(q: "I used to be addicted to the hokey pokey…",
                     a: "But I turned myself around.")
            ]
        case 2: // Dad
            jokes = [
                Joke(q: "Why did the math book look so sad?",
                     a: "Because it had too many problems.")
            ]
        default:
            jokes = [Joke(q: "No jokes loaded.", a: "Set tabBarItem.tag to 0/1/2.")]
        }
    }

    @IBAction func nextTapped(_ sender: UIButton) {
        guard !jokes.isEmpty else { return }

        if showingAnswer {
            index = (index + 1) % jokes.count
            showQuestion(animated: true)
        } else {
            showAnswer(animated: true)
        }
        showingAnswer.toggle()
    }

    private func showQuestion(animated: Bool = false) {
        setText("Q: \(jokes[index].q)", animated: animated)
    }

    private func showAnswer(animated: Bool = false) {
        setText("A: \(jokes[index].a)", animated: animated)
    }

    private func setText(_ text: String, animated: Bool) {
        if animated {
            UIView.transition(with: jokeLabel,
                              duration: 0.35,
                              options: .transitionFlipFromRight,
                              animations: { self.jokeLabel.text = text },
                              completion: nil)
        } else {
            jokeLabel.text = text
        }
    }
}
