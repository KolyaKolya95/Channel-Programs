//
//  AllCnannelModel.swift
//  ChannelPrograms
//
//  Created by Kolya on 31.01.17.
//  Copyright © 2017 Kolya. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class AllCnannelModel : Mappable {
    
    var  id : Int?
    var  name: String?
    var  url : String?
    var  picture : String
    var  category_id: Int?
    
    required init?(map: Map) {
        
        picture = ""
        
    }
    
    func mapping(map: Map) {
        id<-map["id"]
        name<-map["name"]
        url<-map["url"]
        picture<-map["picture"]
        category_id<-map["category_id"]
    }
}
