//
//  CountDown.swift
//  Neds
//
//  Created by Xavier Zhang on 29/6/2023.
//

import Foundation
import SwiftUI

///4 status of a race
enum Status : TimeInterval, CaseIterable {
    case started = 0
    case countdown = 60
    case minites = 300
    case lessAnHour = 3600
    case hours = 3601 ///should be Double,infilnity, in this way a large number count is equivlent to hours. in the following 'else' branch,  this case
    
    init(rawValue: Double) {
        let allCases = Status.allCases.filter { $0.rawValue > rawValue }
        if let toCase = allCases.first {
           self = toCase
        } else {
           self = .hours ///rawValue > 3061
        }
    }
}

struct CountDown {
    
    let interval : IntInterval
    lazy var seconds = {
        interval % 60
    }()
    lazy var minutes = {
        interval / 60
    }()
    lazy var hours = {
        interval / 3600
    }()
    
    typealias IntInterval = Int
}

typealias RaceInfoExtra = (interval:String, textColor:Color, accessibilityLabel:String)

extension CountDown {
    
    static func processTimeStamp(_ model:RaceSummary) -> RaceInfoExtra {

        let interval: TimeInterval = model.advertisedStart.timeStamp - Date().timeIntervalSince1970
        let status = Status(rawValue: interval)
        var countdown = CountDown(interval: interval.toInt)
        switch status {
        case .started:
            return ("\(countdown.seconds)s", .red, "The \(model.meetingName) has started for \(countdown.seconds) seconds")
        case .countdown:
            return ("\(countdown.seconds)s", .red, "\(model.meetingName) will start in \(countdown.seconds) seconds")
        case .minites:
            let minutes = countdown.minutes
            let seconds = countdown.seconds
            return ("\(minutes)m\(seconds)s", .orange, "\(model.meetingName) will start in \(minutes) minutes and \(seconds) seconds")
        case .lessAnHour:
            let minutes = countdown.minutes
            return ("\(minutes)m",.blue, "\(model.meetingName) will start in \(minutes)minutes")
        case .hours:
            let hours = countdown.hours
            let minutes = countdown.minutes % 60
            return ("\(hours)h\(minutes)m", .blue, "\(model.meetingName) will start in \(hours)hours and \(minutes)minutes")
        }
    }
}

extension TimeInterval {
    var toInt : Int {
        Int(self)
    }
}
 
