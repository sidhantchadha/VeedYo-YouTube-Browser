//
//  Videos.swift
//  VeedYo
//
//  Created by Sidhant Chadha on 9/7/18.
//  Copyright © 2018 AMoDynamics, Inc. All rights reserved.
//

import Foundation

struct MRData: Codable {
    let kind, etag, nextPageToken, regionCode: String
    let pageInfo: PageInfo
    let items: [Item]
}

struct Item: Codable {
    let kind, etag: String
    let id: ID
    let snippet: Snippet
}

struct ID: Codable {
    let kind, videoID: String
    
    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

struct Snippet: Codable {
    let publishedAt, channelID, title, description: String
    let thumbnails: Thumbnails
    let channelTitle, liveBroadcastContent: String
    
    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title, description, thumbnails, channelTitle, liveBroadcastContent
    }
}

struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high: Default
    
    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high
    }
}

struct Default: Codable {
    let url: String
    let width, height: Int
}

struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int
}
