//
//  HeartAnimate.swift
//  FBSnapshotTestCase
//
//  Created by Soemsak on 2/14/2561 BE.
//

import Foundation
import UIKit

import Foundation
import UIKit
import AVFoundation

public class HeartAnimate {
    
    public init() {}
    
    var durationSec = 40
    var duration = 0.0
    var imageCount = 225
    var getStart = Int()
    var timer: Timer?
    
    public func animateInit(imageView:UIImageView) -> UIImageView{
        imageView.contentMode = .scaleAspectFit
        var imagesListArray = [UIImage]()
        for imageName in 0..<imageCount {
            let iconName:String
            if imageName < 10 {
                iconName = "Heart0000" + "\(imageName)"
            } else if imageName < 100 {
                iconName = "Heart000" + "\(imageName)"
            } else {
                iconName = "Heart00" + "\(imageName)"
            }
            imagesListArray.append(UIImage(named: "\(iconName)")!)
        }
        imageView.animationImages = imagesListArray
        return imageView
    }
    
    public func animateHoldStart(likeValue:Int , imageView:UIImageView) -> UIImageView{
        let imageCurrentShow = Int((Double(likeValue) * 1.25) +  0.5)
        duration = Double(durationSec * (imageCount - imageCurrentShow))
        duration = duration / 1000
        imageView.isHidden = false
        imageView.contentMode = .scaleAspectFit
        
        print("IMAGE SHOW",imageCurrentShow)
        print("DURATION",duration)
        var imagesListArray = [UIImage]()
        for imageName in likeValue..<imageCount {
            let iconName:String
            if imageName < 10 {
                iconName = "Heart0000" + "\(imageName)"
            } else if imageName < 100 {
                iconName = "Heart000" + "\(imageName)"
            } else {
                iconName = "Heart00" + "\(imageName)"
            }
            imagesListArray.append(UIImage(named: "\(iconName)")!)
        }
        imageView.animationImages = imagesListArray
        imageView.animationDuration = TimeInterval(duration)
        imageView.animationRepeatCount = 1
        imageView.startAnimating()
        return imageView
    }
    
    public func animateHoldStop(currentLike: Int,imageView:UIImageView , timeClicked:Date , timeReleased:Date) -> UIImageView {
        var like = 0
        imageView.stopAnimating()
        like = Int(timeReleased.timeIntervalSince(timeClicked) * 20)
        if currentLike > like {
            like = currentLike
        }
        if like > 100 {
            like = 100
        }
        imageView.tag = like
        return imageView
    }
    
    public func animateClickStart(likeValue:Int , imageView:UIImageView) -> UIImageView{
        let likeCurrent = likeValue + 1
        imageView.isHidden = false
        imageView.contentMode = .scaleAspectFit
        getStart = likeValue * (imageCount / 100)
        var heartName = String()
        if getStart < 10 {
            heartName = "HeartStill0000" + "\(getStart)"
        } else if getStart < 100 {
            heartName = "HeartStill000" + "\(getStart)"
        } else {
            heartName = "HeartStill00" + "\(getStart)"
        }
        let heartImage:UIImage
        heartImage = UIImage(named: heartName)!
        imageView.image = heartImage
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6){
            imageView.image = nil
        }
        imageView.tag = likeCurrent
        return imageView
    }
    
    func playSound(player:AVAudioPlayer ,currentLike:Int) {
        let timeMusic = Double(currentLike * 50)/1000 + 0.1
        player.currentTime = timeMusic
        player.play()
    }
    
    func stopSound(player:AVAudioPlayer) {
        player.stop()
    }
    
}

