//
//  YoutubeSearchResponse.swift
//  Movie-App
//
//  Created by Deotwal, Jalaj | Ronnie on 2025/12/14.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
