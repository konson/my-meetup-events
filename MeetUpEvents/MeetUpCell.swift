//
//  MeetUpCell.swift
//  MeetUpEvents
//
//  Created by Alecsandra Konson on 9/15/18.
//  Copyright © 2018 Alecs Konson. All rights reserved.
//

//
//  MeetUpCollectionViewCell.swift
//  WWCMeetUps
//
//  Created by Alecsandra Konson on 9/15/18.
//  Copyright © 2018 Alecs Konson. All rights reserved.
//

import UIKit

class MeetUpCell: UITableViewCell {
    
    @IBOutlet var groupLabel: UILabel!
    @IBOutlet var meetUpLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var rsvpLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        update(with: nil)
    }
    
    func update(with meetUp: MeetUp?) {
        if let meetUp = meetUp {
            let dateString = dateFormatter(dateInMilliseconds: meetUp.date)
            groupLabel.text = meetUp.group
            meetUpLabel.text = meetUp.name
            dateLabel.text = dateString
            rsvpLabel.text = String(meetUp.rsvp)
        } else {
            groupLabel.text = nil
            meetUpLabel.text = nil
            dateLabel.text = nil
            rsvpLabel.text = nil
        }
    }
    
    private func dateFormatter(dateInMilliseconds milliseconds: Int) -> String {
        let dateVar = Date(milliseconds: milliseconds)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d, yyyy   h:mm a"
        
        return dateFormatter.string(from: dateVar)
    }
}

