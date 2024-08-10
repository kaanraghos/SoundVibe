//
//  ShowMyMusicViewController.swift
//  Comp
//
//  Created by Kaan Uzun on 9.05.2024.
//

import UIKit
import FirebaseFirestore


class ShowMyMusicViewController: UIViewController {
    //database variable from the firebase.
    let db = Firestore.firestore()
    
    var moodScore: String? = nil // Mood category received from MoodQuizViewController (optional)
    private let titleLabel = UILabel()
    let closeImage = UIImage(systemName: "xmark") //X symbol from SF category.
    private let songNameLabel = UILabel()
    private let songArtistLabel = UILabel()
    private let lblDescription = UILabel()
    private let lblAltDescription = UILabel()
    private var btnSong = UIButton()
    private var btnArtist = UIButton()
    let stackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Title for the view (optional)
        self.title = "MyMood Music"
        // Close button in navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(backToRoot))
        view.backgroundColor = .systemBackground
        print("moodScore: \(moodScore!)")
        setupUI()
        fetchAndDisplaySong()
    }
    
    func setupUI() {
        lblDescription.text = "Here is your song for your current mood according the quiz result \(moodScore!)..."
        lblDescription.numberOfLines = 0
        lblDescription.translatesAutoresizingMaskIntoConstraints = false // Important!
        lblDescription.textAlignment = .center
        lblDescription.textColor = .systemGray
        view.addSubview(lblDescription)
        // Constraints
        NSLayoutConstraint.activate([
            lblDescription.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 20),
            lblDescription.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20),
            lblDescription.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20)
        ])
        
        
        // Configure btnSong
        btnSong.backgroundColor = .systemGreen // Set button's background color
        btnSong.addTarget(self, action: #selector(backToRoot), for: .touchUpInside) // Add action
        btnSong.translatesAutoresizingMaskIntoConstraints = false // Important: Set to false to use Auto Layout
        btnSong.titleLabel?.textAlignment = .center
        btnSong.layer.cornerRadius = 15
        btnSong.layer.masksToBounds = true
        view.addSubview(btnSong) // Add the button to the view hierarchy
        
        // Add Button Constraints
        NSLayoutConstraint.activate([
            btnSong.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnSong.topAnchor.constraint(equalTo: lblDescription.bottomAnchor, constant: 150), // Adjust the vertical position as needed
            btnSong.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            btnSong.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60)
        ])
        
        // Configure btnSong
        btnArtist.backgroundColor = .systemGreen // Set button's background color
        btnArtist.addTarget(self, action: #selector(backToRoot), for: .touchUpInside) // Add action
        btnArtist.translatesAutoresizingMaskIntoConstraints = false // Important: Set to false to use Auto Layout
        btnArtist.titleLabel?.textAlignment = .center
        btnArtist.layer.cornerRadius = 15
        btnArtist.layer.masksToBounds = true
        view.addSubview(btnArtist) // Add the button to the view hierarchy
        
        // Add Button Constraints
        NSLayoutConstraint.activate([
            btnArtist.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnArtist.topAnchor.constraint(equalTo: btnSong.bottomAnchor, constant: 10), // Adjust the vertical position as needed
            btnArtist.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            btnArtist.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60)
        ])
        
        lblAltDescription.text = "Click the song to go back to main page and search it!"
        lblAltDescription.numberOfLines = 0
        lblAltDescription.translatesAutoresizingMaskIntoConstraints = false // Important!
        lblAltDescription.textAlignment = .center
        lblAltDescription.textColor = .systemGreen
        view.addSubview(lblAltDescription)
        // Constraints
        NSLayoutConstraint.activate([
            lblAltDescription.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -50),
            lblAltDescription.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20),
            lblAltDescription.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20)
        ])
    }
    
    
    
    
    func fetchAndDisplaySong() {
        // Access Firestore based on mood category
        guard let moodCategory = moodScore else { return } // Handle missing mood category
        db.collection("quizSongs")
            .whereField("songMood", isEqualTo: moodCategory)
            .getDocuments { [self] (querySnapshot, error) in
                if let error = error {
                    print("Error getting songs: \(error)")
                } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                    // Pick a random song from the filtered results
                    let randomIndex = Int.random(in: 0..<documents.count)
                    let selectedSong = documents[randomIndex]
                    let songData = selectedSong.data()
                    // Extract and display song details (assuming "songName" and "songArtist" fields exist)
                    if let songName = songData["songName"] as? String,
                       let songArtist = songData["songArtist"] as? String {
                        let message = "Your mood music is:\n\"*\(songName)*\" by \(songArtist)"
                        displaySongInfo(message: message)
                        //-------------
                        print("songName: \(songName)")
                        print("songArtist: \(songArtist)")
                        //-------------
                        self.btnSong.setTitle("\(songName)", for: .normal)
                        self.btnArtist.setTitle("By - \(songArtist)", for: .normal)
                    }
                } else {
                    // Handle no songs found for the mood category
                    displaySongInfo(message: "No songs found for your mood!")
                }
            }
    }
    
    func displaySongInfo(message: String) {
        let alert = UIAlertController(
          title: "Oops, there is an error right now, try again later!",
          message: "\(message)",
          preferredStyle: .alert)

        //Hit OK and close the QuizPage
        alert.addAction(UIAlertAction(
          title: "Back To Home",
          style: .default,
          handler: { action in
            self.navigationController?.popToRootViewController(animated: true)
          }))
    }
    
    //going back to main navigation page.
    @objc func backToRoot(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
