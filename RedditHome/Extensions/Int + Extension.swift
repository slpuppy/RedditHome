//
//  Int + Extension.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 22/05/24.
//

import Foundation

extension Int {
    
    func formattedDateString() -> String? {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        
        let calendar = Calendar.current
        let now = Date()
        
        if calendar.isDateInToday(date) {
            dateFormatter.dateFormat = "HH:mm"
            return "Today, " + dateFormatter.string(from: date)
        } else {
            let components = calendar.dateComponents([.year, .month, .day, .hour], from: date, to: now)
            
            if let years = components.year, years > 0 {
                dateFormatter.dateFormat = "M d yyyy, HH:mm"
            } else if let months = components.month, months > 0 {
                dateFormatter.dateFormat = "MMM d, HH:mm"
            } else if let days = components.day, days > 0 {
                dateFormatter.dateFormat = "MMM d, HH:mm"
            } else {
                dateFormatter.dateFormat = "HH:mm"
                return "Yesterday, " + dateFormatter.string(from: date)
            }
            
            return dateFormatter.string(from: date)
        }
    }
}
