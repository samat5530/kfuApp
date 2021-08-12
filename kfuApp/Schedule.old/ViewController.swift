

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var daysTableView: UITableView!
    
    @IBOutlet weak var groupLabel: UILabel!
    var daysSegmentedControl = UISegmentedControl()
    var days = ["пн","вт","ср","чт","пт","сб","вс"]
    
    var myVar: String? = "Расписание"
//    var counter : Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Расписание"
        /* Старые инструкции для метода из первой версии программы
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        groupLabel.text = myVar
        
        var tabBarItem = UITabBarItem()
        tabBarItem = UITabBarItem(title: "Расписание", image: #imageLiteral(resourceName: "scheduleIcon"), tag: 0)
        self.tabBarItem = tabBarItem
        */
       self.navigationController?.isNavigationBarHidden = false
       self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        
        
        groupLabel.text = myVar
        groupLabel.isHidden = true
        
  
        createDaysSegmentedControl()
        daysSegmentedControl.selectedSegmentIndex = 0
        daysSegmentedControl.addTarget(self, action: #selector(selectedValueForSG), for: .valueChanged)

    }
    
    @objc func selectedValueForSG(target: UISegmentedControl) {
        if target == self.daysSegmentedControl {
            daysTableView.reloadData()
        }
    }
    
    func createDaysSegmentedControl(){
        self.daysSegmentedControl = UISegmentedControl(items: self.days)
        self.daysSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.daysSegmentedControl.frame = CGRect(x: 1, y: 78, width: self.view.frame.size.width, height: 30)
        //self.daysSegmentedControl.autoresizingMask = [.flexibleWidth]
        self.view.addSubview(self.daysSegmentedControl)
        
        NSLayoutConstraint(item: daysSegmentedControl,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .leading,
                           multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(item: daysSegmentedControl,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .topMargin,
                           multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(item: daysSegmentedControl,
                           attribute: .centerX,
                       relatedBy: .equal,
                       toItem: view,
                       attribute: .centerX,
                       multiplier: 1,
        constant: 0).isActive = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToDetail" {
            var state : Int = 0
            
            if daysSegmentedControl.selectedSegmentIndex == 0 {
                state = daysTableView.indexPathForSelectedRow!.row
            }
            else {
                state = daysTableView.indexPathForSelectedRow!.row + breakInScheduleArray(counter: daysSegmentedControl.selectedSegmentIndex)
            }
            
            (segue.destination as? DetailScheduleViewController)?.scheduleItem = scheduleList.subjects[state]
            
            daysTableView.deselectRow(at: daysTableView.indexPathForSelectedRow!, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = numberOfRowinSectionByDays(dayNumber: daysSegmentedControl.selectedSegmentIndex)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? ScheduleTableViewCell else {
            return UITableViewCell()
        }
        
       // if cell == nil {
       //     cell = UITableViewCell(style: .value1, reuseIdentifier: "myCell")
       // }
        
        if daysSegmentedControl.selectedSegmentIndex == 0 {
           // cell.textLabel?.text = scheduleList.subjects[indexPath.row].begin_time_schedule ?? "??:??"
           // cell.detailTextLabel?.text = scheduleList.subjects[indexPath.row].subject_name ?? "Неизвестно"
            cell.scheduleNameLabel.text = scheduleList.subjects[indexPath.row].subject_name ?? "Неизвестно"
            cell.beginTimeScheduleLabel.text = scheduleList.subjects[indexPath.row].begin_time_schedule ?? "??:??"
            cell.endTimeScheduleLabel.text = scheduleList.subjects[indexPath.row].end_time_schedule ?? "??:??"
            cell.numAuditoriumScheduleLabel.text = scheduleList.subjects[indexPath.row].num_auditorium_schedule ?? "???"
            cell.buildingNameScheduleLabel.text = scheduleList.subjects[indexPath.row].building_name ?? "??"
        }
        else{
            let total = breakInScheduleArray(counter: daysSegmentedControl.selectedSegmentIndex)
            //cell.textLabel?.text = scheduleList.subjects[indexPath.row + total].begin_time_schedule ?? "??:??"
            //cell.detailTextLabel?.text = scheduleList.subjects[indexPath.row + total].subject_name ?? "Неизвестно"
            cell.scheduleNameLabel.text = scheduleList.subjects[indexPath.row + total].subject_name ?? "Неизвестно"
            cell.beginTimeScheduleLabel.text = scheduleList.subjects[indexPath.row + total].begin_time_schedule ?? "??:??"
            cell.endTimeScheduleLabel.text = scheduleList.subjects[indexPath.row + total].end_time_schedule ?? "??:??"
            cell.numAuditoriumScheduleLabel.text = scheduleList.subjects[indexPath.row + total].num_auditorium_schedule ?? "???"
            cell.buildingNameScheduleLabel.text = scheduleList.subjects[indexPath.row + total].building_name ?? "??"
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
    /*@IBAction func myButton(_ sender: Any) {
       // Id = -1
       // self.navigationController?.popViewController(animated: true)
    }*/
}


