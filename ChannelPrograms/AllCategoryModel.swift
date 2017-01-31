//
//  AllCategoryModel.swift
//  ChannelPrograms
//
//  Created by Kolya on 31.01.17.
//  Copyright © 2017 Kolya. All rights reserved.
//

import Foundation
import ObjectMapper

class AllCategoryModel: Mappable {

    var idCategory: Int?
    var titleCategory : String?
    var pictureCategory : String?
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        idCategory<-map["id"]
        titleCategory<-map["title"]
        pictureCategory<-map["picture"]
        
    }
}
