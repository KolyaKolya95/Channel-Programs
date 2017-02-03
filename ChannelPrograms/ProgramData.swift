//
//  ProgramData.swift
//  ChannelPrograms
//
//  Created by Kolya on 02.02.17.
//  Copyright © 2017 Kolya. All rights reserved.
//

import Foundation
import RealmSwift

class ProgramDara: Object {
    dynamic var channel_id = 0
    dynamic var date = ""
    dynamic var time = ""
    dynamic var title = ""
    dynamic var desc = ""
    dynamic var created = NSDate()
}
