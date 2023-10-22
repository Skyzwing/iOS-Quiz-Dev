//
//  Banner.swift
//  iOS Quiz-Dev
//
//  Created by Surachet Yaitammasan on 21/10/23.
//

import Foundation

// MARK: - Banner
struct Banner: Codable {
    let pageInfo: BannerPageInfo?
    let list: [BannerList]?
}

// MARK: - List
struct BannerList: Codable {
    let id: String?
    let createdAt, updatedAt, startedAt, endedAt: String?
    let published: Bool?
    let payload: Payload?
}

// MARK: - Payload
struct Payload: Codable {
    let url: String?
    let imageURL: ImageURL?
}

// MARK: - ImageURL
struct ImageURL: Codable {
    let mobile, tablet: String?
}

// MARK: - PageInfo
struct BannerPageInfo: Codable {
    let currentPage, totalItems, itemsPerPage: Int?
    let hasPrevious, hasNext: Bool
}
