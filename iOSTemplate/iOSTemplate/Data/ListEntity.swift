// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import Foundation
import Common

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
