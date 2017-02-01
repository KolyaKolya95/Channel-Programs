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
    
    var toDayModell = [PrograToDayModel]()
    
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
                    
                    self.toDayModell.append(program)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
        return self.toDayModell.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as! MainTableViewCell
        
        cell.date.text = self.toDayModell[indexPath.row].date
        cell.time.text = self.toDayModell[indexPath.row].time
        cell.title.text = self.toDayModell[indexPath.row].title
        cell.deskc.text = self.toDayModell[indexPath.row].description
                
        return cell
    }

}


