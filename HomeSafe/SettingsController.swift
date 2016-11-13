//
//  SettingsViewController.swift
//  HomeSafe
//
//  Created by Natsuki Takahari on 11/12/16.
//
//

import UIKit

class SettingsController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.lightGray
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationItem.title = "Settings"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 2) {
            return 3
        }
        return 2
    }
    
    let thirdSetting = ["Help", "Legal", "About"]
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cellID")
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
            cell.textLabel?.text = "Option \(indexPath.row)"
            
            return cell
        } else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cellID")
                cell.detailTextLabel?.text = "v1.0.0"
                
                cell.textLabel?.text = "App Version"
                
                return cell
            }
            let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellID")
            cell.textLabel?.textAlignment = NSTextAlignment.center
            
            cell.textLabel?.text = "Send Feedback"
            
            return cell
        } else{
            let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cellID")
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
            cell.textLabel?.text = "\(thirdSetting[indexPath.row])"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.lightGray
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        footer.contentView.backgroundColor = UIColor.lightGray
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 50.0
        }
        return 30.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
