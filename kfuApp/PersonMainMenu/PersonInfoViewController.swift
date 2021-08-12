//
//  PersonInfoViewController.swift
//  kfuApp
//
//  Created by Гафиятуллин Самат on 26/05/2020.
//  Copyright © 2020 gafiyatullinsamat. All rights reserved.
//

import UIKit

class PersonInfoViewController: UIViewController {

    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var pointsButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var scheduleButton: UIButton!
    @IBOutlet weak var personPhotoImageView: UIImageView!
    @IBOutlet weak var FirstNameLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    var firstName: String = ""
    var Name: String = ""
    var URLPhoto: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.barTintColor = UIColor.systemBlue
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        if authList.employee == true {
            pointsButton.isHidden = true
            pointsLabel.isHidden = true
        }
        
        FirstNameLabel.text = authList.firstname
        NameLabel.text = authList.lastname
        let photo = downloadImage()
        personPhotoImageView.image = photo
        personPhotoImageView.contentMode = .scaleAspectFit
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scheduleButton.isEnabled = true
        pointsButton.isEnabled = true
    }
    
    @IBAction func exitButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LogVC") as! LoginViewController
        self.navigationController?.pushViewController(loginViewController, animated: true)
        UserDefaults.standard.set(false, forKey: "SessionState")
    }
    @IBAction func pointsButton(_ sender: Any) {
        
        pointsButton.isEnabled = false
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        var center = self.view.center
        center.y += 50
        activityView.center = center
        self.view.addSubview(activityView)
        
        activityView.startAnimating()
        
        downloadPoints(studId: authList.student_info?.student_id ?? 0, session: authList.p2 ?? "") {
            DispatchQueue.main.async {
                
                if pointList.successful == false {
                    print("error")
                    activityView.stopAnimating()
                    activityView.isHidden = true
                    
                    let alertController = UIAlertController(title: "Ошибка", message: "Сессия была завершена, войдите в учетную запись", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default) { (action1) in
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LogVC") as! LoginViewController
                        self.navigationController?.pushViewController(loginViewController, animated: true)
                        UserDefaults.standard.set(false, forKey: "SessionState")

                    }
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                }
                else {
                    activityView.stopAnimating()
                    activityView.isHidden = true
                
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let pointsVC = storyboard.instantiateViewController(withIdentifier: "myPointsVC") as! myPointsViewController
                    self.navigationController?.pushViewController(pointsVC, animated: true)
                }
            }
        }
        
    }
    
    @IBAction func scheduleButton(_ sender: Any) {
        
       
        scheduleButton.isEnabled = false
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        var center = self.view.center
        center.y += 10
        activityView.center = center
        self.view.addSubview(activityView)
        activityView.startAnimating()
        let nowYear = getYear()
        let nowSemester = getSemester()
        
        loadSchedule(isStudent: authList.student ?? true, group_id: authList.student_info?.student_group_id ?? 0, year: nowYear, semester: nowSemester) {
            
            DispatchQueue.main.async {
                activityView.stopAnimating()
                activityView.isHidden = true
            
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                //MARK: Старая таблица расписания (статичная)
                //let myViewController = storyboard.instantiateViewController(withIdentifier: "MyVC") as! ViewController
                //self.navigationController?.pushViewController(myViewController, animated: true)
                
                //MARK: Новая таблица расписания (пролистывание)
                let myViewController = storyboard.instantiateViewController(withIdentifier: "ScheduleMainViewController") as! ScheduleMainViewController
                self.navigationController?.pushViewController(myViewController, animated: true)
            }
        }
    }
    
    @IBAction func infoButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let infoVC = storyboard.instantiateViewController(withIdentifier: "infoVC") as! InfoTableViewController
        self.navigationController?.pushViewController(infoVC, animated: true)
        
    }
}
