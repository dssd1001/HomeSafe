//
//  InfoViewController.swift
//  HomeSafe
//
//  Created by Natsuki Takahari on 11/12/16.
//
//

import UIKit
import MapKit

class InfoController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView(frame: UIScreen.main.bounds)
    var locations: NSArray!
    
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
        
        let path = Bundle.main.path(forResource: "incidents", ofType: "plist")
        locations = NSArray(contentsOfFile: path!)
        
    }
    
    func addPressed(_ sender: UIButton) {
        let vc = AlertController()
        let navController = UINavigationController(rootViewController: vc)
        present(navController, animated:true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = InfoCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.backgroundColor = UIColor.lightGray
        cell.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/4 - 1)
        cell.title.text = (locations[indexPath.item] as AnyObject).value(forKey: "title") as? String
        cell.coord.latitude = (locations[indexPath.item] as AnyObject).value(forKey: "lat") as! CLLocationDegrees
        cell.coord.longitude = (locations[indexPath.item] as AnyObject).value(forKey: "long") as! CLLocationDegrees
        
        let thumbnail: UIView = {
            let thumbView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/4 - 1))
            thumbView.backgroundColor = UIColor.white
            thumbView.clipsToBounds = true

            return thumbView
        }()
        cell.contentView.addSubview(thumbnail)
        cell.contentView.sendSubview(toBack: thumbnail)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InfoCell
        let vc = CustomMapController()
        vc.userLocation = cell.coord
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

class InfoCell: TableCell {
    
    var title: UILabel!
    var distance: UILabel!
    var content: UILabel!
    var timestamp: UILabel!
    var coord: CLLocationCoordinate2D!

    override func setup() {
        coord = CLLocationCoordinate2D()
        
        title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 18)
        
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
        content.font = UIFont.systemFont(ofSize: 14)
        content.numberOfLines = 0
        
        contentView.addSubview(title)
        contentView.addSubview(distance)
        contentView.addSubview(timestamp)
        contentView.addSubview(content)
        
        contentView.addConstraintFormat("H:|-15-[v0]", views: title)
        contentView.addConstraintFormat("H:|-15-[v0]", views: distance)
        contentView.addConstraintFormat("H:[v0]-15-|", views: timestamp)
        contentView.addConstraintFormat("H:|-15-[v0]-15-|", views: content)
        contentView.addConstraintFormat("V:|-15-[v0][v1]-15-[v2]", views: title, distance, content)
        contentView.addConstraintFormat("V:|-15-[v0]", views: timestamp)
    }
    
}
