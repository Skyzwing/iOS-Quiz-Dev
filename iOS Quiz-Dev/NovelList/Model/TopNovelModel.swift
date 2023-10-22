//
//  TopNovelModel.swift
//  iOS Quiz-Dev
//
//  Created by Surachet Yaitammasan on 21/10/23.
//

import Foundation

// MARK: - TopNovelList
struct TopNovelList: Codable {
    let pageInfo: TopNovelListPageInfo?
    let list: [List]?
}

// MARK: - List
struct List: Codable {
    let novel: Novel?
    let section: Section?
} 

// MARK: - Novel
struct Novel: Codable {
    let id: Int
    let updatedAt: String?
    let title, type, description: String?
    let totalChapter: Int?
    let category: Category?
    let tags: [String]?
    let owners: [Owner]?
    let thumbnail: Thumbnail?
    let engagement: Engagement?
    let order: Int?
}

// MARK: - Category
struct Category: Codable {
    let main, sub: Int?
    let mainTitle, subTitle: String?
}

// MARK: - Engagement
struct Engagement: Codable {
    let view: View?
    let comment: Comment?
}

// MARK: - Comment
struct Comment: Codable {
    let primary, overall: Int?
}

// MARK: - View
struct View: Codable {
    let month, overall: Int?
}

// MARK: - Owner
struct Owner: Codable {
    let id: Int??
    let username, alias, role: String?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let normal: String?
    let landscape: String?
}

// MARK: - PageInfo
struct TopNovelListPageInfo: Codable {
    let currentPage, totalItems, itemsPerPage: Int?
    let hasPrevious, hasNext: Bool?
}

struct Section: Codable {
    let type, title, path: String?
}
