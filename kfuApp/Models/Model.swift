import Foundation
import UIKit

//MARK : Авторизация

struct Authorize: Decodable{
    var successful: Bool?
    var user_id: Int?
    var employee: Bool?
    var student: Bool?
    var student_info : StudentInfo?
    var person: Bool?
    var firstname: String?
    var lastname: String?
    var middlename: String?
    var p2: String?
    var reason: Int?
    var reason_text: String?
    var additionally : String?
}

struct StudentInfo: Decodable {
    var student_id: Int?
    var student_email: String?
    var photo: String?
    var photo_id: Int?
    var sex: String?
    var student_birth_date: String?
    var student_birth_place: String?
    var student_group_id: Int?
    var student_specialization_name: String?
    var student_speciality_name: String?
    var student_institute_name: String?
    var student_current_course: Int?
    var student_time_education: Int?
    var student_group_name: String?
}



//MARK: Group list Data Model from JSON

struct Group: Decodable {
    var group_id: Int
    var group_name: String
}

struct Groupes: Decodable {
    var group_list: [Group]
}


var authList : Authorize = Authorize()
var groupList: Groupes = Groupes(group_list: [])
var Id: Int = -1


//MARK: метод загрузки групп

func getId(name: String, completion: @escaping () -> ()) {
    
    let jsonUrlString="https://shelly.kpfu.ru/e-ksu/portal_pg_mobile.get_group_list"
    
    guard let url = URL(string: jsonUrlString) else {return }
    let session  = URLSession(configuration: .default)
    let datatask = session.dataTask(with: url) { (urlData, response, error) in
        
        guard let data = urlData else {
            print("не загрузились данные групп")
            return
        }
        
        guard let dataAsStringCP1251 = String(data: data, encoding: String.Encoding.windowsCP1251) else {
            print("не получилось закодировать данные как строку windows cp 1251")
            return
        }
        
        
        guard let dataUtf8 = dataAsStringCP1251.data(using: String.Encoding.utf8) else {
            print("could not convert to UTF")
            return
        }
        
        do {
            groupList = try JSONDecoder().decode(Groupes.self, from: dataUtf8)
        }
        catch {
            print("Serialization error")
            return
        }
        
        for item in groupList.group_list{
            if item.group_name == name{
                Id = item.group_id
            }
        }
        completion()
        
    }
    datatask.resume()
}


//MARK: Функция, возвращающая количество пар из расписания в определенный день



//MARK: Функция, возвращающая истину, при наличии пар в расписании в определенный день

func dayDoesExistInSchedule(dayNumber: Int) -> Bool {
    var check = false
    for i in scheduleList.subjects {
        let unwrap = i.day_week_schedule ?? 0
        if unwrap == dayNumber{
            check = true
        }
    }
    return check
}

//MARK: Функция, возвращающая индекс, с которого нужно начать чтение расписания для определенного дня

func breakInScheduleArray (counter: Int) -> Int {
    var total = 0
    for j in 0...counter-1 {
        total += numberOfRowinSectionByDays(dayNumber: j)
    }
    return total
}

//MARK: Авторизация

func authorize(login: String, pass: String, completion: @escaping () -> ()) {
    
    let jsonUrlString="https://shelly.kpfu.ru/e-ksu/portal_pg_mobile.authentication?p_login=\(login)&p_pass=\(pass)"
    
    guard let url = URL(string: jsonUrlString) else {return }
    let session  = URLSession(configuration: .default)
    let datatask = session.dataTask(with: url) { (urlData, response, error) in
        
        guard let data = urlData else {
            print("не загрузились данные об авторизации")
            return
        }
        
        guard let dataAsStringCP1251 = String(data: data, encoding: String.Encoding.windowsCP1251) else {
            print("не получилось закодировать данные как строку windows cp 1251")
            return
        }
        print(dataAsStringCP1251)
        guard let dataUtf8 = dataAsStringCP1251.data(using: String.Encoding.utf8) else {
            print("could not convert to UTF")
            return
        }
        
        do {
            authList = try JSONDecoder().decode(Authorize.self, from: dataUtf8)
        }
        catch {
            print("Serialization error")
            return
        }
        
        print(authList)
        completion()
        
    }
    datatask.resume()
}

func downloadImage() -> UIImage {
    if authList.student_info?.photo == nil {
        return UIImage()
    }
    else {
        guard let url = URL(string: "https://shelly.kpfu.ru/e-ksu/docs/\(authList.student_info!.photo!)") else {print("URL не создан"); return UIImage()}
        guard let data = try? Data(contentsOf: url) else {print("не загружена дата"); return UIImage()}
        guard let image = UIImage(data: data) else {print("не получилось данные преобразовать в изображение"); return UIImage()}
        return image
    }
}



