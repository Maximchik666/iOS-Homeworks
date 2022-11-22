//
//  MediaViewController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 22.11.2022.
//

import Foundation
import AVFoundation
import UIKit

class MediaViewController: UIViewController {
    
    weak var coordinator: MediaTabCoordinator?
    
    private let tracks = ["Шедевр 01","Шедевр 02", "Шедевр 03", "Шедевр 04", "Шедевр 05"]
    private var trackCount = 0
    
    private var audioPlayer = AVAudioPlayer()
    private lazy var playButton =  PlayerButton(image: UIImage(systemName: "play.fill")!)
    private lazy var stopButton = PlayerButton(image: UIImage(systemName: "stop.fill")!)
    private lazy var nextButton = PlayerButton(image: UIImage(systemName: "arrowshape.right.fill")!)
    private lazy var previousButton = PlayerButton(image: UIImage(systemName: "arrowshape.left.fill")!)
    
    
    private lazy var musicLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "music.note")
        image.tintColor = .systemCyan
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var controlsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 30
        stack.alignment = .center
        return stack
    }()
    
    private lazy var trackTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        addActionsToPlayButton()
        addActionToStopButton()
        preparePlayer(trackName: tracks[trackCount])
        setupViews()
        navBarCustomization()
        addActionToNextButton()
        addActionToPreviousButton()
    }
    
    private func addActionsToPlayButton() {
        playButton.action = {
            if !self.audioPlayer.isPlaying {
                self.audioPlayer.play()
                self.playButton.setImage(UIImage(systemName: "pause.fill")!, for: .normal)
            } else {
                self.audioPlayer.pause()
                self.playButton.setImage(UIImage(systemName: "play.fill")!, for: .normal)
            }
        }
    }
    
    
    private func addActionToStopButton() {
        stopButton.action = {
            if self.audioPlayer.isPlaying {
                self.audioPlayer.pause()
                self.playButton.setImage(UIImage(systemName: "play.fill")!, for: .normal)
            }
            self.audioPlayer.currentTime = 0.0
        }
    }
    
    private func addActionToNextButton(){
        
        nextButton.action = {
            self.audioPlayer.stop()
            if self.trackCount < self.tracks.count - 1 {
                self.trackCount += 1
            } else {self.trackCount = 0}
                
            self.preparePlayer(trackName: self.tracks[self.trackCount])
            self.audioPlayer.play()
        }
    }
    
    private func addActionToPreviousButton(){
        
        previousButton.action = {
            self.audioPlayer.stop()
            if self.trackCount != 0 {
                self.trackCount -= 1
            } else {self.trackCount = self.tracks.count - 1}
            
            self.preparePlayer(trackName: self.tracks[self.trackCount])
            self.audioPlayer.play()
        }
    }
    
    private func preparePlayer (trackName: String) {
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: trackName, ofType: "mp3")!))
            self.audioPlayer.prepareToPlay()
        }
        catch {
            print(error)
        }
        trackTitle.text = trackName
    }
    
    private func setupViews() {
        view.addSubview(musicLogo)
        view.addSubview(controlsStack)
        view.addSubview(trackTitle)
        
        controlsStack.addArrangedSubview(previousButton)
        controlsStack.addArrangedSubview(playButton)
        controlsStack.addArrangedSubview(stopButton)
        controlsStack.addArrangedSubview(nextButton)
        
        NSLayoutConstraint.activate([
          
            musicLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            musicLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            musicLogo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            musicLogo.heightAnchor.constraint(equalToConstant: 200),
            
            controlsStack.topAnchor.constraint(equalTo: trackTitle.bottomAnchor, constant: 26),
            controlsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playButton.heightAnchor.constraint(equalToConstant: 50),
            playButton.widthAnchor.constraint(equalToConstant: 50),
            
            previousButton.heightAnchor.constraint(equalToConstant: 50),
            previousButton.widthAnchor.constraint(equalToConstant: 50),
            
            stopButton.heightAnchor.constraint(equalToConstant: 50),
            stopButton.widthAnchor.constraint(equalToConstant: 50),
            
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 50),
            
            trackTitle.topAnchor.constraint(equalTo: musicLogo.bottomAnchor, constant: 26),
            trackTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func navBarCustomization () {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "LightGray")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "VKColor")!]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "VKColor")!]
        navigationController?.navigationBar.tintColor = UIColor(named: "VKColor")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Your Media"
    }
}
