//
//  GetGroupViewController.swift
//  kfuApp
//
//  Created by Гафиятуллин Самат on 24/03/2020.
//  Copyright © 2020 gafiyatullinsamat. All rights reserved.
//

import UIKit

class GetGroupViewController: UIViewController,  UITextFieldDelegate {
    
    
    @IBOutlet weak var myTextField: UITextField!
    
    var myGlobalVar: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTextField.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        myTextField.resignFirstResponder()
       
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myTextField.resignFirstResponder()
        return true
    }
    
    
    
    @IBAction func myButton(_ sender: Any) {
        

        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        var center = self.view.center
        center.y += 10
        activityView.center = center
        self.view.addSubview(activityView)
        activityView.startAnimating()
        
        getId(name: myTextField.text ?? "0") {
            
            loadSchedule(isStudent: authList.student ?? true ,group_id: Id, year: 2019, semester: 2) {
                
                DispatchQueue.main.async {
                    activityView.stopAnimating()
                    activityView.isHidden = true
                    
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let myViewController = storyboard.instantiateViewController(withIdentifier: "MyVC") as! ViewController
                    myViewController.myVar = self.myTextField.text
                    let tabBarViewController = TabBarViewController()
                    tabBarViewController.setViewControllers([myViewController], animated: true)
                    tabBarViewController.selectedViewController = myViewController
                    self.navigationController?.pushViewController(tabBarViewController, animated: true)
                }
            }
        }
        
      /*
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myViewController = storyboard.instantiateViewController(withIdentifier: "MyVC") as! ViewController
        myViewController.myVar = myTextField.text
        let tabBarViewController = TabBarViewController()
    
        tabBarViewController.setViewControllers([myViewController], animated: true)

        tabBarViewController.selectedViewController = myViewController
//
        self.navigationController?.pushViewController(tabBarViewController, animated: true) */
    }

}

