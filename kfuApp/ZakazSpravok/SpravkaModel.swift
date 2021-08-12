import Foundation

struct Regions: Decodable {
    var regions: [Region]?
    var regions_kazan: [Region]?
}

struct Region: Decodable {
    var region_id: String
    var region_name: String
}

struct SpravkaInfo: Decodable {
    var address: String?
    var faculty: String?
}

struct Zakaz: Decodable {
    var successful: Bool?
}



var zakaz: Zakaz = Zakaz()
var spravkaInfo: SpravkaInfo = SpravkaInfo()
var regionList: Regions = Regions()

func getRegions(completion: @escaping () -> ()) {
    
    let jsonUrlString="https://shelly.kpfu.ru/e-ksu/portal_pg_mobile.get_regions_hr"
    
    guard let url = URL(string: jsonUrlString) else {return }
    let session  = URLSession(configuration: .default)
    let datatask = session.dataTask(with: url) { (urlData, response, error) in
        
        guard let data = urlData else {
            print("не загрузились данные регионов")
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
            regionList = try JSONDecoder().decode(Regions.self, from: dataUtf8)
        }
        catch {
            print("Serialization error")
            return
        }
        completion()
        
    }
    datatask.resume()
}

func getAddress(user_id: Int, completion: @escaping () -> ()) {
    
    let jsonUrlString="https://shelly.kpfu.ru/e-ksu/portal_pg_mobile.get_info_request_doc_hr?p_user_id=\(user_id)"
    
    
    guard let url = URL(string: jsonUrlString) else {return }
    let session  = URLSession(configuration: .default)
    let datatask = session.dataTask(with: url) { (urlData, response, error) in
        
        guard let data = urlData else {
            print("не загрузились данные о справке")
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
            spravkaInfo = try JSONDecoder().decode(SpravkaInfo.self, from: dataUtf8)
        }
        catch {
            print("Serialization error")
            return
        }
        completion()
    }
    datatask.resume()
}

func getZakazOtdelKadrov(user_id: Int, sessionId: String, email: String, count: String, completion: @escaping () -> ()) {
    
    let jsonUrlString="https://portal-dis.kpfu.ru/e-ksu/portal_pg_mobile.request_doc_hr?p_user_id=\(user_id)&p2=\(sessionId)&p_email=\(email)&p_quantity=\(count)&p_agree_status=1&p_doc_type=2"
    
    
    guard let url = URL(string: jsonUrlString) else {return }
    let session  = URLSession(configuration: .default)
    let datatask = session.dataTask(with: url) { (urlData, response, error) in
        
        guard let data = urlData else {
            print("не загрузились данные о справке")
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
            zakaz = try JSONDecoder().decode(Zakaz.self, from: dataUtf8)
        }
        catch {
            print("Serialization error")
            return
        }
        completion()
    }
    datatask.resume()
}

func getZakazPensionFond(user_id: Int, sessionId: String, email: String, count: String, city: String, region: String, completion: @escaping () -> ()) {
    
    let jsonUrlString="https://portal-dis.kpfu.ru/e-ksu/portal_pg_mobile.request_doc_hr?p_user_id=\(user_id)&p2=\(sessionId)&p_email=\(email)&p_quantity=\(count)&p_agree_status=1&p_doc_type=1&p_city=\(city)&p_region=\(region)"
    
    
    guard let url = URL(string: jsonUrlString) else {return }
    let session  = URLSession(configuration: .default)
    let datatask = session.dataTask(with: url) { (urlData, response, error) in
        
        guard let data = urlData else {
            print("не загрузились данные о справке")
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
            zakaz = try JSONDecoder().decode(Zakaz.self, from: dataUtf8)
        }
        catch {
            print("Serialization error")
            return
        }
        completion()
    }
    datatask.resume()
}

func getZakazPensionFondKazan(user_id: Int, sessionId: String, email: String, count: String, city: String, region: String, kazanRegion: String, completion: @escaping () -> ()) {
    
    let jsonUrlString="https://portal-dis.kpfu.ru/e-ksu/portal_pg_mobile.request_doc_hr?p_user_id=\(user_id)&p2=\(sessionId)&p_email=\(email)&p_quantity=\(count)&p_agree_status=1&p_doc_type=1&p_city=\(city)&p_region=\(region)&p_kzn_region=\(kazanRegion)"
    
    
    guard let url = URL(string: jsonUrlString) else {return }
    let session  = URLSession(configuration: .default)
    let datatask = session.dataTask(with: url) { (urlData, response, error) in
        
        guard let data = urlData else {
            print("не загрузились данные о справке")
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
            zakaz = try JSONDecoder().decode(Zakaz.self, from: dataUtf8)
        }
        catch {
            print("Serialization error")
            return
        }
        completion()
    }
    datatask.resume()
}

func getZakazRaschet(user_id: Int, sessionId: String, email: String, count: String, docType: String, completion: @escaping () -> ()) {
    
    let jsonUrlString="https://portal-dis.kpfu.ru/e-ksu/portal_pg_mobile.request_doc_buh?p_user_id=\(user_id)&p2=\(sessionId)&p_email=\(email)&p_quantity=\(count)&p_agree_status=1&p_doc_type=\(docType)"
    
    
    guard let url = URL(string: jsonUrlString) else {return }
    let session  = URLSession(configuration: .default)
    let datatask = session.dataTask(with: url) { (urlData, response, error) in
        
        guard let data = urlData else {
            print("не загрузились данные о справке")
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
            zakaz = try JSONDecoder().decode(Zakaz.self, from: dataUtf8)
        }
        catch {
            print("Serialization error")
            return
        }
        completion()
    }
    datatask.resume()
}

func getZakazRaschetWithPeriodPlace(user_id: Int, sessionId: String, email: String, count: String, docType: String, period: String, place: String, completion: @escaping () -> ()) {
    
    let jsonUrlString="https://portal-dis.kpfu.ru/e-ksu/portal_pg_mobile.request_doc_buh?p_user_id=\(user_id)&p2=\(sessionId)&p_email=\(email)&p_quantity=\(count)&p_agree_status=1&p_doc_type=\(docType)&p_period=\(period)&p_place=\(place)"
    
    
    guard let url = URL(string: jsonUrlString) else {return }
    let session  = URLSession(configuration: .default)
    let datatask = session.dataTask(with: url) { (urlData, response, error) in
        
        guard let data = urlData else {
            print("не загрузились данные о справке")
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
            zakaz = try JSONDecoder().decode(Zakaz.self, from: dataUtf8)
        }
        catch {
            print("Serialization error")
            return
        }
        completion()
    }
    datatask.resume()
}


