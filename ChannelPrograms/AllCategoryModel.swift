//
//  AllCategoryModel.swift
//  ChannelPrograms
//
//  Created by Kolya on 31.01.17.
//  Copyright © 2017 Kolya. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class AllCategoryModel: Mappable {
    
    var id: Int?
    var title : String?
    var pictures : String
    
    required init?(map: Map) {
        pictures = ""
    }
    
    func mapping(map: Map) {
        
        id<-map["id"]
        title<-map["title"]
        pictures<-map["picture"]
        
    }
}
