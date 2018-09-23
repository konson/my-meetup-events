//
//  MeetUpStore.swift
//  WWCMeetUps
//
//  Created by Alecsandra Konson on 9/15/18.
//  Copyright © 2018 Alecs Konson. All rights reserved.
//

import UIKit

enum MeetUpResults {
    case success([MeetUp])
    case failure(Error)
}

class MeetUpStore {
    
   var allMeetUps = [MeetUp]()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private func processMeetUpsRequest(data: Data?, error: Error?) -> MeetUpResults {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return MeetUpAPI.meetUps(fromJSON: jsonData)
    }
    
    func fetchUpcomingEvents(completion: @escaping (MeetUpResults) -> Void) {
        let url = MeetUpAPI.upcomingEventsURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            let result = self.processMeetUpsRequest(data: data, error: error)
            // forces image view update to run on the main thread
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
}
