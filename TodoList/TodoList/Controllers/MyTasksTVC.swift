//
//  MyTasksTVC.swift
//  TodoList
//
//  Created by Anton Skomarovskyi on 10/6/19.
//  Copyright © 2019 Anton Skomarovskyi. All rights reserved.
//

import UIKit

class MyTasksTVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var MyTasksTV: UITableView!
    var items: [String] = ["We", "Heart", "Swift"]
    
    @IBOutlet weak var AddTaskButtonProperties: UIButton!
    @IBAction func AddTaskButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyTasksTV.tableFooterView = .init()
        AddTaskButtonProperties.setImage(#imageLiteral(resourceName: "plus-circle-filled"), for: .normal)
        AddTaskButtonProperties.setImage(#imageLiteral(resourceName: "plus-circle"), for: .selected)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                               reuseIdentifier: "TaskCell")
        cell.accessoryType = .disclosureIndicator
        
        cell.textLabel?.text = "main text"
        cell.detailTextLabel?.text = "some text"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        performSegue(withIdentifier: "GoToDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TaskDetailsVC
    }
}
