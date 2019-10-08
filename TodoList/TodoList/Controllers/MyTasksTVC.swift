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
    
    @IBOutlet weak var AddTaskButtonProperties: UIButton!
    @IBAction func AddTaskButton(_ sender: Any) {
        AddTaskButtonProperties.setImage(#imageLiteral(resourceName: "plus-circle-filled"), for: [.selected, .highlighted])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        cell.textLabel?.text = "Row \(indexPath.row)"
        
        return cell
    }
}
