//
//  FavoriteChannelTableViewController.swift
//  ChannelPrograms
//
//  Created by Kolya on 31.01.17.
//  Copyright © 2017 Kolya. All rights reserved.
//

import UIKit

class FavoriteChannelTableViewController: UITableViewController {

    var nameChannel : String = ""
    
    var ArrayFavorite = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  ArrayFavorite.append(SaveChannel)
         //print("\(nameChannel)")
         print(self.ArrayFavorite.count)
        self.tableView.reloadData()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ArrayFavorite.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteChannelTableViewCell
        cell.titleFavorite.text = self.ArrayFavorite[indexPath.row]
        return cell
    }
}
