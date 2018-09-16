//
//  MeetUpViewController.swift
//  MeetUpEvents
//
//  Created by Alecsandra Konson on 9/15/18.
//  Copyright © 2018 Alecs Konson. All rights reserved.
//

import UIKit

class MeetUpViewController: UITableViewController {
    
    var meetUpStore: MeetUpStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 130
        
        meetUpStore.fetchUpcomingEvents {
            
            (meetUpResult) -> Void in
            
            switch meetUpResult {
            case let .success(events):
                let sortedEvents = events.sorted() { $0.date < $1.date }
                self.meetUpStore.allMeetUps = sortedEvents
            case let .failure(error):
                print("Error fetching meetup events: \(error)")
                self.meetUpStore.allMeetUps.removeAll()
            }
            self.tableView.reloadData()
        }
    }
}

//MARK: Table View
extension MeetUpViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetUpStore.allMeetUps.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meetUpURLString = meetUpStore.allMeetUps[indexPath.row].link
        if let url = URL(string: meetUpURLString) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeetUpCell", for: indexPath) as! MeetUpCell
        let meetUp = meetUpStore.allMeetUps[indexPath.row]
        
        cell.update(with: meetUp)
        
//        cell.dateLabel.text = meetUp.date
//        cell.groupLabel.text = meetUp.group
//        cell.meetUpLabel.text = meetUp.name
//        cell.rsvpLabel.text = String(meetUp.rsvp)
//        cell.timeLabel.text = meetUp.time
        
        return cell
    }
}
