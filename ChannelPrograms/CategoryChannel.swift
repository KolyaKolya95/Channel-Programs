//
//  CategoryChannel.swift
//  ChannelPrograms
//
//  Created by Kolya on 03.02.17.
//  Copyright © 2017 Kolya. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryChannel: Object {
    
    dynamic var channel_id = 0
    dynamic var allUkrainian = ""
    dynamic var music = ""
    dynamic var sport = ""
    dynamic var cinema = ""
    dynamic var child = ""
    dynamic var other = ""
    dynamic var news = ""
    dynamic var created = NSDate()
    
}
