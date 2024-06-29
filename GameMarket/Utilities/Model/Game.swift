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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? "Unknown"
        released = try container.decodeIfPresent(String.self, forKey: .released) ?? "N/A"
        rating = try container.decodeIfPresent(Double.self, forKey: .rating) ?? 0.0
        background_image = try container.decodeIfPresent(String.self, forKey: .background_image) ?? "https://fakeimg.pl/600x400?text=Not+Found"
    }
}

struct GameDetails: Codable {
    let id : Int
    let name : String
    let released : String
    let metacritic : Int
    let rating : Double
    let background_image : String
    let description_raw : String
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "Unknown"
        self.released = try container.decodeIfPresent(String.self, forKey: .released) ?? "N/A"
        self.metacritic = try container.decodeIfPresent(Int.self, forKey: .metacritic) ?? 0
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating) ?? 0.0
        self.background_image = try container.decodeIfPresent(String.self, forKey: .background_image) ?? "https://fakeimg.pl/600x400?text=Not+Found"
        self.description_raw = try container.decodeIfPresent(String.self, forKey: .description_raw) ?? "No Description"
    }
}
