//
//  SignInVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/21/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SendBirdSDK
import Foundation

class SignInVC: UIViewController, UITextFieldDelegate
{
  @IBOutlet weak var connectButton: UIButton!
  @IBOutlet weak var userIdTextField: UITextField!
  @IBOutlet weak var nicknameTextField: UITextField!
  @IBOutlet weak var indicatorView: NSLayoutConstraint!

  override func viewDidLoad()
  {
      super.viewDidLoad()

    self.userIdTextField.delegate = self
    self.nicknameTextField.delegate = self
    
    let userId = UserDefaults.standard.object(forKey: "sendbird_user_id") as? String
    let userNickname = UserDefaults.standard.object(forKey: "sendbird_user_nickname") as? String
    
    self.userIdTextField.text = userId
    self.nicknameTextField.text = userNickname
    
  }
  
  @IBAction func connectButtonTapped(_ sender: Any)
  {
    let trimmedUserId: String = (self.userIdTextField.text?.trimmingCharacters(in: NSCharacterSet.whitespaces))!
    let trimmedNickname: String = (self.nicknameTextField.text?.trimmingCharacters(in: NSCharacterSet.whitespaces))!
    
    if trimmedUserId.characters.count > 0 && trimmedNickname.characters.count > 0
    {
      self.userIdTextField.isEnabled = false
      self.nicknameTextField.isEnabled = false
      
    //  self.indicatorView.startAnimation()
      SBDMain.connect(withUserId: trimmedUserId, completionHandler: { (user, error) in
        if error != nil {
          DispatchQueue.main.async {
            self.userIdTextField.isEnabled = true
            self.nicknameTextField.isEnabled = true
            
       //     self.indicatorView.stopAnimation()
          }
          
          let vc = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ErrorTitle"), message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
          let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
          vc.addAction(closeAction)
          DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
          }
          
          return
        }
        
        if SBDMain.getPendingPushToken() != nil
        {
          SBDMain.registerDevicePushToken(SBDMain.getPendingPushToken()!, unique: true, completionHandler: { (status, error) in
            if error == nil {
              if status == SBDPushTokenRegistrationStatus.pending
              {
                print("Push registration is pending.")
              }
              else
              {
                print("APNS Token is registered.")
              }
              
            }
            
            else
            {
              print("APNS registration failed.")
            }
            
          })
        }
        
        SBDMain.updateCurrentUserInfo(withNickname: trimmedNickname, profileUrl: nil, completionHandler: { (error) in
          DispatchQueue.main.async {
            self.userIdTextField.isEnabled = true
            self.nicknameTextField.isEnabled = true
            
        //    self.indicatorView.stopAnimation()
          }
          
          if error != nil
          {
            let vc = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ErrorTitle"), message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
            let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
            vc.addAction(closeAction)
            DispatchQueue.main.async {
              self.present(vc, animated: true, completion: nil)
            }
            
            SBDMain.disconnect(completionHandler: {
              
            })
            
            return
            
          }
          
          
          
        })
        
      })
    }
    
  }
  

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  

  
}


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
