//
//  ListTableViewController.swift
//  GoshuinApp
//
//  Created by 木村美希 on 2023/03/17.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController, UITableViewDataSource{
    
    @IBOutlet var goshuinTableView: UITableView!
    @IBOutlet weak var showImageView: UIImageView!

    
    // Realm使う宣言
    let realm = try! Realm()
    
    // RealmData型の変数を用意（まだ空の配列）
    var goshuinList: [RealmData] = []
    
    var editCategory: RealmData!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableViewの教材参照
        self.goshuinTableView.delegate = self
        self.goshuinTableView.dataSource = self
        goshuinTableView.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoCell")
        
        tableData = realm.objects(goshuinList.self)
        //URL型にキャスト
        let fileURL = URL(string: tableData[0].imageURL)
        //パス型に変換
        let filePath = fileURL?.path
        showImageView.image = UIImage(contentsOfFile: filePath!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        // Realmから受け取るデータをList変数（配列）に突っ込む
        for object in realm.objects(RealmData.self) {
            goshuinList.append(object)
        }
        
        // tableViewを更新
        goshuinTableView.reloadData()
        
        // Realmの中身を確認するためのprint文
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // List変数（配列）に格納されてるデータ
        return goshuinList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // TableViewの教材参照
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath)
        
        // 取得したリストのindexPath.row番目をeachData変数に代入
        let eachData = goshuinList[indexPath.row]
        
        // セルに反映
        cell.textLabel?.text = eachData.name
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 画面遷移先を指定
        performSegue(withIdentifier: "toEditVC", sender: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditVC" {
            
            let indexPath = goshuinTableView.indexPathForSelectedRow!
            
            let destination = segue.destination as? EditViewController
            
            destination?.passedNumber = indexPath.row
        }
    }
   
   
}

//スワイプ
extension ListViewController: UITableViewDelegate {
  // スワイプした時に表示するアクションの定義
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        
       
        // 編集処理
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            
            self.editCategory = self.goshuinList[indexPath.row]
            self.performSegue(withIdentifier: "toEdit", sender: nil)
            
          print("Editがタップされました")

        completionHandler(true)
        }
        
        //削除処理
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [self] (action, view, completionHandler) in
            
            try! self.realm.write {
                let item = goshuinList.remove(at: indexPath.row)
                realm.delete(item)
            }
            tableView.reloadData()
            print("Deleteがタップされました")
            
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
