//
//  CategoryTableViewController.swift
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

class CategoryTableViewController: UITableViewController {

    var category = [AllCategoryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let URL = "http://52.50.138.211:8080/ChanelAPI/categories"
        
        Alamofire.request(URL).responseArray { (response: DataResponse<[AllCategoryModel]>) in
            
            let categorylArray = response.result.value
            
            if let categorylArray = categorylArray {
                for category in categorylArray {
                    self.category.append(category)
                }
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url  = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.category.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        
        let imageUrl = category[indexPath.row].pictures
        
        self.verifyUrl(urlString: imageUrl)
        
        print (verifyUrl)
        print(imageUrl as Any)
        
        cell.titleCategory.text = self.category[indexPath.row].title
        
    //    cell.fotoCat.downloadFrom(url: URL(string: imageUrl)!)
        
        return cell
    }
}

extension UIImageView {
    func downloadFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
}

