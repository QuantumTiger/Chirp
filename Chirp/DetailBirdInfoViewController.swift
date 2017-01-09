//
//  DetailBirdInfoViewController.swift
//  Chirp
//
//  Created by WGonzalez on 12/15/16.
//  Copyright © 2016 Quantum Apple. All rights reserved.
//

import UIKit
import AVFoundation

class DetailBirdInfoViewController: UIViewController
{

    @IBOutlet weak var birdImageView: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var speciesText: UILabel!
    @IBOutlet weak var genText: UILabel!
    @IBOutlet weak var idText: UILabel!
    @IBOutlet weak var continetText: UILabel!
    @IBOutlet weak var locationText: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    var playerItem: AVPlayerItem?
    var player: AVPlayer?
    
    var receiveInfoFrom = AllBirdInfo()
    var name = ""
    var species = ""
    var gen = ""
    var id = ""
    var continent = ""
    
    var urlForSound = ""
    var urlForImage = ""
    var location = ""
    var latitude = ""
    var longitude = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let url = NSURL(string: self.urlForSound)
        playerItem = AVPlayerItem(url : url! as URL)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player!)
        playerLayer.frame = CGRect(x: 0, y: 0, width: 50, height: 10)
        self.view.layer.addSublayer(playerLayer)
        
        playButton.addTarget(self, action: #selector(DetailBirdInfoViewController.playButtonTapped), for: .touchUpInside)
        
        nameText.text = name
        speciesText.text = "Species: " + species
        genText.text = "Gen: " + gen
        idText.text = "ID: " + id
        continetText.text = "Continent: " + continent
        locationText.text = "Location: " + location
        
        if let url = NSURL(string: urlForImage)
        {
            if let data = NSData(contentsOf: url as URL)
            {
                birdImageView.image = UIImage(data: data as Data)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let mapBird = segue.destination as! BirdMapViewController
        mapBird.latitude = latitude
        mapBird.longitude = longitude
        mapBird.location = location
    }
    
    func playButtonTapped(sender: AnyObject)
    {
        if player?.rate == 0
        {
            player!.play()
            playButton.titleLabel?.text = "Playing"
            print("\("playing")")
        }
        else
        {
            player!.pause()
            playButton.titleLabel?.text = "Stopped Playing"
            print("\("paused")")
        }
        
    }
}
