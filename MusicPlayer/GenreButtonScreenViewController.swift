//
//  GenreButtonScreenViewController.swift
//  MusicPlayer
//
//  Created by Lucas Werner Kuipers on 24/03/2021.
//  Copyright © 2021 Lucas Werner Kuipers. All rights reserved.
//

import UIKit
import MediaPlayer

class GenreButtonScreenViewController: UIViewController {
    
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction
    
    @IBAction func genreButtonTapped(_ sender: UIButton) {
		
		MPMediaLibrary.requestAuthorization { (status) in
			if status == .authorized {
				self.playGenre(genre: sender.currentTitle!)
			}
		}
    }
	
	@IBAction func randomSongButtonTapped(_ sender: UIButton) {
		
		musicPlayer.stop()
		let query = MPMediaQuery.songs()
		let predicate = MPMediaPropertyPredicate(value: "War Pigs",
												 forProperty: MPMediaItemPropertyTitle,
												 comparisonType: .contains)
		query.addFilterPredicate(predicate)

		guard let items = query.items else { return }
		let collection = MPMediaItemCollection(items: items.shuffled())

		musicPlayer.setQueue(with: collection)
		musicPlayer.prepareToPlay()

		musicPlayer.play()
	}
	
	
    @IBAction func stopButtonTapped(_ sender: UIButton) {
		musicPlayer.stop()
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
		musicPlayer.skipToNextItem()
    }
	
	func playGenre(genre: String) {
		
		musicPlayer.stop()

		let query = MPMediaQuery()
		let predicate = MPMediaPropertyPredicate(value: genre, forProperty: MPMediaItemPropertyGenre)

		query.addFilterPredicate(predicate)

		musicPlayer.setQueue(with: query)
		musicPlayer.shuffleMode = .songs
		musicPlayer.play()
		
	}
}
