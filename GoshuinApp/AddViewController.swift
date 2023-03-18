//
//  AddViewController.swift
//  GoshuinApp
//
//  Created by 木村美希 on 2023/03/17.
//

import UIKit
import Foundation
import RealmSwift

class AddViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var adressTextField: UITextField!
    @IBOutlet var ImageView: UIImageView!
    @IBOutlet var memoTextView: UITextView!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    let realm = try! Realm()
    
    var goshuinList: [RealmData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pictDisp()
        
        
        //キーボードをしまう
        nameTextField.delegate = self
        adressTextField.delegate = self
        
        // Realmの中身を確認するためのprint文
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
         
    }
    
    func pictDisp(){
            
        let pictData = realm.objects(goshuinList.self)
        //URL型にキャスト
        let pictName = pictData[0].topPictName
        let pictURL = documentDirectoryFileURL.appendingPathComponent(pictName)
        //パス型に変換
        let filePath = pictURL.path
        ImageView.image = UIImage(contentsOfFile: filePath)

        }
    
    
    
    
    
    @IBAction func save(){
        
        // .realm拡張子のデータベースをローカルに作成
        let realm = try! Realm()
        
        // RealmDataクラスをインスタンス化（実体化）
        let realmData = RealmData()
        
        // インスタンス化したオブジェクトに値をセット
        realmData.name = nameTextField.text!
        realmData.adress = adressTextField.text!
        realmData.image = ImageView.image!
        realmData.memo = memoTextView.text!
        
        // 保存のコード(データベースに書き込み)
        try! realm.write {
            realm.add(realmData)
        }
        
        navigationController?.popViewController(animated: true)
        
        // Realmの中身を確認するためのprint文
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        self.dismiss(animated: true)
        
    }
    
}
