//
//  Date+MeetUpEvents.swift
//  MeetUpEvents
//
//  Created by Alecsandra Konson on 9/16/18.
//  Copyright © 2018 Alecs Konson. All rights reserved.
//
import UIKit

extension Date {

    init(milliseconds: Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
