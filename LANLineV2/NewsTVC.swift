//
//  NewsTVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/27/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SafariServices

class NewsTVC: UITableViewController, APIPulseControllerProtocol, SFSafariViewControllerDelegate
{
  var imageCache = [String: UIImage]()
  var pulses = [Pulse]()
  var apiController: APIController!
  
  
  override func viewDidLoad()
  {
    
    
    super.viewDidLoad()
    UITabBar.appearance().tintColor = .white
    UITabBar.appearance().unselectedItemTintColor = .white
    
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
    cell.authorLabel.text = aPulse.author
  //  cell.summaryTextField.loadHTMLString(aPulse.summary, baseURL: nil)
  //  cell.summaryTextField.isOpaque = false
    
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
  

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    let aPulse = pulses[indexPath.row]
    if let url = URL(string: aPulse.url)
    {
      let svc = SFSafariViewController(url: url)
      svc.delegate = self
      self.present(svc, animated: true, completion: nil)
    }
    
  }
  
}





