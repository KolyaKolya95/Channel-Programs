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
import SVProgressHUD

class CategoryTableViewController: UITableViewController {

    var categoryChannel = [AllCategoryModel]()
    
    let realm = try! Realm()
    
    var delegate: saveIdCategory?
    
    var idCategories = 0
    
    lazy var categories: Results<CategoryData> = { self.realm.objects(CategoryData.self) }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultCategories()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func defaultCategories() {
        
        if categories.count == 0 {
            
            SVProgressHUD.show(withStatus: "dowload")
            
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
                            print(newCategory.picture)
                            print(newCategory.title)
                            
                            self.realm.add(newCategory, update: true)
                        }
                    }
                }
                DispatchQueue.main.async{
                    self.categories = self.realm.objects(CategoryData.self)
                    self.tableView.reloadData()
                }
            }
        }
    }


    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url  = URL(string: urlString) {
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
        
        if self.verifyUrl(urlString: imageUrl) {
            cell.fotoCat.downloadFrom(url: URL(string: imageUrl)!)
        }else {
            print(Error.self)
        }
        
        cell.titleCategory.text = self.categories[indexPath.row].title
        
        SVProgressHUD.dismiss()
        
        return cell
        
    }
    
    var idPep : Int = 0
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let categoryFound  = self.storyboard!.instantiateViewController(withIdentifier: "CategoryFindTableViewController") as! CategoryFindTableViewController
        self.navigationController?.pushViewController(categoryFound, animated: true)
        
        let cellIdCategories = self.categories[indexPath.row]
        
        self.idPep = cellIdCategories.id
        
        categoryFound.idForFound = cellIdCategories.id
        
        print(idPep)
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
                else {
                    return
                }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
        }.resume()
    }
}

