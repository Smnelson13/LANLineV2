//
//  Bundle.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/21/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import Foundation


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
