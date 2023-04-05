//
//  RealmData.swift
//  GoshuinApp
//
//  Created by 木村美希 on 2023/03/17.
//

import Foundation
import UIKit
import RealmSwift

class RealmData: Object, Codable {
    
    @objc dynamic var name: String? = ""
    @objc dynamic var address: String? = ""
    @objc dynamic var photo = Data()
    @objc dynamic var memo: String? = ""
    
    init(name: String, address: String) {
        self.name = name
        self.address = address
    }
    
    required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decode(String.self, forKey: .name)
            address = try container.decode(String.self, forKey: .address)
        }

        enum CodingKeys: String, CodingKey {
            case name
            case address
        }
    
    convenience init(name: String, address: String, photo: Data, memo: String) {
            self.init()
            self.name = name
            self.address = address
            self.photo = photo
            self.memo = memo
        }
    
}
