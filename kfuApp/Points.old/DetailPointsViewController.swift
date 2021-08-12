//
//  DetailPointsViewController.swift
//  kfuApp
//
//  Created by Гафиятуллин Самат on 08/06/2020.
//  Copyright © 2020 gafiyatullinsamat. All rights reserved.
//

import UIKit

class DetailPointsViewController: UIViewController {

    var point: Point!
    
    @IBOutlet weak var subjectNameLabel: UILabel!
    @IBOutlet weak var totalPointsLabel: UILabel!
    @IBOutlet weak var examPointsLabel: UILabel!
    @IBOutlet weak var pointsStringLabel: UILabel!
    @IBOutlet weak var semestrLabel: UILabel!
    @IBOutlet weak var semesterPointsLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        totalPointsLabel.text = point.total_points ?? ""
        examPointsLabel.text = point.exam_points ?? ""
        pointsStringLabel.text = point.points_string ?? ""
        semestrLabel.text = point.semester ?? ""
        semesterPointsLabel.text = point.semester_points ?? ""
        
        subjectNameLabel.text = point.subject_name ?? ""
        if point.type == "q" {
            typeLabel.text = "зачет"
        }
        else if point.type == "e" {
            typeLabel.text = "экзамен"
        }
        else {
            typeLabel.text = ""
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
