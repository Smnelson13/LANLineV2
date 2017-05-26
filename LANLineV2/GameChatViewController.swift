//
//  GameChatViewController.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/26/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SendBirdSDK
import SlackTextViewController

class GameChatViewController: SLKTextViewController, SBDChannelDelegate
{
  var channel: SBDOpenChannel?
  var aGameChannelUrl: String!
  var baseMessages = [SBDBaseMessage]()
  var kUserMessageCellIdentifier = "UserMessageCell"
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    enterChannel()
    SBDMain.add(self as SBDChannelDelegate, identifier: "GameChatChannel")

      // Do any additional setup after loading the view.
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: kUserMessageCellIdentifier) as! UserMessageCell
    cell.transform = tableView.transform
    if let userMsg = baseMessages[indexPath.row] as? SBDUserMessage
    {
      cell.outputLabel.text = userMsg.message!
    }
    
    return cell
  }

  override func didPressRightButton(_ sender: Any?)
  {
    if let messageString = textView.text, messageString != ""
    {
      sendMessage(message: messageString)
      textView.text = ""
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return baseMessages.count
  }
  
  override class func tableViewStyle(for decoder: NSCoder) -> UITableViewStyle
  {
    return .plain
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    return UITableViewAutomaticDimension
  }

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  func enterChannel()
  {
    SBDOpenChannel.getWithUrl(aGameChannelUrl) { (channel, error) in
      if error != nil {
        NSLog("Error: %@", error!)
        return
      }
      
      channel?.enter(completionHandler: { (error) in
        if error != nil {
          NSLog("Error: %@", error!)
          return
        }
        
        // ...
        print("channel entered successfully")
      })
    }
  }

  func sendMessage(message:String)
  {
    channel?.sendUserMessage(message, data: nil, completionHandler: { (userMessage, error) in
      if error != nil {
        NSLog("Error: %@", error!)
        if let msg = userMessage
        {
          self.baseMessages.insert(msg, at: 0)
        }
        self.tableView?.reloadData()

        return
      }
      
      // ...
    })
  }
  
  func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage)
  {
    baseMessages.insert(message, at: 0)
    self.tableView?.reloadData()
  }
  
  
  deinit
  {
    SBDMain.removeChannelDelegate(forIdentifier: "GameChatChannel")
  }
  
}
