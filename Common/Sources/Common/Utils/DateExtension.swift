//
//  DateExtension.swift
//
//  Created by Johnnie Cheng on 1/5/21.
//

import Foundation

public extension Date {

    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month],
                                                         from: Calendar.current.startOfDay(for: self))
        return Calendar.current.date(from:components )!
    }

    var endOfMonth: Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, second: -1), to: self.startOfMonth)!
    }

    func isInSameMonth(as date: Date) -> Bool {
        isEqual(to: date, toGranularity: .month)
    }

    private func isEqual(to date: Date,
                 toGranularity component: Calendar.Component,
                 in calendar: Calendar = .current)
        -> Bool
    {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }

    var lastMonth: Date? {
        Calendar.current.date(byAdding: .month, value: -1, to: self)
    }

    var nextMonth: Date? {
        Calendar.current.date(byAdding: .month, value: 1, to: self)
    }

}
