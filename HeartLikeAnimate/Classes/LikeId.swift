//
//  LikeId.swift
//  LikeAnimate
//
//  Created by Soemsak on 2/12/2561 BE.
//  Copyright © 2561 Soemsak. All rights reserved.
//

import Foundation
import UIKit

public class LikeId {
    
    var imageCount = 179
    var getStart = Int()
    
    func animateStart(likeValue:Int , imageView:UIImageView) -> UIImageView{
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
    
}
