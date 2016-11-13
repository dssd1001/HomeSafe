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
        
        tableView.backgroundColor = UIColor(red: 160.0 / 255.0, green: 201.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0)
        
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
    
    let helpContent = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a cursus leo. Aenean at orci bibendum, malesuada orci facilisis, commodo turpis. Integer quis ornare massa. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In hac habitasse platea dictumst. In sagittis ullamcorper magna, sagittis sollicitudin metus vestibulum in. Fusce vitae nunc mattis, auctor leo sed, pellentesque ex. Fusce convallis elit non ipsum ultrices, quis pellentesque sapien ornare. Nunc aliquam vitae odio sit amet dictum. Pellentesque sit amet sodales risus. Quisque mattis mi eu diam imperdiet lacinia.\n\n\n Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec posuere nisl sit amet tortor accumsan mattis. Nulla bibendum ligula nunc, non semper velit auctor eget. Vestibulum viverra neque quis blandit dictum. Morbi congue vel lorem vitae laoreet. Aenean nec volutpat justo. Nullam mollis non massa in eleifend.\n\n\n Mauris faucibus fringilla tortor, at semper libero porta eu. Nulla facilisi. Proin et sodales sapien, sed sagittis augue. Nunc in efficitur dolor. Aliquam iaculis, risus et malesuada cursus, mi sem varius augue, ac euismod sapien lacus quis est. Praesent laoreet metus sit amet mattis sodales. Phasellus at dapibus velit. Aliquam dapibus odio at iaculis dictum. Praesent suscipit posuere urna, id hendrerit urna venenatis in. In ut augue ante. Maecenas nec tempus neque. Mauris nec ultrices elit."
    
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
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.section == 1 && indexPath.row == 0) {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 2) {
            let vc = StaticSettingsController()
            vc.content.text = helpContent
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 160.0 / 255.0, green: 201.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0)
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        footer.contentView.backgroundColor = UIColor(red: 160.0 / 255.0, green: 201.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0)
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
