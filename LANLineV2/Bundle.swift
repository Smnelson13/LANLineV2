//
//  Bundle.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/22/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import Foundation
import SVProgressHUD

extension Bundle {
  static func sbBundle() -> Bundle {
    return Bundle(for: SignInVC.self)
  }
  
  static func sbResourceBundle() -> Bundle {
    let bundleResourcePath = Bundle.sbBundle().resourcePath
    let assetPath = bundleResourcePath?.appending("/SendBird-iOS.bundle")
    return Bundle(path: assetPath!)!
  }
  
  static func sbLocalizedStringForKey(key: String) -> String {
    return NSLocalizedString(key, tableName: "Localizable", bundle: Bundle.sbResourceBundle(), comment: "")
  }
}

extension SVProgressHUD {
  static func dismiss(after delay: TimeInterval, completion:@escaping() -> Void = {}) {
    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
      timer.invalidate()
      completion()
      SVProgressHUD.dismiss()
    }
  }
}

extension UIColor {
  static var primaryPurple: UIColor {
    return UIColor(red:0.23, green:0.21, blue:0.38, alpha:1.00)
  }
}

//extension UIFont {
//  static func primaryFont(
//}
