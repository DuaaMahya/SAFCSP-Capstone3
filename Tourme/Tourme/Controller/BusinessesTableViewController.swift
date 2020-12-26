//
//  BusinessesTableViewController.swift
//  Tourme
//
//  Created by Dua Almahyani on 24/12/2020.
//

import UIKit

private let reuseIdentifier = "BusinessCell"

class BusinessesTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(mainTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorColor = .clear
    }

    // MARK: - Table view data source


    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        13
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! mainTableViewCell
        cell.textLabel?.text = "test"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dVC = storyboard.instantiateViewController(identifier: "BusinessDetailVC") as! BusinessDetailViewController
       
        
        
        self.navigationController?.pushViewController(dVC, animated: true)
    }
    

}
