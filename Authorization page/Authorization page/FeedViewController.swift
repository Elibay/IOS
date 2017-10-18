//
//  TableViewController.swift
//  baribir
//
//  Created by Elibay Nuptebek on 05.07.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import UIKit

class FeedViewController: UITableViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var news: [Poll] = []
    
    private func configureTableView() {
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
    }
    func cmp (a: Poll, b: Poll) -> Bool {
        if a.text < b.text {
            return true
        }
        return false
    }
    func cmp2 (a: Poll, b: Poll) -> Bool {
        if a.text < b.text {
            return false
        }
        return true
    }
    @IBAction func sortAction(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex
        {
            case 0:
                news.sort(by: cmp)
            case 1:
                news.sort(by: cmp2)
            default:
                break; 
        }
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Poll.getItems(){ feed, message in
            if feed == nil {
                self.showAlert("OSHIBKA")
                return
            }
            self.news = feed!
            self.news.sort (by: self.cmp)
            self.configureTableView()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Table View Cell", for: indexPath) as! TableViewCell
        cell.info = news[indexPath.row]
        return cell
    }
    
}
