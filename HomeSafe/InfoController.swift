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
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.title = "HomeSafe"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.addPressed(_:)))
        
        tableView.backgroundColor = UIColor.white
        tableView.register(InfoCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        view.addSubview(tableView)
        
    }
    
    func addPressed(_ sender: UIButton) {
        let vc = AlertController()
        let navController = UINavigationController(rootViewController: vc)
        present(navController, animated:true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = InfoCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.backgroundColor = UIColor.lightGray
        cell.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/3 - 1)
        
        let thumbnail: UIView = {
            let thumbView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/3 - 1))
            thumbView.backgroundColor = UIColor.white
            thumbView.clipsToBounds = true

            return thumbView
        }()
        cell.contentView.addSubview(thumbnail)
        cell.contentView.sendSubview(toBack: thumbnail)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("this should trigger a new map")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

class InfoCell: TableCell {
    
    var title: UILabel!
    var address: UILabel!
    var distance: UILabel!
    var content: UILabel!
    var timestamp: UILabel!

    override func setup() {
        title = UILabel()
        title.text = "Hello"
        title.font = UIFont.boldSystemFont(ofSize: 20)
        
        address = UILabel()
        address.text = "ur a POS Avenue"
        address.font = UIFont.boldSystemFont(ofSize: 14)
        
        distance = UILabel()
        distance.text = "< 1 mile away"
        distance.textColor = UIColor.lightGray
        distance.font = UIFont.systemFont(ofSize: 14)
        
        timestamp = UILabel()
        timestamp.text = "1 hr"
        timestamp.textColor = UIColor.lightGray
        timestamp.font = UIFont.systemFont(ofSize: 14)
        
        content = UILabel()
        content.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a cursus leo. Aenean at orci bibendum, malesuada orci facilisis, commodo turpis. Integer quis ornare massa."
        content.font = UIFont.boldSystemFont(ofSize: 16)
        content.numberOfLines = 0
        
        contentView.addSubview(title)
        contentView.addSubview(address)
        contentView.addSubview(distance)
        contentView.addSubview(timestamp)
        contentView.addSubview(content)
        
        contentView.addConstraintFormat("H:|-15-[v0]", views: title)
        contentView.addConstraintFormat("H:|-15-[v0]", views: address)
        contentView.addConstraintFormat("H:|-15-[v0]", views: distance)
        contentView.addConstraintFormat("H:[v0]-15-|", views: timestamp)
        contentView.addConstraintFormat("H:|-15-[v0]-15-|", views: content)
        contentView.addConstraintFormat("V:|-15-[v0][v1][v2]-15-[v3]", views: title, address, distance, content)
        contentView.addConstraintFormat("V:|-15-[v0]", views: timestamp)
    }
    
}

func newInstLabel(_ content: String, frame: CGRect) -> UILabel {
    let label = UILabel(frame: frame)
    label.text = content
    label.textColor = UIColor.white
//    label.font = UIFont.pmInstructionFont()
    label.numberOfLines = 0
    label.textAlignment = NSTextAlignment.center
    
    return label
}
