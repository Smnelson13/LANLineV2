//
//  NewsTVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/27/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit

class NewsTVC: UITableViewController, APIPulseControllerProtocol
{
  var imageCache = [String: UIImage]()
  var pulses = [Pulse]()
  var apiController: APIController!
  
  override func viewDidLoad()
  {
    
    
    super.viewDidLoad()
    
    apiController = APIController(pulseDelegate: self)
    
    apiController.getPulse()
    
    
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
      return pulses.count
  }
  
  func didRecievePulseInfo(results: [Pulse])
  {
    let queue = DispatchQueue.main
    queue.async {
      self.pulses = results
      self.tableView.reloadData()
    }
  }

  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: "GameNewsCell", for: indexPath) as! GameNewsCell
    let aPulse = pulses[indexPath.row]
    cell.backGroundImage.image = #imageLiteral(resourceName: "blank-66")
    cell.titleLabel.text = aPulse.title
    
    if let img = imageCache[aPulse.image]
    {
      cell.backGroundImage.image = img
    }
    else
    {
      if let url = URL(string: aPulse.image)
      {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {
          data, response, error in
          if error == nil
            {
              let image = UIImage(data: data!)
              self.imageCache[(aPulse.image)] = image
              DispatchQueue.main.sync {
                cell.backGroundImage.image = image
              }
          }
        }.resume()
      }
    }
    
       

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





