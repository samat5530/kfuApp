//
//  WaitViewController.swift
//  kfuApp
//
//  Created by Гафиятуллин Самат on 03/06/2020.
//  Copyright © 2020 gafiyatullinsamat. All rights reserved.
//

import UIKit

class WaitViewController: UIViewController {

    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var login: String = ""
    var pass: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        activity.startAnimating()
        
        authorize(login: login, pass: pass) {
                   DispatchQueue.main.async {
                    
                    if authList.successful == true {
                       
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let personInfoViewController = storyboard.instantiateViewController(withIdentifier: "PersonVC") as! PersonInfoViewController
                        personInfoViewController.Name = authList.lastname ?? "Неизвестно"
                        personInfoViewController.firstName = authList.firstname ?? "Неизвестно"
                        personInfoViewController.URLPhoto = authList.student_info?.photo ?? "-1"
                        //    self.navigationController?.setViewControllers([personInfoViewController], animated: true)
                        self.navigationController?.pushViewController(personInfoViewController, animated: true)
                    }
                    
                    else {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LogVC") as! LoginViewController
                        UserDefaults.standard.set(false, forKey: "SessionState")
                        let alertController = UIAlertController(title: "Ошибка", message: authList.reason_text ?? "неизвестная ошибка", preferredStyle: .alert)
                        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                        alertController.addAction(action)
                        self.present(alertController, animated: true, completion: nil)
                        self.activity.stopAnimating()
                        self.activity.isHidden = true
                        self.navigationController?.pushViewController(loginViewController, animated: true)
                    }
                   }
               }
    }
}
