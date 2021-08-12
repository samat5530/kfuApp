//
//  PointsViewController.swift
//  kfuApp
//
//  Created by Гафиятуллин Самат on 04/06/2020.
//  Copyright © 2020 gafiyatullinsamat. All rights reserved.
//

import UIKit

class PointsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var semesterSegmentControl: UISegmentedControl!
    @IBOutlet weak var pointsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Оценки"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToPointsDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Редактируй здесь переход на детали
        
        if segue.identifier == "goToPointsDetail" {
            var state : Point
            
            
            switch semesterSegmentControl.selectedSegmentIndex {
            case 0:
            
                state = pointListByCourses.First[pointsTableView.indexPathForSelectedRow!.row]
            case 1:
               state = pointListByCourses.Second[pointsTableView.indexPathForSelectedRow!.row]
            case 2:
               state = pointListByCourses.Third[pointsTableView.indexPathForSelectedRow!.row]
            case 3:
               state = pointListByCourses.Fourth[pointsTableView.indexPathForSelectedRow!.row]
            default:
               state = Point()
            }
            
            (segue.destination as? DetailPointsViewController)?.point = state
            pointsTableView.deselectRow(at: pointsTableView.indexPathForSelectedRow!, animated: true)
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch semesterSegmentControl.selectedSegmentIndex {
        case 0:
            return pointListByCourses.First.count
        case 1:
            return pointListByCourses.Second.count
        case 2:
            return pointListByCourses.Third.count
        case 3:
            return pointListByCourses.Fourth.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PointCell") as? PointTableViewCell else {
            return UITableViewCell()
        }
        
        
        switch semesterSegmentControl.selectedSegmentIndex {
        case 0:
            cell.subjectLabel.text = pointListByCourses.First[indexPath.row].subject_name ?? "Неизвестно"
            cell.pointLabel.text = pointListByCourses.First[indexPath.row].total_points ?? "0"
            cell.pointStringLabel.text = pointListByCourses.First[indexPath.row].points_string ?? ""
        case 1:
            cell.subjectLabel.text = pointListByCourses.Second[indexPath.row].subject_name ?? "Неизвестно"
            cell.pointLabel.text = pointListByCourses.Second[indexPath.row].total_points ?? "0"
            cell.pointStringLabel.text = pointListByCourses.Second[indexPath.row].points_string ?? ""
        case 2:
            cell.subjectLabel.text = pointListByCourses.Third[indexPath.row].subject_name ?? "Неизвестно"
            cell.pointLabel.text = pointListByCourses.Third[indexPath.row].total_points ?? "0"
            cell.pointStringLabel.text = pointListByCourses.Third[indexPath.row].points_string ?? ""
        case 3:
            cell.subjectLabel.text = pointListByCourses.Fourth[indexPath.row].subject_name ?? "Неизвестно"
            cell.pointLabel.text = pointListByCourses.Fourth[indexPath.row].total_points ?? "0"
            cell.pointStringLabel.text = pointListByCourses.Fourth[indexPath.row].points_string ?? ""
        default:
            cell.subjectLabel.text = "Неизвестно"
            cell.pointLabel.text = "0"
            cell.pointStringLabel.text = ""
        }
        
        return cell
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
        
    @IBAction func semesterSC(_ sender: Any) {
        pointsTableView.reloadData()
    }
}


