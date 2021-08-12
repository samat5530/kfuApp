//
//  RegionsTableViewController.swift
//  kfuApp
//
//  Created by Гафиятуллин Самат on 23/06/2020.
//  Copyright © 2020 gafiyatullinsamat. All rights reserved.
//

import UIKit

class RegionsTableViewController: UITableViewController {

    var city: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if city == "Казань" {
            return regionList.regions_kazan?.count ?? 0
        }
        else {
            return regionList.regions?.count ?? 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell", for: indexPath)

        if city == "Казань" {
            cell.textLabel?.text = regionList.regions_kazan?[indexPath.row].region_name ?? ""
        }
        else {
            cell.textLabel?.text = regionList.regions?[indexPath.row].region_name ?? ""
        }
        return cell
    }

}
