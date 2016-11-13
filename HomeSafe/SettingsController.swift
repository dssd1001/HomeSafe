//
//  SettingsViewController.swift
//  HomeSafe
//
//  Created by Natsuki Takahari on 11/12/16.
//
//

import UIKit

class SettingsController: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orange
        
        let safety = UIImageView(image: UIImage(named: "muse.jpg"))
        let imgHeight = safety.image?.size.height
        
        scrollView.backgroundColor = UIColor.white
        scrollView.contentSize = CGSize(width: view.frame.width, height: imgHeight!)
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        scrollView.addSubview(safety)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
