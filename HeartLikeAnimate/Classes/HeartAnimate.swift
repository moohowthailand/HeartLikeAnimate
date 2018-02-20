//
//  HeartAnimate.swift
//  FBSnapshotTestCase
//
//  Created by Soemsak on 2/14/2561 BE.
//

import Foundation
import UIKit
import AVFoundation

public class HeartAnimate {
    
    public init() {}
    
    var durationSec = 40
    var duration = 0.0
    var imageCount = 180
    var getStart = Int()
    var timer: Timer?
    
    public func animateInit(imageView:UIImageView) -> UIImageView{
        imageView.alpha = 0.0
        duration = 1
        imageView.isHidden = false
        imageView.contentMode = .scaleAspectFit
        var imagesListArray = [UIImage]()
        for imageName in 0..<imageCount {
            let iconName:String
            if imageName < 10 {
                iconName = "heartpumping0000" + "\(imageName)"
            } else if imageName < 100 {
                iconName = "heartpumping000" + "\(imageName)"
            } else {
                iconName = "heartpumping00" + "\(imageName)"
            }
            imagesListArray.append(UIImage(named: "\(iconName)")!)
        }
        imageView.animationImages = imagesListArray
        imageView.animationDuration = TimeInterval(duration)
        imageView.animationRepeatCount = 1
        imageView.startAnimating()
        return imageView
    }
    
    public func animateHoldStart(likeValue:Int , imageView:UIImageView) -> UIImageView{
        imageView.alpha = 1.0
        let imageCurrentShow = Int((Double(likeValue) * 1.25) +  0.5)
        duration = Double(durationSec * (imageCount - imageCurrentShow))
        duration = duration / 1000
        imageView.isHidden = false
        imageView.contentMode = .scaleAspectFit
        var imagesListArray = [UIImage]()
        for imageName in likeValue..<imageCount {
            let iconName:String
            if imageName < 10 {
                iconName = "heartpumping0000" + "\(imageName)"
            } else if imageName < 100 {
                iconName = "heartpumping000" + "\(imageName)"
            } else {
                iconName = "heartpumping00" + "\(imageName)"
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
        like = Int(timeReleased.timeIntervalSince(timeClicked) * 20)
        if currentLike > like {
            like = currentLike
        }
        if like > 100 {
            like = 100
        }
        imageView.tag = like
        DispatchQueue.main.asyncAfter(deadline: .now()){
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                imageView.alpha = 0.0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    imageView.stopAnimating()
                }
            }, completion: nil)
        }
        return imageView
    }
    
    public func animateClickStart(likeValue:Int , imageView:UIImageView) -> UIImageView{
        let likeCurrent = likeValue + 1
        imageView.isHidden = false
        imageView.alpha = 1
        imageView.contentMode = .scaleAspectFit
        getStart = likeValue * (imageCount / 100)
        var heartName = String()
        if getStart < 10 {
            heartName = "heartstill0000" + "\(getStart)"
        } else if getStart < 100 {
            heartName = "heartstill000" + "\(getStart)"
        } else {
            heartName = "heartstill00" + "\(getStart)"
        }
        let heartImage:UIImage
        heartImage = UIImage(named: heartName)!
        imageView.image = heartImage
        
        DispatchQueue.main.asyncAfter(deadline: .now()){
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                imageView.alpha = 0.0
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    imageView.image = nil
                }
            }, completion: nil)
        }
        imageView.tag = likeCurrent
        return imageView
    }
    
    public func playSound(player:AVAudioPlayer ,currentLike:Int) {
        let timeMusic = Double(currentLike * 50)/1000 - 0.3
        player.currentTime = timeMusic
        player.play()
    }
    
    public func stopSound(player:AVAudioPlayer) {
        player.stop()
    }
    
}

