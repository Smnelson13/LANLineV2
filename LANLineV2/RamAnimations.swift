//
//  RamAnimations.swift
//  
//
//  Created by Shane Nelson on 5/30/17.
//
//

import Foundation
import RAMAnimatedTabBarController

class Animations: RAMItemAnimation
{
  override func playAnimation(_ icon: UIImageView, textLabel: UILabel)
  {
    playBounceAnimation(icon)
    textLabel.textColor = textSelectedColor
  }
  
  override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor)
  {
    textLabel.textColor = UIColor.white
  }
  
  override func selectedState(_ icon: UIImageView, textLabel: UILabel)
  {
    textLabel.textColor = textSelectedColor
  }
  
  func playBounceAnimation(_ icon : UIImageView) {
    
    let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    bounceAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
    bounceAnimation.duration = TimeInterval(duration)
    bounceAnimation.calculationMode = kCAAnimationCubic
    
    icon.layer.add(bounceAnimation, forKey: "bounceAnimation")
  }
}
 
