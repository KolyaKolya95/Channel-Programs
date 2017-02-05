//
//  CategoryFindTableViewController.swift
//  ChannelPrograms
//
//  Created by Kolya on 04.02.17.
//  Copyright © 2017 Kolya. All rights reserved.
//

import UIKit
import RealmSwift
import SVProgressHUD

class CategoryFindTableViewController: UITableViewController{

    var idForFound = 0
    
    let realm = try! Realm()
    
    lazy var ArrayChannel: Results<ChannelData> = { self.realm.objects(ChannelData.self) }()
    
    lazy var ArrayFavorite: Results<FavoriteChannelsData> = {self.realm.objects(FavoriteChannelsData.self)}()
    
    var FindChannelArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(ArrayChannel.count)
        for channel in ArrayChannel {

            print(ArrayChannel)
            if  channel.category_id == idForFound {
                self.FindChannelArray.append(channel.name)
                print(channel.name)
            }
        }
        self.tableView.reloadData()
         print(idForFound)
    }

    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }

    @IBAction func BackCategory(_ sender: Any) {
         let _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         print(self.FindChannelArray.count)
        return self.FindChannelArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindFilmCategoryTableViewCell", for: indexPath) as! FindFilmCategoryTableViewCell
        
        let url = self.ArrayChannel[indexPath.row].picture
        
        cell.titleTv.text = self.ArrayChannel[indexPath.row].name
        
        cell.tvImages.downloadFrom(url: URL(string: url)!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SVProgressHUD.showSuccess(withStatus: "Good")
        
        let cellFavorite = self.ArrayChannel[indexPath.row]
        
        try! self.realm.write() {
            let newChannel = FavoriteChannelsData()
            newChannel.id = "\(cellFavorite.idChannel)"
            newChannel.title = cellFavorite.name
            newChannel.image = cellFavorite.picture
            
            print(newChannel.title)
            
            self.realm.add(newChannel, update: true)
        }
        self.ArrayFavorite = self.realm.objects(FavoriteChannelsData.self)
    }
 }
