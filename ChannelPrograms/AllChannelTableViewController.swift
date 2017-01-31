//
//  AllChannelTableViewController.swift
//  ChannelPrograms
//
//  Created by Kolya on 31.01.17.
//  Copyright © 2017 Kolya. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper

class AllChannelTableViewController: UITableViewController {

  //  var arrayTable = [AllCnannelModel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let URL = "http://52.50.138.211:8080/ChanelAPI/chanels"
//    
//        Alamofire.request(URL).responseObject { (response: DataResponse<AllCnannelModel>) in
//            
//        //self.tableView.reloadData()
//            
//        }
        
        Alamofire.request("http://52.50.138.211:8080/ChanelAPI/chanels").responseJSON { response in
//            print(response.request as Any)  // original URL request
//            print(response.response as Any) // HTTP URL response
//            print(response.data as Any)     // server data
//            print(response.result)   // result of response serialization
//            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
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
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
   // override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
//        cell.textLabel?.text =
//        return cell
 //   }
}
