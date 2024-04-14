//
//  ViewController.swift
//  FinnApp
//
//  Created by Даша Волошина on 13.02.24.
//

import UIKit
import SnapKit

class ViewController: UITabBarController {
    
    let  homeVC = UINavigationController(rootViewController: HomeViewController())
    let  historyVC = UINavigationController(rootViewController: HistoryController())
    let  settingsVC = UINavigationController(rootViewController: SettingsController())
    let  reportVC = UINavigationController(rootViewController: ReportViewController())
    var customTabBar = CustomTabBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setValue(customTabBar, forKey: "tabBar" )
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        historyVC.tabBarItem.image = UIImage(systemName: "doc.plaintext")
        settingsVC.tabBarItem.image = UIImage(systemName: "gearshape")
        reportVC.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle.portrait")
        
        self.setViewControllers([homeVC, historyVC,settingsVC, reportVC], animated: false)
//        
       
//        tabBar.itemPositioning = .centered
//        tabBar.itemSpacing = UIScreen.main.bounds.width / 10
//        tabBar.tintColor = UIColor.colorSelectedItem
//        tabBar.unselectedItemTintColor = UIColor.colorUnselectedItem
      
    }
    
    
}

