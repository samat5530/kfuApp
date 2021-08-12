import UIKit

class ScheduleTableViewController: UITableViewController {

    @IBOutlet var noItemsView: UIView!
    var currentDate: Date?
    var dayOfWeek: Int = 0
    var index: Int = 0
    var formattedDate: String = "00.00.00"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Установка формата отображения даты и получение дня недели
        let dateFormatter = DateFormatter()
        let dateFormatterAsIntForWeekDay = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        dateFormatterAsIntForWeekDay.dateFormat = "ee"
        formattedDate = dateFormatter.string(from: currentDate ?? Date())
        dayOfWeek = Int(dateFormatterAsIntForWeekDay.string(from: currentDate ?? Date())) ?? 1
        dayOfWeek -= 1
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        //MARK: Регистрация ячейки
        
        tableView.register(UINib(nibName: "ScheduleCell", bundle: nil), forCellReuseIdentifier: "ScheduleCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "scheduleDetails" {
            var state : Int = 0
            state = tableView.indexPathForSelectedRow!.row
            /*if dayOfWeek == 0 {
                state = tableView.indexPathForSelectedRow!.row
            }
            else {
                state = tableView.indexPathForSelectedRow!.row + breakInScheduleArray(counter: dayOfWeek)
            }
            
            (segue.destination as? DetailScheduleViewController)?.scheduleItem = scheduleList.subjects[state]*/
            (segue.destination as? DetailScheduleViewController)?.scheduleItem = scheduleArray[dayOfWeek][state]
            
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "scheduleDetails", sender: self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = scheduleArray[dayOfWeek].count
        if count == 0 {
            self.tableView.backgroundView = noItemsView
        }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as? ScheduleCell else {return UITableViewCell()}
        
        cell.scheduleNameLabel.text = scheduleArray[dayOfWeek][indexPath.row].subject_name ?? "Неизвестно"
        cell.beginTimeScheduleLabel.text = scheduleArray[dayOfWeek][indexPath.row].begin_time_schedule ?? "??:??"
        cell.endTimeScheduleLabel.text = scheduleArray[dayOfWeek][indexPath.row].end_time_schedule ?? "??:??"
        cell.numAuditoriumScheduleLabel.text = scheduleArray[dayOfWeek][indexPath.row].num_auditorium_schedule ?? "???"
        cell.buildingNameScheduleLabel.text = scheduleArray[dayOfWeek][indexPath.row].building_name ?? "??"
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
}
