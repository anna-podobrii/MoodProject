//
//  Date.swift
//  MoodProject
//
//  Created by Anna Podobrii on 27.07.2022.
//

import Foundation

extension Date {
    static func currentDate(matches date:Date) -> Bool {
        let currentDate = Date()
        let currentDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: currentDate)
        let matchDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
        
        return currentDateComponents.day == matchDateComponents.day &&
        currentDateComponents.month == matchDateComponents.month &&
        currentDateComponents.year == matchDateComponents.year
    }
    
    func prevDate() -> Date {
        var beforeDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: self)
        beforeDateComponents.day = (beforeDateComponents.day ?? 0) - 1
        let prevDate = Calendar.current.date(from: beforeDateComponents) ?? Date()
        return prevDate
    }
    
    func nextDate() -> Date {
        var afterDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: self)
        afterDateComponents.day = (afterDateComponents.day ?? 0) + 1
        let nextDate = Calendar.current.date(from: afterDateComponents) ?? Date()
        return nextDate
    }
    
    static func oneYearFromCurrentDate() -> Date {
        let currentDate = Date()
        var currentDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: currentDate)
        currentDateComponents.year = (currentDateComponents.year ?? 2022) - 3
        let oneYearFromCurrentDate = Calendar.current.date(from: currentDateComponents) ?? Date()
        return oneYearFromCurrentDate
    }
}
