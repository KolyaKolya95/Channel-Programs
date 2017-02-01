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

    let timeStamp = NSNumber(value: Date().timeIntervalSinceNow)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timeStamp = NSNumber(value: Date().timeIntervalSinceNow)
        self.downloadPrograms(for: timeStamp)
    }
    
    func downloadPrograms(for timestamp: NSNumber) {
        
        Alamofire.request("http://52.50.138.211:8080/ChanelAPI/programs/\(timestamp)").responseArray { (response: DataResponse<[PrograToDayModel]>) in
            
            let programlArray = response.result.value
            
            if let programlArray = programlArray {
                for program in programlArray {
//                    print(program.description as Any)
//                    print(program.date as Any)
//                    print(program.time as Any)
//                    print(program.title as Any)
                }
            }
            //Reload tableView on main thread
            DispatchQueue.main.async {
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
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}


