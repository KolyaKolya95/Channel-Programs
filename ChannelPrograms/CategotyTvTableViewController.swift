//
//  CategotyTvTableViewController.swift
//  ChannelPrograms
//
//  Created by Kolya on 30.01.17.
//  Copyright © 2017 Kolya. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper

class CategotyTvTableViewController: UITableViewController {

    
    var categotyArray = [AllCategoryModel]()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let URL = "http://52.50.138.211:8080/ChanelAPI/categories"
    
        Alamofire.request(URL).responseArray { (response: DataResponse<[AllCategoryModel]>) in
            
            let categorylArray = response.result.value
            
            if let categorylArray = categorylArray {
                for category in categorylArray {
                     self.categotyArray.append(category)
                }
                   self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.categotyArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        
        cell.titleCategory.text = self.categotyArray[indexPath.row].title
        
        return cell
    }
    
}
