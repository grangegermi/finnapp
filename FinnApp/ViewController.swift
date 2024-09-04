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
        
        customTabBar.button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        
        self.setViewControllers([homeVC, historyVC,settingsVC, reportVC], animated: false)
        
        
       
       
//        tabBar.itemPositioning = .centered
//        tabBar.itemSpacing = UIScreen.main.bounds.width / 10
//        tabBar.tintColor = UIColor.colorSelectedItem
//        tabBar.unselectedItemTintColor = UIColor.colorUnselectedItem
      
    }
    
    
//    func reloud() {
//        let vcHome = HomeViewController()
//        DispatchQueue.main.async {
//            vcHome.collectionView.reloadData()
//            MoneyCoreData.shared.fetchSpanding()
//        }
//       
//    }
    
    @objc func actionButton(_sender:UIButton) {
        let vc = AddController()
        if let sheet = vc.sheetPresentationController{
            sheet.detents = [.large()]
            
        } 
//        self.navigationController?.pushViewController(vc, animated: true)
        present(vc, animated: true)
//        vc.modalPresentationStyle = .pageSheet
//        self.navigationController?.modalPresentationStyle = .pageSheet
//        self.navigationController?.pushViewController(vc, animated: true)
//        let vc = AddController()
        
//        vc.delegate = self
        
        
        
//        
      
      

    }
    
}

