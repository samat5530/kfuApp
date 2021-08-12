//
//  myPointsDataTableViewController.swift
//  kfuApp
//
//  Created by Гафиятуллин Самат on 22/06/2020.
//  Copyright © 2020 gafiyatullinsamat. All rights reserved.
//

import UIKit

class myPointsDataTableViewController: UITableViewController {

    var Id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Переход на детали
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Редактируй здесь переход на детали
        
        if segue.identifier == "goToMyPointsDetail" {
            var state : Point
            
            state = myPoints[Id][tableView.indexPathForSelectedRow!.row]
            
            (segue.destination as? DetailPointsViewController)?.point = state
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToMyPointsDetail", sender: self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPoints[Id].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myPointsCell") as? PointTableViewCell else {
            return UITableViewCell()
        }
        
        cell.subjectLabel.text = myPoints[Id][indexPath.row].subject_name ?? "Неизвестно"
        cell.pointLabel.text = myPoints[Id][indexPath.row].total_points ?? "0"
        cell.pointStringLabel.text = myPoints[Id][indexPath.row].points_string ?? ""
        
        return cell
    }
}
