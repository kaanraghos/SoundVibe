//
//  FeelingLuckyViewController.swift
//  SpotifyDemo
//
//  Created by Kaan Uzun on 4.05.2024.
//

import UIKit

class FeelingLuckyViewController: UIViewController {

  let startQuizButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Start the Quiz", for: .normal)
    button.addTarget(self, action: #selector(startQuizTapped), for: .touchUpInside)
    button.backgroundColor = .systemGreen
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
    return button
  }()

  private let descriptionLabel: UILabel = {
          let label = UILabel()
          label.text = "Want to listen to a song according to your mood? Take a quiz to find what mood you are at and start listening!"
          label.numberOfLines = 0 // Allow text to wrap multiple lines
          label.textAlignment = .center
          label.textColor = .secondaryLabel
          return label
      }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    view.addSubview(descriptionLabel)
    descriptionLabel.frame = CGRect(
      x: 20,
      y: 80,
      width: view.width - 40,
      height: 100
    )

    view.addSubview(startQuizButton)
      
      startQuizButton.frame = CGRect(
        x: 90,
        y: 300,
        width: 200,
        height: 75
      )
      startQuizButton.layer.cornerRadius = 15
      startQuizButton.layer.masksToBounds = true
  }

  @objc func startQuizTapped() {
    let quizVC = MoodQuizViewController()
    navigationController?.pushViewController(quizVC, animated: true)
  }
}
