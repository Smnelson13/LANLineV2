//
//  SearchGameTVC.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/15/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit

extension UISearchBar {
  func setup() {
    tintColor = UIColor.primaryPurple
    let cancelButtonAttributes: [String: AnyObject] = [NSForegroundColorAttributeName: UIColor.white]
    UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
    backgroundColor = UIColor.primaryPurple
    barTintColor = UIColor.primaryPurple
  }
}

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

class SearchGameTVC: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating
{
  let blurRadius = 4
  var imageCache = [String: UIImage]()
  var games = [Game]()
  let searchController = UISearchController(searchResultsController: nil)
  var searchDebouncer: Debouncer!
  var apiController: APIController!

  override func viewDidLoad()
  {
    tableView.tableFooterView = UIView()
    super.viewDidLoad(); searchBarSetup()
    apiController = APIController(delegate: self)
    searchDebouncer = Debouncer(delay: 0.25, callback: self.search)
  }
  
  // MARK: - Table view data source
  override var preferredStatusBarStyle: UIStatusBarStyle
  {
    return .lightContent
  }
  
  override func viewWillLayoutSubviews()
  {
    let zContentInsets = UIEdgeInsets.zero
    tableView.contentInset = zContentInsets
    tableView.scrollIndicatorInsets = zContentInsets
  }

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
  }

  override func numberOfSections(in tableView: UITableView) -> Int
  {
      return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
      return games.count
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
  {
    searchBar.showsCancelButton = true
    games.removeAll()
    tableView.reloadData()
    searchBar.text = "" 
  }
  
  //MARK: - search bar setup
  func searchBarSetup()
  {
    searchController.searchBar.tintColor = UIColor.primaryPurple
    let cancelButtonAttributes: [String: AnyObject] = [NSForegroundColorAttributeName: UIColor.white]
    UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
    searchController.searchBar.backgroundColor = UIColor.primaryPurple
    searchController.searchBar.barTintColor = UIColor.primaryPurple
    tableView.tableHeaderView = searchController.searchBar
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    definesPresentationContext = true
    searchController.searchBar.delegate = self
  }
  
  //MARK: - cancel button clicked
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

  //MARK: - search button clicked
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
  {
    if let text = searchController.searchBar.text, text != ""
    {
      apiController.getGameInfo(searchTerm: text)
    }
    else
    {
      games.removeAll()
      tableView.reloadData()
    }

  }
  
  func search()
  {
    if let text = searchController.searchBar.text, text != ""
    {
      apiController.getGameInfo(searchTerm: text)
    }
    else
    {
      games.removeAll()
      tableView.reloadData()
    }
  }

  //MARK: - cell setup
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedGameCell", for: indexPath) as! SearchedGameCell
    let aGame = games[indexPath.row]
    cell.gameTitleLabel.text = aGame.name
    cell.gameCoverImage.image = #imageLiteral(resourceName: "blank-66")
    
    if let img  = imageCache[aGame.coverUrl]
    {
      cell.gameCoverImage.image = img
    }
    else
    {
      if let url = URL(string: aGame.coverUrl)
      {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {
          data, response,error in
          if error == nil
          {
            let image = UIImage(data: data!)
            self.imageCache[(aGame.coverUrl)] = image
            DispatchQueue.main.async {
              cell.gameCoverImage.image = image
            }
          }
        }.resume()
      }
    }

    return cell
  }
  
  //MARK: - prepare for segue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "ShowGameDetailsSegue"
    {
      let gameInfoVC = segue.destination as! GameInfoDetailVC
      let selectedCell = sender as! SearchedGameCell
      let indexPath = tableView.indexPath(for: selectedCell)!
      gameInfoVC.aGame = games[indexPath.row]
    }
  }
  
}

//MARK: - APIController extension
extension SearchGameTVC: APIControllerProtocol
{
  func didReceiveGameInfo(results: [Game])
  {
    let queue = DispatchQueue.main
    queue.async {
      self.games = results
      self.tableView.reloadData()
    }
  }
}
