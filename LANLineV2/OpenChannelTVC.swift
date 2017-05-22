//
//  OpenChannelTVC.swift
//  
//
//  Created by Shane Nelson on 5/21/17.
//
//

import UIKit
import SendBirdSDK

class OpenChannelTVC: UITableViewController, CreateOpenChannelViewControllerDelegate  //, AddOpenChannelVC
{
  func refreshView(vc: UIViewController)
  {
    self.refreshChannelList()
  }


  private var channels: [SBDOpenChannel] = []
  //internal var refreshControl: UIRefreshControl?
  private var openChannelListQuery: SBDOpenChannelListQuery? // ONLY WAY TO GET IT TO STOP THOWING AN ERROR WAS TO UNRWRAP
  
  override func viewDidLoad()
  { super.viewDidLoad()
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
  
  //  self.refreshControl = self
    self.refreshControl?.addTarget(self, action: #selector(refreshChannelList), for: UIControlEvents.valueChanged)
    
 
  }

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int
  {
      // #warning Incomplete implementation, return the number of sections
      return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
      // #warning Incomplete implementation, return the number of rows
      return channels.count
  }
  
  @IBAction func addButtonTapped(_ sender: Any)
  {
   
  }
  
  func getOpenChannelList()
  {
    let query = SBDOpenChannel.createOpenChannelListQuery()!
    query.loadNextPage(completionHandler: { (channels, error) in
      if error != nil {
        NSLog("Error: %@", error!)
        return
      }
      
      // ...
    })
  }
  
  @objc private func refreshChannelList()
  {
    self.channels.removeAll()
    
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
    
    self.openChannelListQuery = SBDOpenChannel.createOpenChannelListQuery()
    self.openChannelListQuery?.limit = 20
    
    self.openChannelListQuery?.loadNextPage(completionHandler: { (channels, error) in
      if error != nil
      {
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
  
  private func loadChannels()
  {
    if self.openChannelListQuery?.hasNext == false
    {
      return
    }
    
    self.openChannelListQuery?.loadNextPage(completionHandler: { (channels, error) in
      if error != nil {
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
      
      DispatchQueue.main.async
        {
        self.tableView.reloadData()
      }
    })
  }
  
 
  
}
