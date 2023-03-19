//
//  InformationViewController.swift
//  GoshuinApp
//
//  Created by 木村美希 on 2023/03/18.
//

import UIKit

class InformationViewController: UIViewController {
    
    @IBOutlet var nameTextLabel: UILabel!
    @IBOutlet var adressTextLabel: UILabel!
    @IBOutlet var ImageView: UIImageView!
    @IBOutlet var memoTextField: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func goInfo(name: String, adress: String, image: UIImage, memo: String) {
        nameTextLabel.text = name
        adressTextLabel.text = adress
        ImageView.image = image
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
