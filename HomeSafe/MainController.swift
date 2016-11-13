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
        firstNav.tabBarItem.image = UIImage(named: "Map")
//        firstNav.tabBarItem.imageInsets = 
        
        let second = InfoController()
        let secondNav = UINavigationController(rootViewController: second)
        secondNav.tabBarItem.title = "Feed"
        secondNav.tabBarItem.image = UIImage(named: "Feed")
        
        let third = SettingsController()
        let thirdNav = UINavigationController(rootViewController: third)
        thirdNav.tabBarItem.title = "Settings"
        thirdNav.tabBarItem.image = UIImage(named: "Settings")
        
        viewControllers = [firstNav, secondNav, thirdNav]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
