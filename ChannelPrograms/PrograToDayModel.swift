//
//  PrograToDayModel.swift
//  ChannelPrograms
//
//  Created by Kolya on 31.01.17.
//  Copyright © 2017 Kolya. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class PrograToDayModel: Mappable {
    
    var channel_id : Int?
    var date : String?
    var time : String?
    var title : String?
    var description : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        channel_id<-map["channel_id"]
        date<-map["date"]
        time<-map["time"]
        title<-map["title"]
        description<-map["description"]
    }
}
