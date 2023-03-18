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
    @objc dynamic var adress: String? = ""
    @objc dynamic var image: UIImage? = nil
    @objc dynamic var memo: String? = ""
    
}
