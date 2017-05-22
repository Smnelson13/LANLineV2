//
//  SignInVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/22/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SendBirdSDK

class SignInVC: UIViewController, UITextFieldDelegate
{
  
  @IBOutlet weak var userIdTextField: UITextField!
  @IBOutlet weak var nicknameTextField: UITextField!
  

  override func viewDidLoad()
  {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  @IBAction func connectButtonTapped(_ sender: Any)
  {
    SBDMain.connect(withUserId: userIdTextField.text!, accessToken: "b0208a8138659ed9a752fa268ab5fdf025d3614a", completionHandler: { (user, error) in
      // ...
    })
  }
  

}
