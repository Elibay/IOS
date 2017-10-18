//
//  TableViewController.swift
//  baribir
//
//  Created by Elibay Nuptebek on 05.07.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var users: [(UIImage, String)] = [
        (#imageLiteral(resourceName: "avatar"), "Akerke"),
        (#imageLiteral(resourceName: "avatar"), "Zhandos")
    ]
    private func configureTableView() {
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Table View Cell", for: indexPath) as! TableViewCell
        cell.info = users[indexPath.row]
        return cell
    }
    
}
