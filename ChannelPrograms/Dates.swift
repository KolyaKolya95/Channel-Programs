//
//  Dates.swift
//  ChannelPrograms
//
//  Created by Kolya on 01.02.17.
//  Copyright © 2017 Kolya. All rights reserved.
//

import Foundation

extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}
