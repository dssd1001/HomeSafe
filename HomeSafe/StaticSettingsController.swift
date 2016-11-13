//
//  StaticSettingsController.swift
//  HomeSafe
//
//  Created by Natsuki Takahari on 11/12/16.
//
//

import UIKit

class StaticSettingsController: UIViewController, UIScrollViewDelegate {
    
    var content = UILabel(frame: CGRect(x: 15, y: 10, width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height))
    
    let scrollView = UIScrollView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.backgroundColor = UIColor.white
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height*2)
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        content.numberOfLines = 0
        scrollView.addSubview(content)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
