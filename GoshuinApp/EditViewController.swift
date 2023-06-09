//
//  EditViewController.swift
//  GoshuinApp
//
//  Created by 木村美希 on 2023/03/17.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController {
    
    // ViewControllerから渡されたindexPath.row
    var passedNumber = 0
    
    // RealmData型の変数を用意（まだ空っぽの配列）
    var goshuinList: Results<RealmData>!
    
    @IBOutlet var editnameTextField: UITextField!
    @IBOutlet var editadressTextField: UITextField!
    @IBOutlet var editTextView: UITextView!
    @IBOutlet var updateButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Realm使う宣言！
        let realm = try! Realm()
        
        // Realmから受け取るデータをList変数（配列）に突っ込む
        self.goshuinList = realm.objects(RealmData.self)
        
        // 取得したリストのPassedNumber番目をeditData変数に代入
        let editData = goshuinList[passedNumber]
        
        // TextFieldとTextViewに値を代入
        editnameTextField.text = editData.name
        editadressTextField.text = editData.address
        editTextView.text = editData.memo
        
        // Realmの中身を確認するためのprint文
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
    }
    
    
    @IBAction func update(){
        
        // Realm使う宣言！
        let realm = try! Realm()
        
        // 更新のコード(データベースに上書き)
        try! realm.write {
            self.goshuinList[passedNumber].name = editnameTextField.text!
            self.goshuinList[passedNumber].address = editadressTextField.text!
            self.goshuinList[passedNumber].memo = editTextView.text!
        }
        
        navigationController?.popViewController(animated: true)
        
        // Realmの中身を確認するためのprint文
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    
    } //更新(CRUDのU)終わり！
    
    
    @IBAction func delete() {
        
        // Realm使う宣言！
        let realm = try! Realm()
        
        // 取得したリストのPassedNumber番目をeditData変数に代入
        let editData = goshuinList[passedNumber]
        
        // 削除のコード（番号を指定）
        try! realm.write {
            realm.delete(editData)
        }
        
        navigationController?.popViewController(animated: true)
    } //削除(CRUDのD)終わり！

}
