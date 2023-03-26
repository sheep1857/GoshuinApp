//
//  RealmData.swift
//  GoshuinApp
//
//  Created by 木村美希 on 2023/03/17.
//

import Foundation
import UIKit
import RealmSwift

class RealmData: Object {
    
    @objc dynamic var name: String? = ""
    @objc dynamic var address: String? = ""
    @objc dynamic var photo = Data()
    @objc dynamic var memo: String? = ""
    
    convenience init(name: String, address: String, photo: Data, memo: String) {
            self.init()
            self.name = name
            self.address = address
            self.photo = photo
            self.memo = memo
        }
    
}
