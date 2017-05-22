//
//  CreateOpenChannelVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/22/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SendBirdSDK
import SVProgressHUD
import Eureka

class CreateOpenChannelVC: UIViewController
{
  @IBOutlet weak var channelNameTextField: UITextField! // JUST IMAGINE THIS SAYS CHANNELNAMETEXTFIELD.... CARRY ON.

  @IBAction func doneButtonTapped(_ sender: Any)
  {
    self.dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad()
  {
      super.viewDidLoad()
  }
  
  @IBAction func createButtonTapped(_ sender: Any)
  {
    if let text = channelNameTextField.text
    {
      SVProgressHUD.show(withStatus: "Creating channel...")
      SBDOpenChannel.createChannel(withName: text, coverUrl: nil, data: nil, operatorUserIds: nil, completionHandler: { (channel, error) in
        SVProgressHUD.showSuccess(withStatus: "Successfully created channel \"\(text)\"")
        
        SVProgressHUD.dismiss(after: 1, completion: {
          self.dismiss(animated: true, completion: nil)
        })
        
        if error != nil {
          NSLog("Error: %@", error!)
          return
        }
        
        // ...
      })
    }
  }
}

class CreateChannelPopoverViewController: FormViewController {
  
  var channelName: String = ""
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    sharedInit()
  }
  
  override init(style: UITableViewStyle) {
    super.init(style: style)
    sharedInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInit()
  }
  
  func sharedInit() {
    preferredContentSize = CGSize(width: 200, height: 150)
    modalPresentationStyle = .popover
    
    if let controller = popoverPresentationController {
      controller.permittedArrowDirections = .any
      controller.delegate = self
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.tintColor = .primaryPurple

    form +++ Section()
    
    <<< TextRow { row in
      row.tag = "textField"
    }.cellSetup { cell, row in
      cell.textField.becomeFirstResponder()
    }.onChange { row in
      self.channelName = row.value ?? ""
    }
      
    <<< ButtonRow { row in
      row.title = "Create Channel"
    }.cellUpdate { cell, row in
      cell.textLabel?.textColor = .primaryPurple
    }.onCellSelection { cell, row in
      self.createChannelButtonWasPressed()
    }
    
    
  }
  
  func createChannelButtonWasPressed() {
    if channelName != ""
    {
      view.endEditing(true)
      
      SVProgressHUD.show(withStatus: "Creating channel...")
      SBDOpenChannel.createChannel(withName: channelName, coverUrl: nil, data: nil, operatorUserIds: nil, completionHandler: { (channel, error) in
        SVProgressHUD.showSuccess(withStatus: "Successfully created channel \"\(self.channelName)\"")
        
        SVProgressHUD.dismiss(after: 1, completion: {
          self.dismiss(animated: true, completion: nil)
        })
        
        if error != nil {
          NSLog("Error: %@", error!)
          return
        }
        
        // ...
      })
    }
  }
}

extension CreateChannelPopoverViewController: UIPopoverPresentationControllerDelegate {
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return .none
  }
}

/*

class CreateChannelPopoverViewController: UIViewController {
  let tableView = UITableView()
  let rowHeight: CGFloat = 48
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    preferredContentSize = CGSize(width: 200, height: rowHeight * 2)
    modalPresentationStyle = .popover
    
    if let controller = popoverPresentationController {
      controller.permittedArrowDirections = .any
      controller.delegate = self
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    preferredContentSize = CGSize(width: 200, height: rowHeight * 2)
    modalPresentationStyle = .popover
    
    if let controller = popoverPresentationController {
      controller.permittedArrowDirections = .any
      controller.delegate = self
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
  }
  
  func setupTableView() {
    view.addSubview(tableView)
    let origin = CGPoint(x: 0, y: 0)
    let frame = CGRect(origin: origin, size: preferredContentSize)

    tableView.frame = frame
  
    tableView.dataSource = self
    tableView.delegate = self
    tableView.isScrollEnabled = false
    
    tableView.register(CreateChannelPopoverViewController.TextFieldCell.self, forCellReuseIdentifier: "textFieldCell")
    tableView.register(CreateChannelPopoverViewController.ButtonCell.self, forCellReuseIdentifier: "buttonCell")
  }
}

extension CreateChannelPopoverViewController: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch Row(rawValue: indexPath.row)! {
    case .textField:
      let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell") as! TextFieldCell
      return cell
    case .button:
      let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell") as! ButtonCell
      cell.label.text = "Create Channel"
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch Row(rawValue: indexPath.row)! {
    case .textField:
      let cell = tableView.cellForRow(at: indexPath) as! TextFieldCell
      cell.textField.becomeFirstResponder()
    case .button:
      // create the channel here
      break;
    }
  }
}

extension CreateChannelPopoverViewController {
  enum Row: Int {
    case textField
    case button
  }
  
  class TextFieldCell: UITableViewCell {
    let textField = UITextField()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      self.sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.sharedInit()
    }
    
    func sharedInit() {
      addSubview(textField)
      
      let buffer: CGFloat = 8
      let frame = CGRect(
        x: buffer, y: 0,
        width: self.frame.width - (buffer * 2), height: self.frame.height
      )
      
      textField.frame = frame
      textField.textColor = .primaryPurple
      textField.borderStyle = .none
    }
  }
  
  class ButtonCell: UITableViewCell {
    let label = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      self.sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.sharedInit()
    }
    
    func sharedInit() {
      addSubview(label)
      
      label.frame = self.frame
      label.textAlignment = .center
      label.textColor = .primaryPurple
    }
  }
}

 SBDOpenChannel.createChannel(withName: self.channelName.text, coverUrl: nil, data: nil, operatorUsers: nil) { (channel, error) in
 if error != nil {
 let vc = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ErrorTitle"), message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
 let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
 vc.addAction(closeAction)
 DispatchQueue.main.async {
 self.present(vc, animated: true, completion: nil)
 }
 
 return
 }
 
 }
 
 }

 */
