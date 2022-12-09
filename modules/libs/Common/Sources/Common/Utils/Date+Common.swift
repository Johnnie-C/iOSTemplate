// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

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

    func string(withFormatter formatter: DateFormatter) -> String {
        formatter.string(from: self)
    }
    
}
