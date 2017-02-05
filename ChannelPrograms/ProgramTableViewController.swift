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
import RealmSwift
import SVProgressHUD

class ProgramTableViewController: UITableViewController {

    let timeStamp = NSNumber(value: Date().timeIntervalSinceNow)
    
    let realm = try! Realm()
    
    var programs = [PrograToDayModel]()
    
    var activitiIndication: UIActivityIndicatorView = UIActivityIndicatorView()
    
    lazy var prog: Results<ProgramData> = { self.realm.objects(ProgramData.self) }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        let timeStamp = NSNumber(value: Date().timeIntervalSinceNow)
        print(timeStamp)
        self.downloadPrograms(for: timeStamp)
        self.tableView.reloadData()
       
    }
    
    func downloadPrograms(for timestamp: NSNumber) {
        
       if prog.count == 0 {
        
        SVProgressHUD.show(withStatus: "dowload")
        
        Alamofire.request("http://52.50.138.211:8080/ChanelAPI/programs/\(timestamp)").responseArray { (response: DataResponse<[PrograToDayModel]>) in
            
            let programlArray = response.result.value
            
            if let programlArray = programlArray {
                for program in programlArray {
                   self.programs.append(program)
                    
                    try! self.realm.write() {
                        
                      //  self.activitiIndication.startAnimating()
                        
                        let newProgram = ProgramData()
                        newProgram.channel_id = program.channel_id!
                        newProgram.date = program.date!
                        newProgram.title = program.title!
                        newProgram.desc = program.description!
                        newProgram.time = program.time!
                        
                        print(newProgram.title)
                        print(newProgram.desc)
                        print(newProgram.time)
                            print(newProgram.date)
                        
                        
                        self.realm.add(newProgram, update: true)
                
                    }
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.prog = self.realm.objects(ProgramData.self)
                }
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
        
         return self.prog.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgramTableViewCell", for: indexPath) as! ProgramTableViewCell
        cell.title.text = self.prog[indexPath.row].title
        cell.allInfo.text = self.prog[indexPath.row].desc
        cell.date.text = self.prog[indexPath.row].date
        cell.time.text = self.prog[indexPath.row].time
        SVProgressHUD.dismiss()
        return cell
    }
}
