//
//  ListtTableViewController.swift
//  GoshuinApp
//
//  Created by 木村美希 on 2023/03/26.
//

import UIKit
import RealmSwift

class ListTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var shrines: Results<RealmData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shrines = realm.objects(RealmData.self)
    }
    
    //Realmデータ呼び出し
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    //表示するセクション数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shrines.count
    }
    
    //表示項目
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell

            let shrine = shrines[indexPath.row]
            cell.nameTextLabel.text = shrine.name
            cell.photoImageView.image = UIImage(data: shrine.photo)
            
            return cell
        }
    
    //タップされたら表示
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedShrine = shrines[indexPath.row]
        performSegue(withIdentifier: "ShowDetail", sender: selectedShrine)
    }

        // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let informationViewController = segue.destination as? InformationViewController,
               let selectedShrine = sender as? RealmData {
                informationViewController.shrine = selectedShrine
            }
        }
    }

        
        @IBAction func unwindToShrineList(_ unwindSegue: UIStoryboardSegue) {
            // Use data from the view controller which initiated the unwind segue
        }

    

}

   
