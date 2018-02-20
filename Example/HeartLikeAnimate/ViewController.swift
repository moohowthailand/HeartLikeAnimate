//
//  ViewController.swift
//  HeartLikeAnimate
//
//  Created by methawin on 02/14/2018.
//  Copyright (c) 2018 methawin. All rights reserved.
//

import UIKit
import AVFoundation
import HeartLikeAnimate

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var player: AVAudioPlayer?
    var timeClicked:Date?
    var timeReleased:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.imageView = HeartAnimate().animateInit(imageView: imageView)
        let tapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(imageHold(tapGestureRecognizer:)))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageClick(tapGestureRecognizer:)))
        imageView?.isUserInteractionEnabled = true
        imageView?.addGestureRecognizer(tapGestureRecognizer)
        imageView?.addGestureRecognizer(tapGestureRecognizer2)
        guard let url = Bundle.main.url(forResource: "heartsound", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func imageHold(tapGestureRecognizer: UIPinchGestureRecognizer) {
        switch tapGestureRecognizer.state {
        case .began:
            timeClicked = Date()
            self.imageView = HeartAnimate().animateHoldStart(likeValue: 0, imageView: imageView)
            HeartAnimate().playSound(player: self.player!, currentLike: 0)
        case .ended:
            timeReleased = Date()
            self.imageView = HeartAnimate().animateHoldStop(currentLike: 0,imageView: imageView ,timeClicked: timeClicked! , timeReleased: timeReleased!)
            HeartAnimate().stopSound(player: player!)
            print(imageView.tag)
        default: break
        }
    }
    
    @objc func imageClick(tapGestureRecognizer: UITapGestureRecognizer) {
        self.imageView = HeartAnimate().animateClickStart(likeValue: 0, imageView: imageView)
    }
    
    func initSound(player:AVAudioPlayer) {
        guard let url = Bundle.main.url(forResource: "heartsound", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        } catch let error {
            print(error.localizedDescription)
        }
    }

}

