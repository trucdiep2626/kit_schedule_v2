//
//  Date+Extension.swift
//  KitWidgetsExtension
//
//  Created by MacPro13 on 18/01/2023.
//

import Foundation

extension Date {
    public var removeTimeStamp : Date? {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
            return nil
        }
        return date
    }
}
