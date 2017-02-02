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
                    print(program.title as Any)
                }
                
                
            }
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         print(self.programs.count as Any)
        return self.programs.count
       
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgramTableViewCell", for: indexPath) as! ProgramTableViewCell

        cell.title.text = self.programs[indexPath.row].title

        return cell
    }
}
