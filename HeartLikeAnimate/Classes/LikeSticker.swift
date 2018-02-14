//
//  LikeSticker.swift
//  LikeAnimate
//
//  Created by Soemsak on 2/12/2561 BE.
//  Copyright © 2561 Soemsak. All rights reserved.
//

import Foundation
import UIKit

public class LikeSticker {
    
    var durationSec = 50
    var duration = 0
    var imageCount = 180
    var getStart = Int()
    
    var timer: Timer?
    
    func animateInit(imageView:UIImageView) -> UIImageView{
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
    
    func animateStart(likeValue:Int , imageView:UIImageView) -> UIImageView{
        let imageCurrentShow = (likeValue * imageCount) / 100
        duration = durationSec * (imageCount - imageCurrentShow)
        duration = duration / 1000
        imageView.isHidden = false
        imageView.contentMode = .scaleAspectFit
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
    
    func animateStop(currentLike: Int,imageView:UIImageView , timeClicked:Date , timeReleased:Date) -> UIImageView {
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
    
    
}
