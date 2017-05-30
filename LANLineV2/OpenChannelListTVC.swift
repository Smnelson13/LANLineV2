//
//  OpenChannelListTVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/22/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//
import SendBirdSDK
import UIKit

class OpenChannelListTVC: UITableViewController
{
  private var channels: [SBDOpenChannel] = []
  private var openChannelListQuery: SBDOpenChannelListQuery?
  
  override func viewDidLoad()
  {
      super.viewDidLoad()
    
    self.refreshChannelList()//change this to load channels refresh isnt good to keep calling
    
    
    let addButton = self.navigationItem.rightBarButtonItem!
    addButton.target = self
    addButton.action = #selector(self.addButtonWasTapped(sender:))
  }
  
  func addButtonWasTapped(sender: UIBarButtonItem)
  {
    let popover = CreateChannelPopoverViewController.instantiateFromStoryboard()
    popover.popoverPresentationController?.barButtonItem = sender
    present(popover, animated: true, completion: nil)
  }

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int
  {
      
      return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    
      return channels.count
  }
  
  private func refreshChannelList()
  {
    self.channels.removeAll()
    
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
    
    self.openChannelListQuery = SBDOpenChannel.createOpenChannelListQuery()
    self.openChannelListQuery?.limit = 20
    
    self.openChannelListQuery?.loadNextPage(completionHandler: { (channels, error) in
      if error != nil {
        DispatchQueue.main.async {
          self.refreshControl?.endRefreshing()
        }
        
        let vc = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ErrorTitle"), message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
        let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
        vc.addAction(closeAction)
        DispatchQueue.main.async {
          self.present(vc, animated: true, completion: nil)
        }
        
        return
      }
      
      for channel in channels!
      {
        self.channels.append(channel)
      }
      
      DispatchQueue.main.async {
        self.refreshControl?.endRefreshing()
        self.tableView.reloadData()
      }
    })
  }


  // MARK: - Cell For Row At
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    
      let cell = tableView.dequeueReusableCell(withIdentifier: "OpenChannelListCell", for: indexPath) as! OpenChannelListCell
   
    let aChannel = channels[indexPath.row]
    
    cell.channelNameLabel.text = aChannel.name
    
      return cell
  }
  // Mark: - Prepare For Segue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "EnterChatSegue"
    {
      let chatVC = segue.destination as! OpenChatVC
      let selectedCell = sender as! OpenChannelListCell
      let indexPath = tableView.indexPath(for: selectedCell)!
      let aChannel = channels[indexPath.row]
      chatVC.channel = aChannel
      //chatVC = channels[indexPath.row]
    }
  }


}
