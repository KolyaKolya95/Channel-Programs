//
//  FavoriteChannelsData.swift
//  ChannelPrograms
//
//  Created by Kolya on 05.02.17.
//  Copyright © 2017 Kolya. All rights reserved.
//

import Foundation
import RealmSwift


class FavoriteChannelsData: Object {
    dynamic var id = ""
    dynamic var title = ""
    dynamic var image = ""
     dynamic var created = NSDate()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
