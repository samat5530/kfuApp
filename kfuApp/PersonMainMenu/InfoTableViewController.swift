//
//  InfoTableViewController.swift
//  kfuApp
//
//  Created by Гафиятуллин Самат on 08/06/2020.
//  Copyright © 2020 gafiyatullinsamat. All rights reserved.
//

import UIKit

class InfoTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Информация"
        
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        if authList.employee == true {
            title = "Информация о сотруднике"
            return title
        }
        else if authList.student == true {
            title = "Информация о студенте"
            return title
        }
        else {return title}
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if authList.employee == true {
            return 3
        }
        else if authList.student == true {
            return 12
        }
        else {return 3}
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)

        if authList.employee == true {
        
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Фамилия"
                cell.detailTextLabel?.text = authList.lastname ?? ""
            case 1:
                cell.textLabel?.text = "Имя"
                cell.detailTextLabel?.text = authList.firstname ?? ""
            case 2:
                cell.textLabel?.text = "Отчество"
                cell.detailTextLabel?.text = authList.middlename ?? ""
            default:
                cell.textLabel?.text = ""
                cell.detailTextLabel?.text = ""
            }
        }
        else if authList.student == true {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Фамилия"
                cell.detailTextLabel?.text = authList.lastname ?? ""
                return cell
            case 1:
                cell.textLabel?.text = "Имя"
                cell.detailTextLabel?.text = authList.firstname ?? ""
                return cell
            case 2:
                cell.textLabel?.text = "Отчество"
                cell.detailTextLabel?.text = authList.middlename ?? ""
            case 3:
                cell.textLabel?.text = "Пол"
                cell.detailTextLabel?.text = authList.student_info?.sex ?? ""
            case 4:
                cell.textLabel?.text = "email"
                cell.detailTextLabel?.text = authList.student_info?.student_email ?? ""
            case 5:
                cell.textLabel?.text = "Дата рождения"
                cell.detailTextLabel?.text = authList.student_info?.student_birth_date ?? ""
            case 6:
                cell.textLabel?.text = "Место рождения"
                cell.detailTextLabel?.text = authList.student_info?.student_birth_place ?? ""
            case 7:
                cell.textLabel?.text = "Группа"
                cell.detailTextLabel?.text = authList.student_info?.student_group_name ?? ""
            case 8:
                cell.textLabel?.text = "Институт"
                cell.detailTextLabel?.text = authList.student_info?.student_institute_name ?? ""
            case 9:
                cell.textLabel?.text = "Направление"
                cell.detailTextLabel?.text = authList.student_info?.student_specialization_name ?? ""
            case 10:
                cell.textLabel?.text = "Специальность"
                cell.detailTextLabel?.text = authList.student_info?.student_speciality_name
            case 11:
                cell.textLabel?.text = "Курс"
                cell.detailTextLabel?.text = String(authList.student_info?.student_current_course ?? 0)
            default:
                cell.textLabel?.text = ""
                cell.detailTextLabel?.text = ""
            }
        }
       return cell
    }

}
