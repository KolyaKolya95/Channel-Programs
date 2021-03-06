//
//  ChannelData.swift
//  ChannelPrograms
//
//  Created by Kolya on 02.02.17.
//  Copyright © 2017 Kolya. All rights reserved.
//

import Foundation
import RealmSwift

class ChannelData: Object {
    dynamic var  idChannel = 0
    dynamic var  name = ""
    dynamic var  url  = ""
    dynamic var  picture = ""
    dynamic var  category_id = 0
    dynamic var created = NSDate()
    
    override static func primaryKey() -> String? {
        return "idChannel"
    }
}
