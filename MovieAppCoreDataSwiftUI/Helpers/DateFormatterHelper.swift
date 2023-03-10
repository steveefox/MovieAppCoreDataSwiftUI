//
//  MovieDateHelper.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 23.08.22.
//

import Foundation

final class DateFormatterHelper {
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    static func formattedString(from date: Date) -> String {
        return formatter.string(from: date)
    }
    
    static func dateFrom(string: String) -> Date? {
        return formatter.date(from: string)
    }
}
