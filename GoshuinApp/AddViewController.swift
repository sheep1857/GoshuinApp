//
//  AddViewController.swift
//  GoshuinApp
//
//  Created by 木村美希 on 2023/03/17.
//

import UIKit
import Foundation
import RealmSwift

class AddViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var adressTextField: UITextField!
    @IBOutlet var ImageView: UIImageView!
    @IBOutlet var memoTextView: UITextView!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    
    let realm = try! Realm()
    
    var goshuinList: [RealmData] = []
    
    
    // ドキュメントディレクトリの「ファイルURL」（URL型）定義
        var documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

        // ドキュメントディレクトリの「パス」（String型）定義
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
    
    @IBAction func addImage(_ sender: UITextField) {
            //Realmのテーブルをインスタンス化
            let goshuinList = RealmData()
            do{
                try goshuinList.imageURL = directory.documentDirectoryFileURL.absoluteString
            }catch{
                print("画像の保存に失敗しました")
            }
            try! realm.write{realm.add(goshuinList)}
        
            
        }
    
    //保存するためのパスを作成する
    func createLocalDataFile() {
        // 作成するテキストファイルの名前
        let fileName = "\(NSUUID().uuidString).png"

        // DocumentディレクトリのfileURLを取得
        if documentDirectoryFileURL != nil {
            // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
            let path = documentDirectoryFileURL.appendingPathComponent(fileName)
            documentDirectoryFileURL = path
        }
    }
    
    //画像を保存する関数の部分
    func saveImage() {
        createLocalDataFile()
        //pngで保存する場合
        let pngImageData = ImageView.image?.pngData()
        do {
            try pngImageData!.write(to: documentDirectoryFileURL)
        } catch {
            //エラー処理
            print("エラー")
        }
    }
    
   
    
    @IBAction func selectImage() {
        //UIImagePickerControllerのインスタンスを作成
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        //フォトライブラリを呼び出す
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //imageに画像を設定する
        let image = info[.originalImage] as? UIImage
        
        ImageView.image = image
        
        //フォトライブラリを閉じる
        self.dismiss(animated: true, completion: nil)
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
