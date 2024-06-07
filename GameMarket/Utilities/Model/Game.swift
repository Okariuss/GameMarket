//
//  Game.swift
//  GameMarket
//
//  Created by Okan Orkun on 5.06.2024.
//

import Foundation

struct Games: Codable {
    let results: [Game]
}

struct Game: Codable {
    let id : Int
    let name : String
    let released : String
    let rating : Double
    let background_image : String
}

struct GameDetails: Codable {
    let id : Int
    let name : String
    let released : String
    let metacritic : Int
    let rating : Double
    let background_image : String
    let description_raw : String
}
