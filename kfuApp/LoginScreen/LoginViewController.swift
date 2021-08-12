//
//  LoginViewController.swift
//  kfuApp
//
//  Created by Гафиятуллин Самат on 25/05/2020.
//  Copyright © 2020 gafiyatullinsamat. All rights reserved.
//

import UIKit
import Locksmith

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        let color1 = UIColor(red: 0/255, green: 100/255, blue: 255/255, alpha: 1.0).cgColor
        let color = self.view.backgroundColor ?? UIColor()
        
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [color, color1]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        view.layer.insertSublayer(gradient, at: 0)
        
        self.navigationController?.isNavigationBarHidden = true
        
        loginTextField.delegate = self
        passTextField.delegate = self
        passTextField.isSecureTextEntry = true
        loginTextField.returnKeyType = .next
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == loginTextField {
            textField.resignFirstResponder()
            passTextField.becomeFirstResponder()
            return true
        }
        else if textField == passTextField {
            textField.resignFirstResponder()
            return true
        }
        else {
            return false
        }
    }
    

    @IBAction func enterButton(_ sender: Any) {
        
        if loginTextField.text == "" || passTextField.text == "" || loginTextField.text == nil || passTextField.text == nil {
            let alertController = UIAlertController(title: "Ошибка", message: "Введите логин и пароль и попробуйте снова", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            var center = self.view.center
            center.y += 100
            activityView.center = center
            self.view.addSubview(activityView)
            activityView.startAnimating()
            
            authorize(login: loginTextField.text ?? "0", pass: passTextField.text ?? "0") {
                        DispatchQueue.main.async {
                        
                        if authList.successful == true {
            
                            UserDefaults.standard.set(true, forKey: "SessionState")
                            
                            if let login = self.loginTextField.text, let password = self.passTextField.text {
                                do {
                                    try Locksmith.saveData(data: ["login" : login, "password" : password], forUserAccount: "mainAccount")
                                }
                                catch {
                                    print("Не удалось сохранить данные")
                                }
                            }
                            
                            activityView.stopAnimating()
                            activityView.isHidden = true
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let personInfoViewController = storyboard.instantiateViewController(withIdentifier: "PersonVC") as! PersonInfoViewController
                            personInfoViewController.Name = authList.lastname ?? "Неизвестно"
                            personInfoViewController.firstName = authList.firstname ?? "Неизвестно"
                            personInfoViewController.URLPhoto = authList.student_info?.photo ?? "-1"
                            //    self.navigationController?.setViewControllers([personInfoViewController], animated: true)
                            self.navigationController?.pushViewController(personInfoViewController, animated: true)
                        }
                        
                        else {
                        
                            let alertController = UIAlertController(title: "Ошибка", message: authList.reason_text ?? "неизвестная ошибка", preferredStyle: .alert)
                            let action = UIAlertAction(title: "ok", style: .default, handler: nil)
                            alertController.addAction(action)
                            self.present(alertController, animated: true, completion: nil)
                            activityView.stopAnimating()
                            activityView.isHidden = true
                        }
                            
                            
                        }
                    }
        
        }
        
       
    
    }
    
}
