//
//  InformationViewController.swift
//  GoshuinApp
//
//  Created by 木村美希 on 2023/03/18.
//

import UIKit
import RealmSwift

class InformationViewController: UIViewController {
    
    @IBOutlet var nameTextLabel: UILabel!
    @IBOutlet var addressTextLabel: UILabel!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var memoTextField: UILabel!
    
    let realm = try! Realm()
    var shrines: Results<RealmData>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func goInfo(name: String, adress: String, memo: String) {
        nameTextLabel.text = name
        addressTextLabel.text = adress
        //photoImageView.image = image
        memoTextField.text = memo
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
