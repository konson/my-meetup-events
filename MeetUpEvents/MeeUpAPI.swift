//
//  MeeUpAPI.swift
//  WWCMeetUps
//
//  Created by Alecsandra Konson on 9/15/18.
//  Copyright © 2018 Alecs Konson. All rights reserved.
//

import Foundation

enum EndPoint: String {
    case findUpcomingEvents = "find/upcoming_events/"
}

enum MeetUpError: Error {
    case invalidJSONData
}

struct MeetUpAPI {
    
    private static let baseURLString = "https://api.meetup.com/"
    private static let apiKey = ""
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private static func meetUp(fromJSON json: [String:Any]) -> MeetUp? {
        guard
            let name = json["name"] as? String,
            let dateTimeMilliseconds = json["time"] as? Int,
            let link = json["link"] as? String,
            let rsvp = json["yes_rsvp_count"] as? Int else {
                print("Error: not enough data to construct a MeetUP")
                return nil
        }

        
        return MeetUp(name: name, dateTime: dateTimeMilliseconds, link: link, rsvp: rsvp)
    }
    
    private static func meetUpURL(endPoint: EndPoint,
                                  parameters: [String: String]?) -> URL {
        var components = URLComponents(string: baseURLString)!
        
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "method": endPoint.rawValue,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": apiKey]
        
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        
        components.queryItems = queryItems
        
        //return components.url!
        
        //MARK: TODO
        // generate a proper URL
        return URL(string: "https://api.meetup.com/find/upcoming_events?photo-host=public&end_date_range=2020-01-01T00%3A00%3A00&text=Northwest+OTP+Study+Group&sig_id=80204312&sig=18c0479d9b5e532d503ae8f82922ac56d0e572d0")!
    }
    
    static var upcomingEventsURL: URL {
        return meetUpURL(endPoint: .findUpcomingEvents, parameters: ["end_time_range": "2020-01-01T00:00:00",
                                                                     "text": "Northwest OTP Study Group"])
    }
    
    static func meetUps(fromJSON data: Data) -> MeetUpResults {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard
            let jsonDictionary = jsonObject as? [AnyHashable:Any],  // 2 key/value pairs (city and events)
            let meetUpsArray = jsonDictionary["events"] as? [Any]
                else {
                return .failure(MeetUpError.invalidJSONData)
            }
            
            var finalMeetUps = [MeetUp]()
            for meetUpJSON in meetUpsArray {
                if let meetUp = meetUp(fromJSON: meetUpJSON as! [String : Any]) {
                    finalMeetUps.append(meetUp)
                }
            }
            
            if finalMeetUps.isEmpty && !meetUpsArray.isEmpty {
                return .failure(MeetUpError.invalidJSONData)
            }
            print("Fetched \(finalMeetUps.count) meetups.")
            return .success(finalMeetUps)
        } catch let error {
            return .failure(error)
        }
    }
}
