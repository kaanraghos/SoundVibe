//
// MoodQuizViewControllerViewController.swift
// SoundVibe
//
// Created by Kaan Uzun on 4.05.2024.
//

import UIKit
import FirebaseFirestore

class MoodQuizViewController: UIViewController {


  //database variable from the firebase.
  let db = Firestore.firestore()

  private let questionLabel = UILabel()
  private var answerButtons: [UIButton] = [] // Array to hold buttons
  private var currentQuestionIndex = 0 // Start with the first question
  private let titleLabel = UILabel()
  private var userSelections: [Int] = [] // Array to store the weights of selected answers
  private var currentQuestionAnswers: [String: Int]? // Property to hold current question's answers
  private var userSelectionsByQuestion: [[Int]] = [] // Track user's selections for each question


  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Quiz Page"
    //buttonClose()
    //titleButton(title: titleLabel)
    fetchQuestions()
    setupUI()

    view.backgroundColor = .systemBackground
  }

  private func buttonClose(){
    // Create a close button
    let closeButton = UIButton(type: .system)
    closeButton.setTitle("X", for: .normal)
    closeButton.tintColor = .systemGreen
    closeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20) // Adjust font size as needed
    closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    view.addSubview(closeButton)

    // Constraints for the close button
    closeButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
    ])
  }

  private func setupUI() {
    questionLabel.numberOfLines = 0
    questionLabel.translatesAutoresizingMaskIntoConstraints = false // Important!
    view.addSubview(questionLabel)

    // Constraints
    NSLayoutConstraint.activate([
      questionLabel.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor,
        constant: 20),
      questionLabel.leadingAnchor.constraint(
        equalTo: view.leadingAnchor,
        constant: 20),
      questionLabel.trailingAnchor.constraint(
        equalTo: view.trailingAnchor,
        constant: -20)
    ])
    view.addSubview(answerStackView) // Add the stack view
    // Add Stack View Constraints
    NSLayoutConstraint.activate([
      answerStackView.topAnchor.constraint(
        equalTo: questionLabel.bottomAnchor, constant: 20),
      answerStackView.leadingAnchor.constraint(
        equalTo: view.leadingAnchor,
        constant: 50),
      answerStackView.trailingAnchor.constraint(
        equalTo: view.trailingAnchor,
        constant: -100),

      // Add this line for vertical centering
      answerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }

  func fetchQuestions() {
     db.collection("quizQuestions").getDocuments() { [self] (querySnapshot, error) in  //limit(to: 10).order(by: FieldPath.documentID()).
       if let error = error {
         print("Error getting documents: \(error)")
       } else {
         guard let documents = querySnapshot?.documents else { return }

         // Randomly select 10 questions from all documents
               let shuffledDocuments = documents.shuffled()
               let selectedQuestions = Array(shuffledDocuments.prefix(10))

         // Process the fetched questions //querySnapshot!.documents.enumerated()
         for (index, document) in selectedQuestions.enumerated() {
           let questionData = document.data()
           if let questionText = questionData["questionText"] as? String,
                  let answers = questionData["answers"] as? [String: Int] {

                    // Show answers only for the current question
                    if index == currentQuestionIndex {
                      self.questionLabel.text = questionText
                      self.currentQuestionAnswers = answers
                      self.createAnswerButtons(answers: answers)
                    }
                  }
         }

         // Initialize userSelectionsByQuestion after processing the questions
         if userSelectionsByQuestion.isEmpty {
           userSelectionsByQuestion = Array(repeating: [], count: querySnapshot!.documents.count)
         }
       }
     }
   }

  private lazy var answerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical                   // Stack answers vertically
    stackView.distribution = .fillEqually              // Buttons take equal space
    stackView.spacing = 10                     // Adjust spacing as needed
    return stackView
  }()

  private func createAnswerButtons(answers: [String: Int]) {
    // 1. Clear old buttons (if any) before creating new ones
    for button in answerButtons {
      button.removeFromSuperview()
    }
    answerButtons.removeAll()

    // 2. Create new buttons
    var _: UIButton? // Keep track for positioning

    for (answerText, _) in answers {
      let button = UIButton(type: .system)
      button.setTitle(answerText, for: .normal)
      button.backgroundColor = .systemGreen
      button.titleLabel?.textColor = .white
      button.translatesAutoresizingMaskIntoConstraints = false

      // Use a closure to capture the answers parameter
      button.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)

      answerStackView.addArrangedSubview(button) // Add to the stack view
      answerButtons.append(button) // Add to the answerButtons array


      // Constraints for the button
      NSLayoutConstraint.activate([
        button.widthAnchor.constraint(equalTo: answerStackView.widthAnchor, constant: -40) // Adjust for margins
      ])
    }

    // Make sure the stack view is visible and has constraints
    answerStackView.isHidden = false // Ensure visibility
  }

  func calculateMoodScore() -> Int {
    var totalScore = 0
    for selectedWeight in userSelections {
    totalScore += selectedWeight
  }
    return totalScore
  }

  func determineMoodCategory(for moodScore: Int) -> String {
    var moodCategory = "Neutral"
    if moodScore <= 15 {
      moodCategory = "Sad"
    } else if moodScore <= 30 {
      moodCategory = "Okay"
    } else {
      moodCategory = "Happy"
    }
    return moodCategory
  }



  func interpretAndDisplayResult() {
    // Calculate overall mood score
    let moodScore = calculateOverallMoodScore()

    // Determine mood category
    let moodCategory = determineMoodCategory(for: moodScore)
    
    // Display the result
    let alert = UIAlertController(
      title: "Mood Result",
      message: "Your mood score is: \(moodScore)\nYour current mood seems to be: \(moodCategory)",
      preferredStyle: .alert)

    //Hit OK and close the QuizPage
    alert.addAction(UIAlertAction(
      title: "OK",
      style: .default,
      handler: { action in
        self.navigationController?.popToRootViewController(animated: true)
      }))

    //Hit Show My Music and learn your music
    alert.addAction(UIAlertAction(
      title: "Show My Music",
      style: .default,
      handler: { action in
        // Handle the "Show My Music" button tap here
        let showMyMusicVC = ShowMyMusicViewController()
        showMyMusicVC.moodScore = moodCategory
        self.navigationController?.pushViewController(showMyMusicVC, animated: true)
       // self.showMyMusic()
      }))
    present(alert, animated: true, completion: nil)
      
  }


  func showMyMusic() {
    // Implementation for navigating to music section goes here
    let showMyMusicVC = ShowMyMusicViewController()
    navigationController?.pushViewController(showMyMusicVC, animated: true)

    
    print("your music is: Eminem - Rap God")
  }


  func calculateOverallMoodScore() -> Int {
    var totalScore = 0
    for selectedWeights in userSelectionsByQuestion {
      for selectedWeight in selectedWeights {
        totalScore += selectedWeight
      }
    }
    return totalScore
  }

  @objc func answerButtonTapped(_ sender: UIButton) {
    // Update user selections for the current question
        guard let answers = currentQuestionAnswers, let answerText = sender.currentTitle, let answerWeight = answers[answerText] else {
            return
        }
        userSelectionsByQuestion[currentQuestionIndex].append(answerWeight)

        // Update button appearance
        for button in answerButtons {
            button.backgroundColor = (button == sender) ? .systemBlue : .systemGreen
        }

        // Progress to the next question or end the quiz
        if currentQuestionIndex < 9 { // Check if we've reached the 10th question
            currentQuestionIndex += 1
            fetchQuestions()
        } else {
            interpretAndDisplayResult()
        }
  }


  @objc func closeButtonTapped(_ sender: UIButton) {
      self.dismiss(animated: true, completion: nil)
  }

  @objc func nextQuestionTapped(querySnapshot: QuerySnapshot) {
    currentQuestionIndex = (currentQuestionIndex + 1) % querySnapshot.documents.count
    // ^^ Use modulo to wrap back around to the first question
    fetchQuestions() // Refetch to display the new question & answers
  }

}
