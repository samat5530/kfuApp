//
//  DetailScheduleViewController.swift
//  kfuApp
//
//  Created by Гафиятуллин Самат on 02/06/2020.
//  Copyright © 2020 gafiyatullinsamat. All rights reserved.
//

import UIKit

class DetailScheduleViewController: UIViewController {

    var scheduleItem: Subject!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subjectKindLabel: UILabel!
    @IBOutlet weak var finishDayLabel: UILabel!
    @IBOutlet weak var startDayLabel: UILabel!
    @IBOutlet var teacherLabel: UILabel!
    @IBOutlet weak var groupListLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var semesterLabel: UILabel!
    @IBOutlet weak var numAuditoriumLabel: UILabel!
    @IBOutlet weak var typeWeekLabel: UILabel!
    @IBOutlet weak var buildingNameLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var beginTimeLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
        nameLabel.text = setLabelText(from: scheduleItem.subject_name)
        subjectKindLabel.text = setLabelText(from: scheduleItem.subject_kind_name)
        finishDayLabel.text = setLabelText(from: scheduleItem.finish_day_schedule)
        startDayLabel.text = setLabelText(from: scheduleItem.start_day_schedule)
        teacherLabel.text = "\(setLabelText(from: scheduleItem.teacher_lastname)) \(setLabelText(from: scheduleItem.teacher_firstname)) \(setLabelText(from: scheduleItem.teacher_middlename))"
        groupListLabel.text = setLabelText(from: scheduleItem.group_list)
        noteLabel.text = setLabelText(from: scheduleItem.note_schedule)        
        yearLabel.text = String(scheduleItem.year ?? 0)
        semesterLabel.text = String(scheduleItem.semester ?? 0)
        numAuditoriumLabel.text = setLabelText(from: scheduleItem.num_auditorium_schedule)
        
        if scheduleItem.type_week_schedule == nil {
            typeWeekLabel.text = "не указано"
        }
        else if scheduleItem.type_week_schedule == 0 {
            typeWeekLabel.text = "каждую неделю"
        }
        else if scheduleItem.type_week_schedule == 1 {
            typeWeekLabel.text = "по нечетным неделям"
        }
        else if scheduleItem.type_week_schedule == 2 {
            typeWeekLabel.text = "по четным неделям"
        }
        buildingNameLabel.text = setLabelText(from: scheduleItem.building_name)
        endTimeLabel.text  = setLabelText(from: scheduleItem.end_time_schedule)
        beginTimeLabel.text = setLabelText(from: scheduleItem.begin_time_schedule)
    }
    
    func setLabelText(from: String?) -> String {
        if from == nil {
            return "??"
        }
        else if from == "" {
            return "не указано"
        }
        else {
            return from!
        }
    }

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
