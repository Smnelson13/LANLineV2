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
  let blurRadius: CGFloat = 6
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
  }

  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int
  {
      return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return pulses.count
  }
  
  //MARK: - did recieve pulse info.
  func didRecievePulseInfo(results: [Pulse])
  {
    let queue = DispatchQueue.main
    queue.async {
      self.pulses = results
      self.tableView.reloadData()
    }
  }

  //MARK: - cell setup
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: "GameNewsCell", for: indexPath) as! GameNewsCell
    let aPulse = pulses[indexPath.row]
    cell.backGroundImage.image = #imageLiteral(resourceName: "No image available")
    cell.titleLabel.text = aPulse.title
    cell.authorLabel.text = ("Author: " + aPulse.author)
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .short
    dateFormatter.dateStyle = .short
    let createdAtSeconds = Double(aPulse.createAt!) / 1000.0
    let newsCreatedDate = Date(timeIntervalSince1970: createdAtSeconds)
    let messageDateString = dateFormatter.string(from: newsCreatedDate)
    cell.dateLabel.text = ("Published: " + messageDateString)
  
    if let img = imageCache[aPulse.image]
    {
      cell.backGroundImage.image = img
    }
    else
    {
      if let url = URL(string: aPulse.image)
      {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request)
        {
          data, response, error in
          if error == nil
            {
              let image = UIImage(data: data!)
              let blurredImage = image?.applyBlur(withRadius: self.blurRadius, tintColor: UIColor(white: 0.3, alpha: 0.4), saturationDeltaFactor: 1.8, maskImage: nil)
              self.imageCache[(aPulse.image)] = blurredImage
              DispatchQueue.main.sync {
                
                cell.backGroundImage.image = blurredImage
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
