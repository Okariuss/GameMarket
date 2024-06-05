//
//  BaseViewModelDelegate.swift
//  GameMarket
//
//  Created by Okan Orkun on 5.06.2024.
//

import Foundation

protocol BaseViewModelDelegate where T: BaseViewControllerDelegate {
    associatedtype T
    var view: T? { get set }
    func viewDidLoad()
}
