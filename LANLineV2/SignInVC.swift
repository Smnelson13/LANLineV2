//
//  SignInVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/22/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SendBirdSDK
import SVProgressHUD
import CoreData

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
    loggingIn()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  {
    loggingIn()
    return false
  }

  func loggingIn()
  {
    if let text = userIdTextField.text
    {
      SVProgressHUD.show(withStatus: "Logging in...")
      SBDMain.connect(withUserId: text, completionHandler: { (user, error) in
        let success = (user != nil)
        
        if success {
          SVProgressHUD.showSuccess(withStatus: "Logged in!")
        } else {
          SVProgressHUD.showError(withStatus: error.debugDescription)
        }
        
        SVProgressHUD.dismiss(after: 1) {
          
          if success
          {
            self.performSegue(withIdentifier: "signInSegue", sender: nil)
          }
        }
      })
    }
  }
  
  // MARK: - Core Data stack
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "signInUsername")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError?
      {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    
    return container
  }()
  
  func saveContext()
  {
    let context = persistentContainer.viewContext
    if context.hasChanges
    {
      do
      {
        try context.save()
      }
      catch
      {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }

}
