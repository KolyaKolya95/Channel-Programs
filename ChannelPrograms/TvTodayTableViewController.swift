//
//  TvTodayTableViewController.swift
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




class TvTodayTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        func downloadPrograms(for timestamp: Date.ReferenceType) {
//            Alamofire.request(URL(string: "http://52.50.138.211:8080/ChanelAPI/programs/\(timestamp)")!).responseObject
//                { (response: DataResponse<PrograToDayModel>) in
//                    
//                    let programArray = response.result.value
//                    
//                    if let programArray = programArray {
//                        for program in programArray {
//                            print(program.id as Any)
//                           
//                        }
//                    }
//            }
//        }
      
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
}
