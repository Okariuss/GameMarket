//
//  Date+Ext.swift
//  GameMarket
//
//  Created by Okan Orkun on 6.06.2024.
//

import Foundation

extension Date {
    /// Converts the date to a string in the format "yyyy-MM-dd".
    ///
    /// - Returns: A string representation of the date in "yyyy-MM-dd" format.
    func toYYYYMMDD() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df.string(from: self)
    }
}
