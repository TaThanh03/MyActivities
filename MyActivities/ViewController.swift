//
//  ViewController.swift
//  MyActivities
//
//  Created by TA Trung Thanh on 09/12/2018.
//  Copyright © 2018 TA Trung Thanh. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    private var content = [[OneCell]]()
    
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        self.tableView.separatorColor = .clear
        var inSection = [OneCell]()
        inSection += [OneCell(l: "Look for vacation", d: 4)]
        content += [inSection]
        
        inSection = [OneCell]()
        inSection += [OneCell(l: "Make some shopping", d: 2)]
        content += [inSection]
        
        inSection = [OneCell]()
        inSection += [OneCell(l: "Drink a coffe", d: 3)]
        inSection += [OneCell(l: "Have a nap", d: 1)]
        content += [inSection]
        
        inSection = [OneCell]()
        inSection += [OneCell(l: "Scream on an old woman", d: 0)]
        inSection += [OneCell(l: "Help a blind guy cross the street", d: 1)]
        content += [inSection]
        
        inSection = [OneCell]()
        inSection += [OneCell(l: "Burn something", d: 3)]
        inSection += [OneCell(l: "Kidnap a baby", d: 2)]
        content += [inSection]
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.title = "MyElements"
        // Buttons for update... could be done in viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCell))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    @objc func addCell() {
        self.content[0].insert(OneCell(l: "New task", d: 0), at: 0)
        self.tableView.reloadData()
    }
    // TableViewDataSource protocol
    override func numberOfSections(in tableView: UITableView) -> Int {
        return content.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "reusedCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        let cont = content[indexPath.section][indexPath.row]
        var img : UIImage?
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        switch cont.detail {
        case 0:
            img = UIImage(named: "prio-0")
        case 1:
            img = UIImage(named: "prio-1")
        case 2:
            img = UIImage(named: "prio-2")
        case 3:
            img = UIImage(named: "prio-3")
        case 4:
            img = UIImage(named: "prio-4")
        default :
            print("Can not find priority")
        }
        cell!.imageView?.image = img!
        cell!.textLabel?.text = cont.label
        cell!.detailTextLabel?.text = "Priority " + String(cont.detail)
        cell!.backgroundView = UIImageView(image: UIImage(named: "bg-tableview-cell"))
        return cell!
    }
    
    //override to support editing the table view
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.content[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            //can do it here, but we will do it in another place
        }
        self.tableView.reloadData() //because several types of cells
    }
    //override to support rearranging of the table view
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let val = content[sourceIndexPath.section][sourceIndexPath.row]
        self.content[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        self.content[destinationIndexPath.section].insert(val, at: destinationIndexPath.row)
        self.tableView.reloadData() //because several types of cells
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //create the view controller to insert
        let s = self.content[indexPath.section][indexPath.row]
        let detailVC = DetailViewController(oneCell: s)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    //UITableViewDelegate protocol
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 30.0))
        let imgView = UIImageView(image: UIImage(named: "bg-header"))
        imgView.frame = hv.frame
        hv.addSubview(imgView) //for background
        let l = UILabel(frame: CGRect(x: 20.0, y: 5.0, width: UIScreen.main.bounds.size.width - 30, height: 20.0))
        l.font = UIFont.boldSystemFont(ofSize: 20.0)
        switch section {
        case 0:
            l.text = "Personal"
        case 1:
            l.text = "Professional"
        case 2:
            l.text = "Urgent"
        case 3:
            l.text = "Today"
        case 4:
            l.text = "Fetish"
        default:
            l.text = "Section error"
        }
        hv.addSubview(l)
        return hv
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let fv = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 5.0))
        let imgView = UIImageView(image: UIImage(named: "fond-alu"))
        imgView.frame = fv.frame
        fv.addSubview(imgView) //for background
        return fv
    }
    
}

