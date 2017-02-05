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
        reload()
        
        if ArrayFavorite == nil {
            self.tableView.reloadData()
        }else{
          self.tableView.reloadData()   
        }
        
        print(ArrayFavorite.count)
    }
    
    func reload(){
        DispatchQueue.main.async{
    self.tableView.reloadData()
        }
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
       var cell = self.ArrayFavorite[indexPath.row].title
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
         // cell.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteChannelTableViewCell", for: indexPath) as! FavoriteChannelTableViewCell
    
        let url = self.ArrayFavorite[indexPath.row].image
        
        cell.titleFavorite.text = self.ArrayFavorite[indexPath.row].title
       // cell.imageFavorite.image = self.ArrayFavorite[indexPath.row].image
        
        cell.imageFavorite.downloadFrom(url: URL(string: url)!)
        
        return cell
    }
   
}
