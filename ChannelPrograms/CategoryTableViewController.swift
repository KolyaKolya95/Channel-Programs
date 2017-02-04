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
import RealmSwift

class CategoryTableViewController: UITableViewController {

    var categoryChannel = [AllCategoryModel]()
    
    let realm = try! Realm()
    
    lazy var categories: Results<CategoryData> = { self.realm.objects(CategoryData.self) }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultCategories()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
         self.tableView.reloadData()
    }
    
    func defaultCategories() {
        
        if categories.count == 0 {
            
                let URL = "http://52.50.138.211:8080/ChanelAPI/categories"
                
                Alamofire.request(URL).responseArray { (response: DataResponse<[AllCategoryModel]>) in
                    
                    let categorylArray = response.result.value
                    
                    if let categorylArray = categorylArray {
                        for category in categorylArray {
                            try! self.realm.write() {
                                
                            let newCategory = CategoryData()
                            newCategory.id = category.id!
                            newCategory.title = category.title!
                            newCategory.picture = category.pictures
                            
                            self.realm.add(newCategory, update: true)
                            print(newCategory.picture)
                        }
                    }
                }
            }
            self.tableView.reloadData()
            categories = realm.objects(CategoryData.self)
        }else{
        }
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
     //   print(self.categories.count as Any)
        return self.categories.count
       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        
        let imageUrl = self.categories[indexPath.row].picture
        
        print(self.categories[indexPath.row].picture)
        
        let flag = true

        if flag ==  self.verifyUrl(urlString: imageUrl) {
            
            cell.fotoCat.downloadFrom(url: URL(string: imageUrl)!)
            
            print (verifyUrl)
            print(imageUrl as Any)
            
        }else {
            print(Error.self)
        }
        
        cell.titleCategory.text = self.categories[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let categoryFound  = self.storyboard!.instantiateViewController(withIdentifier: "CategoryFindTableViewController") as! CategoryFindTableViewController
        self.navigationController?.pushViewController(categoryFound, animated: true)
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

