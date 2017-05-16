//
//  SearchGameTVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/15/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit

class Debouncer
{
  
  private var delay: TimeInterval
  private var timer: Timer?
  private var callback: () -> Void
  
  init(delay: TimeInterval, callback:@escaping() -> Void)
  {
    self.delay = delay
    self.callback = callback
  }
  
  func call()
  {
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false, block: { timer in
      timer.invalidate()
      self.callback()
    })
  }
}


class SearchGameTVC: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating, APIControllerProtocol
{
  
  var games = [Game]()
  let searchController = UISearchController(searchResultsController: nil)
  var searchDebouncer: Debouncer!
  var searchedGames = [Game]()

  override func viewDidLoad()
  {
      super.viewDidLoad()
    tableView.tableHeaderView = searchController.searchBar
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    definesPresentationContext = true
    searchController.searchBar.delegate = self
    
  
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
      return games.count
  }

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
  {
    searchBar.showsCancelButton = true
  }
  
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
  {
    searchBar.text = nil
    searchBar.showsCancelButton = false
    searchBar.endEditing(true)
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
  {
    print("searchText \(searchText)")
    
  }
  
  func updateSearchResults(for searchController: UISearchController)
  {
    
  }

  func didRecieve(results: Any)
  {
    let queue = DispatchQueue.main
    queue.async {
      self.games = Game.gamesWithJSON(json: [results])
      self.tableView.reloadData()
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
  {
    if searchBar.text != ""
    {
     
    }
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedGameCell", for: indexPath)
    let aGame = games[indexPath.row]

    
    
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


}
