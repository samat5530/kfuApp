import Foundation

struct Points: Decodable {
    var successful: Bool?
    var journal: [Point]?
}

struct Point: Decodable {
    var is_test: String?
    var is_exam: String?
    var semester_points: String?
    var semester: String?
    var subject_name: String?
    var type: String?
    var points_string: String?
    var exam_points: String?
    var pass_date: String?
    var total_points: String?
}

struct PointsByCourse {
    var First: [Point]
    var Second: [Point]
    var Third : [Point]
    var Fourth: [Point]
    var Fifth: [Point]
    var Sixth: [Point]
    init(){
        First = []
        Second = []
        Third = []
        Fourth = []
        Fifth = []
        Sixth = []
    }
}


var myPoints: [[Point]] = []
var pointListByCourses: PointsByCourse = PointsByCourse()
var pointList: Points = Points(successful: false, journal: [])

//MARK: -  Загрузка оценок

func downloadPoints(studId: Int, session: String, completion: @escaping () -> ()) {
    
    let urlString="https://shelly.kpfu.ru/e-ksu/portal_pg_mobile.get_academic_perfomance?p_stud_id=\(studId)&p2=\(session)"
    
    guard let url = URL(string: urlString) else {print("Не удалось создать ссылку для загрузки оценок");return }
    
    let session  = URLSession(configuration: .default)
    let datatask = session.dataTask(with: url) { (urlData, response, error) in
        
        guard let data = urlData else {
            print("не загрузились данные об оценках");return}
        
        guard let dataAsStringCP1251 = String(data: data, encoding: String.Encoding.windowsCP1251) else {
            print("не получилось закодировать данные");return}
        
        guard let dataUtf8 = dataAsStringCP1251.data(using: String.Encoding.utf8) else {
            print("could not convert to UTF");return}
        
        do {pointList = try JSONDecoder().decode(Points.self, from: dataUtf8)}
        
        catch {
            print("Serialization error")
            print(error);return}
        
        /*for i in pointList.journal ?? [] {
            let unwrap = i.semester
            if unwrap == "1 " || unwrap == "2 " {
                pointListByCourses.First.append(i)
            }
            if unwrap == "3 " || unwrap == "4 " {
                pointListByCourses.Second.append(i)
            }
            if unwrap == "5 " || unwrap == "6 " {
                pointListByCourses.Third.append(i)
            }
            if unwrap == "7 " || unwrap == "8 " {
                pointListByCourses.Fourth.append(i)
            }
            if unwrap == "9 " || unwrap == "10 " {
                pointListByCourses.Fifth.append(i)
            }
            else {
                pointListByCourses.Sixth.append(i)
            }
        }*/
        pointsBySemester()
        completion()
    }
    datatask.resume()
}

//MARK: - Распределение по курсам

func pointsBySemester() {
    
    for _ in 0...5 {
        myPoints.append([])
    }
    
    for j in pointList.journal ?? [] {
        
        let number = j.semester
        
        if number == "1 " || number == "2 " {
            myPoints[0].append(j)
        }
        if number == "3 " || number == "4 " {
            myPoints[1].append(j)
        }
        if number == "5 " || number == "6 " {
            myPoints[2].append(j)
        }
        if number == "7 " || number == "8 " {
            myPoints[3].append(j)
        }
        if number == "9 " || number == "10 " {
            myPoints[4].append(j)
        }
        if number == "11 " || number == "12 " {
            myPoints[5].append(j)
        }
    }
}

