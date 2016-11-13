//
//  InfoViewController.swift
//  HomeSafe
//
//  Created by Natsuki Takahari on 11/12/16.
//
//

import UIKit

class InfoController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.white
        tableView.register(InfoCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        view.addSubview(tableView)
        
    }
    
    /*
     Cells that trigger maps with what?
    */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.backgroundColor = UIColor.black
        cell.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 99)
        
        let thumbnail: UIView = {
            let thumbView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 99))
            thumbView.backgroundColor = UIColor.white
            thumbView.clipsToBounds = true

            return thumbView
        }()
        cell.contentView.addSubview(thumbnail)
        
        return cell
        
//        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
//        cell.backgroundColor = UIColor.clear
//        cell.frame = CGRect(x: 10, y: 8, width: view.frame.width - 20, height: 250)
//        
//        let thumbnail: UIView = {
//            let thumbView = UIView(frame: CGRect(x: 10, y: 8, width: view.frame.width - 20, height: 80))
//            thumbView.backgroundColor = UIColor.lightGray
//            thumbView.clipsToBounds = true
//            
//            thumbView.layer.cornerRadius = 5;
//            
//            return thumbView
//        }()
//        cell.contentView.addSubview(thumbnail)
//        cell.contentView.sendSubview(toBack: thumbnail)
//        
//        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("this should trigger a new map")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

class InfoCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
}
