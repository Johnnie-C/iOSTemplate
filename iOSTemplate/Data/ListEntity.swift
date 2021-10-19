//
//  ListEntity.swift
//  iOSTemplate
//
//  Created by Johnnie Cheng on 19/10/21.
//

import Foundation

class ListEntity: Decodable, Hashable {

    let date: Date?
    let name: String?
    let avatar: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case date = "createdAt"
        case name
        case avatar
        case id
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decodeDateIfPresent(.date, formatter: .full)
        name = try container.decodeIfPresent(.name)
        avatar = try container.decodeIfPresent(.avatar)
        id = try container.decodeIfPresent(.id)
    }

    func hash(into hasher: inout Hasher) {
        id?.hash(into: &hasher)
    }

    static func == (lhs: ListEntity, rhs: ListEntity) -> Bool {
        lhs.id == rhs.id
    }

}
