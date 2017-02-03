//
//  CategoryData.swift
//  ChannelPrograms
//
//  Created by Kolya on 02.02.17.
//  Copyright © 2017 Kolya. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryData: Object {
    
    dynamic var id = 0
    dynamic var title = ""
    dynamic var picture = ""
    
    override static func primaryKey() -> String? {
        return "id"   
    }
}


