//
//  MeetUp.swift
//  MeetUpEvents
//
//  Created by Alecsandra Konson on 9/15/18.
//  Copyright © 2018 Alecs Konson. All rights reserved.
//

import UIKit

class MeetUp: Equatable {
    let group: String = "Women Who Code Atlanta"
    //let remoteURL: URL
    let name: String
    let date: Int
    let rsvp: Int
    let link: String
    
    init(name: String,
         date: Int,
         link: String,
         rsvp: Int) {
        self.name = name
        self.date = date
        self.rsvp = rsvp
        self.link = link
    }
    
    static func == (lhs: MeetUp, rhs: MeetUp) -> Bool {
        return lhs.name == rhs.name
    }
}
