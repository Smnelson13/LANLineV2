//
//  Bundle.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/22/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import Foundation
import SVProgressHUD

extension Bundle
{
  static func sbBundle() -> Bundle
  {
    return Bundle(for: SignInVC.self)
  }
  
  static func sbResourceBundle() -> Bundle
  {
    let bundleResourcePath = Bundle.sbBundle().resourcePath
    let assetPath = bundleResourcePath?.appending("/SendBird-iOS.bundle")
    return Bundle(path: assetPath!)!
  }
  
  static func sbLocalizedStringForKey(key: String) -> String
  {
    return NSLocalizedString(key, tableName: "Localizable", bundle: Bundle.sbResourceBundle(), comment: "")
  }
}

//MARK: - extension progress HUD
extension SVProgressHUD
{
  static func dismiss(after delay: TimeInterval, completion:@escaping() -> Void = {})
  {
    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
      timer.invalidate()
      completion()
      SVProgressHUD.dismiss()
    }
  }
}

//MARK: - extension custom colors
extension UIColor
{
  static var banananaGold: UIColor
  {
    return UIColor(red:0.92, green:0.85, blue:0.30, alpha:1.0)
  }
  static var primaryPurple: UIColor
  {
    return UIColor(red:0.23, green:0.21, blue:0.38, alpha:1.00)
  }
}

