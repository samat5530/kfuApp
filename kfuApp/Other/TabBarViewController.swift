//
//  TabBarViewController.swift
//  kfuApp
//
//  Copyright © 2020 gafiyatullinsamat. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

//       self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Изменить группу", style: UIBarButtonItemStyle.plain, target: self, action: #selector(popMyVC(param:)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Селектор для кнопки
    
 //   @objc func popMyVC (param: UIBarButtonItem) {
//        self.navigationController?.popViewController(animated: true)
//    }

}
