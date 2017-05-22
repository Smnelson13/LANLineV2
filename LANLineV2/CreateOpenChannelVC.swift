//
//  CreateOpenChannelVC.swift
//  
//
//  Created by Shane Nelson on 5/22/17.
//
//

import UIKit
import SendBirdSDK

class CreateOpenChannelVC: UIViewController
{
  @IBOutlet weak var channelNameTextField: UITextField!

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
 
  @IBAction func doneButtonTapped(_ sender: Any)
  {
    self.dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func createButtonTapped(_ sender: Any)
  {
    
  }
  

 
  
}
