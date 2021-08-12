//
//  AppDelegate.swift
//  kfuApp
//
//  Created by Гафиятуллин Самат on 03/03/2020.
//  Copyright © 2020 gafiyatullinsamat. All rights reserved.
//

import UIKit
import Locksmith

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Инициализация нашего сториборда из проекта
        
        // MARK: Инициализация контроллеров из сториборда

        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LogVC") as! LoginViewController
//        let groupViewController = storyboard.instantiateViewController(withIdentifier: "GroupVC") as! GetGroupViewController
        
        // MARK: Инициализация контроллера навигации для модуля "Расписание"
        
        
        let state = UserDefaults.standard.bool(forKey: "SessionState")
        
        if state {
            
            let dictionary: [String: Any]! = Locksmith.loadDataForUserAccount(userAccount: "mainAccount")
            let login = dictionary["login"] as! String
            let pass = dictionary["password"] as! String
            
            let WaitVC = storyboard.instantiateViewController(withIdentifier: "WaitVC") as! WaitViewController
            WaitVC.login = login
            WaitVC.pass = pass
            
            let NavViewController = UINavigationController(rootViewController: WaitVC)
            self.window?.rootViewController = NavViewController
            self.window?.backgroundColor = UIColor.white
            self.window?.makeKeyAndVisible()
            
        }
        else {
            let NavViewController = UINavigationController(rootViewController: loginViewController)
            self.window?.rootViewController = NavViewController
            self.window?.backgroundColor = UIColor.white
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

