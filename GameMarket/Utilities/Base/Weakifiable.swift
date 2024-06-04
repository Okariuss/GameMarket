//
//  Weakifiable.swift
//  GameMarket
//
//  Created by Okan Orkun on 3.06.2024.
//

import Foundation

protocol Weakifiable: AnyObject { }

extension NSObject: Weakifiable { }

extension Weakifiable {
    func weakify<T>(_ code: @escaping (Self, T) -> Void) -> (T) -> Void {
        return { [weak self] (data) in
            guard let self = self else { return }
            code(self, data)
        }
    }
}
