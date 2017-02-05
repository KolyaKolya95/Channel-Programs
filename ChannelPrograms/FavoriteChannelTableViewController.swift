//
//  FavoriteChannelTableViewController.swift
//  ChannelPrograms
//
//  Created by Kolya on 31.01.17.
//  Copyright © 2017 Kolya. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteChannelTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    lazy var ArrayFavorite: Results<FavoriteChannelsData> = {self.realm.objects(FavoriteChannelsData.self)}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(ArrayFavorite.count)
        return self.ArrayFavorite.count
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete{
            try! realm.write {
                self.realm.delete(self.ArrayFavorite[indexPath.row])
            }
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteChannelTableViewCell", for: indexPath) as! FavoriteChannelTableViewCell
        
        let url = self.ArrayFavorite[indexPath.row].image
        
        cell.titleFavorite.text = self.ArrayFavorite[indexPath.row].title
       
        cell.imageFavorite.downloadFrom(url: URL(string: url)!)
        
        return cell
    }
    
}
