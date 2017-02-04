//
//  CategoryFindTableViewController.swift
//  ChannelPrograms
//
//  Created by Kolya on 04.02.17.
//  Copyright © 2017 Kolya. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryFindTableViewController: UITableViewController{

    var idForFound = 0
    
  //  var ArrayChannel = [ChannelData]()
    
    let realm = try! Realm()
    
    lazy var ArrayChannel: Results<ChannelData> = { self.realm.objects(ChannelData.self) }()
    
    var FindChannelArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(ArrayChannel.count)
        for channel in ArrayChannel {
            print(ArrayChannel)
            if  channel.category_id == idForFound {
                FindChannelArray.append(channel.name)
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         print(self.FindChannelArray.count)
        return self.FindChannelArray.count
       
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindFilmCategoryTableViewCell", for: indexPath) as! FindFilmCategoryTableViewCell
        
        cell.titleTv.text = self.ArrayChannel[indexPath.row].name
        
        
        return cell
    }
 }
