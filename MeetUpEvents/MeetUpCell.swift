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

enum LocationName: String {
    case Woodstock = "Woodstock"
    case Kennesaw = "Kennesaw"
}

class MeetUpCell: UITableViewCell {
    
    @IBOutlet var groupLabel: UILabel!
    @IBOutlet var meetUpLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var rsvpLabel: UILabel!
    @IBOutlet var meetUPView: UIView!
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: nil)
    }
    
    func configure(with meetUp: MeetUp?) {
        if let meetUp = meetUp {
            let dateString = dateFormatter(dateInMilliseconds: meetUp.dateTimeMilliseconds)
            groupLabel.text = meetUp.group
            meetUpLabel.text = meetUp.name
            dateLabel.text = dateString
            rsvpLabel.text = String(meetUp.rsvp)
            
            meetUPView.layer.cornerRadius = 8
            meetUPView.layer.masksToBounds = true
            
            let containsWoodstock = meetUpLabel.text?.range(of: LocationName.Woodstock.rawValue)
            meetUPView.backgroundColor =  containsWoodstock != nil ? UIColor.woodstock : UIColor.kennesaw
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

