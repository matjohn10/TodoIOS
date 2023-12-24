//
//  TimeFormat.swift
//  todo app
//
//  Created by Mathieu Johnson on 2023-12-24.
//

import Foundation


func TimeFormat(date: Date) -> String {
    let minutes = Int(date.timeIntervalSinceNow)/60
    let hours = minutes/60
    let days = hours/24
    
    let dateFormatter = DateFormatter()
    var dateString: String = ""
    if days > 7 {
        dateFormatter.dateFormat = "MMM/dd"
        dateString = dateFormatter.string(from: date)
    }
    else if days > 1 {
        dateFormatter.dateFormat = "HH:mm"
        dateString = date.formatted(Date.FormatStyle().weekday(.abbreviated)) + " at " + dateFormatter.string(from: date)
    }
    else {
        dateFormatter.dateFormat = "HH:mm"
        dateString = "Today at " + dateFormatter.string(from: date)
    }
    
    
    return dateString
}
