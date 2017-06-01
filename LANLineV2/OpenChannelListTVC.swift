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
    self.refreshAll()
    
    let addButton = self.navigationItem.rightBarButtonItem!
    addButton.target = self
    addButton.action = #selector(self.addButtonWasTapped(sender:))
  }
  
  func addButtonWasTapped(sender: UIBarButtonItem)
  {
    let popover = CreateChannelPopoverViewController.instantiateFromStoryboard()
    popover.createdChannelDelegate = self
    popover.popoverPresentationController?.barButtonItem = sender
    present(popover, animated: true, completion: nil)
  }

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
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
  
  fileprivate func refreshAll() {
    self.openChannelListQuery = SBDOpenChannel.createOpenChannelListQuery()
    self.channels.removeAll()
    self.tableView.reloadData()
    
    loadNextPage()
  }
  
  fileprivate func loadNextPage()
  {
    guard let query = self.openChannelListQuery, !query.isLoading() else { return }
    query.limit = 20
    
    query.loadNextPage(completionHandler: { (channels, error) in
      defer {
        DispatchQueue.main.async {
          self.refreshControl?.endRefreshing()
        }
      }
      
      
      if error != nil {
        let vc = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ErrorTitle"), message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
        let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
        vc.addAction(closeAction)
        DispatchQueue.main.async {
          self.present(vc, animated: true, completion: nil)
        }
        
        return
      }
      
      guard let channels = channels else { return }
      
      for channel in channels
      {
        self.channels.append(channel)
      }
      
      DispatchQueue.main.async {
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
  // MARK: - Prepare For Segue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "EnterChatSegue"
    {
      let chatVC = segue.destination as! OpenChatVC
      let selectedCell = sender as! OpenChannelListCell
      let indexPath = tableView.indexPath(for: selectedCell)!
      let aChannel = channels[indexPath.row]
      chatVC.channel = aChannel
    }
  }

  override func scrollViewDidScroll(_ scrollView: UIScrollView)
  {
    let smoothLoadingOffset: CGFloat = 100
    let loadingThreshold = ((scrollView.contentSize.height - scrollView.frame.size.height) - smoothLoadingOffset)

    if scrollView.contentOffset.y >= loadingThreshold
    {
      // get the next 20
      loadNextPage()
    }
  }
}

extension OpenChannelListTVC: DidCreateChannelProtocol
{
  func createChannelButtonTapped()
  {
    refreshAll()
  }
}




