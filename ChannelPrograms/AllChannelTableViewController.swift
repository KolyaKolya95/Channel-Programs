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
import RealmSwift
import SVProgressHUD

class AllChannelTableViewController: UITableViewController {

    var modelChannel = [AllCnannelModel]()
    
    let realm = try! Realm()
    
    lazy var channels: Results<ChannelData> = { self.realm.objects(ChannelData.self) }()
    
    lazy var ArrayFavorite: Results<FavoriteChannelsData> = {self.realm.objects(FavoriteChannelsData.self)}()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultChannel()
    }
    
    func defaultChannel() {
        
        if channels.count == 0 {
            
           SVProgressHUD.show(withStatus: "dowload")
            
            let URL = "http://52.50.138.211:8080/ChanelAPI/chanels"
            
            Alamofire.request(URL).responseArray { (response: DataResponse<[AllCnannelModel]>) in
                
                let channelArray = response.result.value
                
                if let channelArray = channelArray {
                    for channel in channelArray {
                        try! self.realm.write() {
                            let newChannel = ChannelData()
                            newChannel.category_id = channel.category_id!
                            newChannel.idChannel = channel.id!
                            print(newChannel.idChannel)
                            newChannel.name = channel.name!
                            print(newChannel.name)
                            newChannel.picture = channel.picture
                            newChannel.url = channel.url!
                            print(newChannel.url)
                            self.realm.add(newChannel, update: true)
                        }
                    }
                }
                DispatchQueue.main.async{
                    self.channels = self.realm.objects(ChannelData.self)
                    self.tableView.reloadData()
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
        return self.channels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AllChannelTableViewCell
        
        let strUrl = channels[indexPath.row].picture
        
        cell.nameChannel.text = self.channels[indexPath.row].name
        cell.urlChannel.text = self.channels[indexPath.row].url
        cell.imageChannel.downloadFrom(url: URL(string: strUrl)!)
        
        SVProgressHUD.dismiss()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SVProgressHUD.showSuccess(withStatus: "Add to Favorite")
        
        let cellFavorite = self.channels[indexPath.row]
        
        try! self.realm.write() {
            let newChannel = FavoriteChannelsData()
            newChannel.id = "\(cellFavorite.idChannel)"
            newChannel.title = cellFavorite.name
            newChannel.image = cellFavorite.picture
            
            print(newChannel.title)
             self.tableView.reloadData()
            
            self.realm.add(newChannel, update: true)
        }
         self.tableView.reloadData()
        self.ArrayFavorite = self.realm.objects(FavoriteChannelsData.self)
    }
}
