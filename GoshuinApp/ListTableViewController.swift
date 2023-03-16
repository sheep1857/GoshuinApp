//
//  ListTableViewController.swift
//  GoshuinApp
//
//  Created by 木村美希 on 2023/03/17.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var goshuinTableView: UITableView!
    
    // RealmData型の変数を用意（まだ空っぽの配列）
    var goshuinList: Results<RealmData>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableViewの教材参照
        self.goshuinTableView.delegate = self
        self.goshuinTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Realm使う宣言
        let realm = try! Realm()
        
        // Realmから受け取るデータをList変数（配列）に突っ込む
        self.goshuinList = realm.objects(RealmData.self)
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
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
