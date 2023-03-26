//
//  ListtTableViewController.swift
//  GoshuinApp
//
//  Created by 木村美希 on 2023/03/26.
//

import UIKit
import RealmSwift

class ListtTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var shrines: Results<RealmData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shrines = realm.objects(RealmData.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shrines.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell

            let shrine = shrines[indexPath.row]
            cell.nameTextLabel.text = shrine.name
            cell.photoImageView.image = UIImage(data: shrine.photo)
            
            return cell
        }

        // MARK: - Navigation

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowDetail" {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let shrine = shrines[indexPath.row]
                    let detailVC = segue.destination as! InformationViewController
                    detailVC.shrine = shrine
                }
            }
        }
        
        @IBAction func unwindToShrineList(_ unwindSegue: UIStoryboardSegue) {
            // Use data from the view controller which initiated the unwind segue
        }

    

}

   
