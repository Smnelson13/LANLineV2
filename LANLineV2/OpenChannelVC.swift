//
//  OpenChannelVC.swift
//  
//
//  Created by Shane Nelson on 5/21/17.
//
//

import UIKit
import SendBirdSDK

class OpenChannelVC: UITableViewController, CreateOpenChannelViewControllerDelegate  //, AddOpenChannelVC
{

  private var channels: [SBDOpenChannel] = []
  private var openChannelListQuery: SBDOpenChannelListQuery? // ONLY WAY TO GET IT TO STOP THOWING AN ERROR WAS TO UNRWRAP
  
  override func viewDidLoad()
  { super.viewDidLoad()
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
//    self.tableView.addSubview(OpenChannelListTableViewCell.nib(), forCellReuseIdentifier: OpenChannelListTableViewCell.cellReuseIdentifier())
    
 
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
      return 0
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
      // #warning Incomplete implementation, return the number of rows
      return 0
  }
  
  @IBAction func addButtonTapped(_ sender: Any)
  {
   
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

  
  func refreshView(vc: UIViewController)
  {
    self.refreshChannelList()
  }

  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
      let cell = tableView.dequeueReusableCell(withIdentifier: "OpenChannelListTableViewCell", for: indexPath) as! OpenChannelListTableViewCell

  

      return cell
  }
  

  /*
  // Override to support conditional editing of the table view.
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      // Return false if you do not want the specified item to be editable.
      return true
  }
  */

  /*
  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          // Delete the row from the data source
          tableView.deleteRows(at: [indexPath], with: .fade)
      } else if editingStyle == .insert {
          // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
      }    
  }
  */

  /*
  // Override to support rearranging the table view.
  override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

  }
  */

  /*
  // Override to support conditional rearranging of the table view.
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
      // Return false if you do not want the item to be re-orderable.
      return true
  }
  */

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
  }
  */

}
