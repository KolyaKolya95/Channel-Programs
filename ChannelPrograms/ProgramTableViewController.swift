//
//  ProgramTableViewController.swift
//  ChannelPrograms
//
//  Created by Kolya on 02.02.17.
//  Copyright © 2017 Kolya. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper

class ProgramTableViewController: UITableViewController {

    let timeStamp = NSNumber(value: Date().timeIntervalSinceNow)
    
    var programs = [PrograToDayModel]()
    
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
                    self.programs.append(program)
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
         return self.programs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgramTableViewCell", for: indexPath) as! ProgramTableViewCell

        cell.title.text = self.programs[indexPath.row].title
        cell.allInfo.text  = self.programs[indexPath.row].description
        cell.date.text = self.programs[indexPath.row].date
        cell.time.text = self.programs[indexPath.row].time

        return cell
    }
}
