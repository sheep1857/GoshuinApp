//
//  ViewController.swift
//  GoshuinApp
//
//  Created by 木村美希 on 2023/03/16.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var MapButton: UIButton!
    @IBOutlet var ListButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ボタンの角を丸くする
        MapButton.layer.cornerRadius = 35
        ListButton.layer.cornerRadius = 35
    }


}

