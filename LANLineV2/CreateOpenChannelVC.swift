//
//  CreateOpenChannelVC.swift
//  
//
//  Created by Shane Nelson on 5/22/17.
//
//

import UIKit
import SendBirdSDK

class CreateOpenChannelVC: UIViewController, UITextFieldDelegate
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
    func createOpenChannel()
    {
      if self.channelNameTextField.text?.characters.count == 0
      {
        return
      }
      
      SBDOpenChannel.createChannel(withName: self.channelNameTextField.text, coverUrl: nil, data: nil, operatorUsers: nil) { (channel, error) in
        if error != nil
        {
          let vc = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "OpenChannelCreatedTitle"), message: Bundle.sbLocalizedStringForKey(key: "OpenChannelCreatedMessage"), preferredStyle: UIAlertControllerStyle.alert)
          let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
          vc.addAction(closeAction)
            
          })
        }
      }
      
      
    }
  }
  

 
  
//}





