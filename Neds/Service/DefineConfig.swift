//
//  FileService.swift
//  Neds
//
//  Created by Xavier.Z on 2023/6/23.
//

import Foundation
import UIKit

let Space_Line:CGFloat = 10
let kContentNavBarHeight = 44.0

struct Config {
    static let kNextRacesUrl = "https://api.neds.com.au/rest/v1/racing/?method=nextraces&count=" ///url
    static let kMaxCount = 81 ////max load data pool
    static let kExpireInterval : TimeInterval = -60 ///race expiration time
    static let kDisplayNumber = 5  /// for display count
}

