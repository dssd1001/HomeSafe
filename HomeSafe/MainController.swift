//
//  ViewController.swift
//  HomeSafe
//
//  Created by Natsuki Takahari on 11/12/16.
//
//

import UIKit

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = UIColor.white
        tabBar.tintColor = UIColor.gray
        
        let first = MapController()
        let firstNav = UINavigationController(rootViewController: first)
        firstNav.tabBarItem.title = "Map"
        firstNav.tabBarItem.image = UIImage(named: "quests")
//        firstNav.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.pmTabFont()!, NSForegroundColorAttributeName : UIColor.black], for: .normal)
//        firstNav.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.pmTabFont()!, NSForegroundColorAttributeName : UIColor.white], for: .selected)
        
        let second = InfoController()
        let secondNav = UINavigationController(rootViewController: second)
        secondNav.tabBarItem.title = "Info"
        secondNav.tabBarItem.image = UIImage(named: "quests")
//        secondNav.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.pmTabFont()!, NSForegroundColorAttributeName : UIColor.black], for: .normal)
//        secondNav.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.pmTabFont()!, NSForegroundColorAttributeName : UIColor.white], for: .selected)
        
        let third = SettingsController()
        let thirdNav = UINavigationController(rootViewController: third)
        thirdNav.tabBarItem.title = "Settings"
        thirdNav.tabBarItem.image = UIImage(named: "quests")
//        thirdNav.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.pmTabFont()!, NSForegroundColorAttributeName : UIColor.black], for: .normal)
//        thirdNav.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.pmTabFont()!, NSForegroundColorAttributeName : UIColor.white], for: .selected)

        viewControllers = [thirdNav, firstNav, secondNav]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

