//
//  BrainTestViewController.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/23/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SendBirdSDK

class BrainTestViewController: UIViewController
{
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    test()
  }

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
  }
    
  func test()
  {
    SBDOpenChannel.getWithUrl("12233455") { (channel, error) in
      if let error = error as NSError?
      {
        if error.code == 400201
        {
          print("It worked")
        }
        NSLog("Error: %@", error)
        return
      }
      
      
      
      
      
      channel?.enter(completionHandler: { (error) in
        if error != nil {
          NSLog("Error: %@", error!)
          return
        }
        
        // ...
      })
    }
  
  }

}
