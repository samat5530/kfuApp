//Модель загрузки расписания



import Foundation

struct Schedule: Decodable {
    var subjects: [Subject]
}

struct Subject: Decodable {
    var id: Int?
    var semester: Int?
    var year: Int?
    var subject_name: String?
    var subject_id: Int?
    var start_day_schedule: String?
    var finish_day_schedule: String?
    var day_week_schedule : Int?
    var type_week_schedule : Int?
    var note_schedule: String?
    var time_interval_id: Int?
    var total_time_schedule: String?
    var begin_time_schedule: String?
    var end_time_schedule: String?
    var teacher_id: Int?
    var teacher_lastname: String?
    var teacher_firstname: String?
    var teacher_middlename: String?
    var num_auditorium_schedule: String?
    var building_name:String?
    var building_id: Int?
    var group_list: String?
    var subject_kind_name: String?
}

var scheduleList: Schedule = Schedule(subjects: [])
var scheduleArray: [[Subject]] = []

//MARK: Загрузка расписания на основе id группы, года, семестра

func loadSchedule(isStudent: Bool, group_id: Int, year: Int, semester: Int, completion: @escaping () -> ()) {
    
    var jsonUrlString = ""
    
    if isStudent == true {
        jsonUrlString = "https://shelly.kpfu.ru/e-ksu/portal_pg_mobile.get_schedule?p_stud_group=\(group_id)&p_stud_year=\(year)&p_stud_semester=\(semester)"
    }
    else {
        jsonUrlString = "https://shelly.kpfu.ru/e-ksu/portal_pg_mobile.get_schedule?p_employee_id=\(group_id)&p_stud_year=\(year)&p_stud_semester=\(semester)"
    }
    
    guard let url = URL(string: jsonUrlString) else {return}
    let session  = URLSession(configuration: .default)
    let datatask = session.dataTask(with: url) { (urlData, response, error) in
        
        guard let data = urlData else {
            print("не загрузилось расписание")
            return
        }
        
        guard let dataAsStringCP1251 = String(data: data, encoding: String.Encoding.windowsCP1251) else {
            print("не получилось закодировать данные как строку windows cp 1251 (расписание)")
            return
        }
        guard let dataUtf8 = dataAsStringCP1251.data(using: String.Encoding.utf8) else {
                 print("could not convert to UTF (расписание)")
                 return
        }
        do {
                 scheduleList = try JSONDecoder().decode(Schedule.self, from: dataUtf8)
        }
        catch {
                 print("Serialization of schedule error")
        }
        subjectsByDay()
        
        completion()
                
    }
    datatask.resume()
}

//MARK: Количество дней в возвращенном ответе (принимает от 0 до 6, понедельник = 0)

func numberOfRowinSectionByDays(dayNumber: Int) -> Int {
    var count: Int = 0
    for i in scheduleList.subjects {
        let unwrap = i.day_week_schedule ?? 0
        if unwrap == dayNumber + 1 {
            count+=1
        }
    }
    return count
}

//MARK: Формирует полученное расписание как массив массивов в глобальную перменную sceduleArray (внешний массив = дни от 0 до 6)

func subjectsByDay() {
    for i in 0...6 {
        scheduleArray.append([])
        for j in scheduleList.subjects {
            if j.day_week_schedule == i + 1 {
                scheduleArray[i].append(j)
            }
        }
    }
}

//MARK: Возвращает текущий год (2020 = 2019, 2019=2019, 2021=2021, 2022=2021)

func getYear () -> Int {
    var result = 0
    let now = Date()
    let format = DateFormatter()
    format.dateFormat = "Y"
    result = Int(format.string(from: now)) ?? 0
    if result % 2 == 0 {
        return result - 1
    }
    else{
        return result
        
    }
}

//MARK: Возвращает текущий семестр (1 - с сентября и до конца января, 2 - с начала февраля и до конца августа)

func getSemester () -> Int {
    let now = Date()
    let format = DateFormatter()
    format.dateFormat = "M"
    let month = Int(format.string(from: now)) ?? 1
    if month >= 2 && month < 9 {
        return 2
    }
    else {
        return 1
    }
}
