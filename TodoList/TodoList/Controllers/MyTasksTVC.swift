//
//  MyTasksTVC.swift
//  TodoList
//
//  Created by Anton Skomarovskyi on 10/6/19.
//  Copyright © 2019 Anton Skomarovskyi. All rights reserved.
//

import UIKit

class MyTasksTVC : UIViewController, UITableViewDelegate, UITableViewDataSource, MyTasksTVCProtocol {
    
    var apiClient : APIClient?
    var tasks: [TaskModel] = []
    
    private let notification = UISelectionFeedbackGenerator()
    
    @IBOutlet weak var MyTasksTV: UITableView!
    @IBOutlet weak var AddTaskButtonProperties: UIButton!
    
    @IBAction func FilterBProperties(_ sender: Any) {
        showPopupFilter()
    }
    
    @IBAction func AddTaskButton(_ sender: Any) {
        performSegue(withIdentifier: "GoToAddTask", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyTasksTV.tableFooterView = .init()
        AddTaskButtonProperties.setImage(#imageLiteral(resourceName: "plus-circle-filled"), for: .normal)
        AddTaskButtonProperties.setImage(#imageLiteral(resourceName: "plus-circle"), for: .selected)
        
        configureRefreshControl()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                               reuseIdentifier: "TaskCell")
        cell.accessoryType = .disclosureIndicator
        
        cell.textLabel?.text = tasks[indexPath.item].title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: Date(timeIntervalSince1970: Double(tasks[indexPath.item].dueBy)))
        
        var priority = ""
        switch tasks[indexPath.item].priority {
        case PriorityEnum.high.rawValue:
            priority = "↑ High"
        case PriorityEnum.medium.rawValue:
            priority = "Medium"
        case PriorityEnum.low.rawValue:
            priority = "↓ Low"
        default:
            priority = ""
        }
        
        cell.detailTextLabel?.text = "Due to \(strDate) \t \(priority)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToEditTask", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToAddTask"
        {
            let destinationVC = segue.destination as! AddTaskVC
            destinationVC.apiCLient = apiClient!
            destinationVC.delegate = self
        }
        
        if segue.identifier == "GoToEditTask"
        {
            let destinationVC = segue.destination as! EditTaskVC
            destinationVC.apiClient = apiClient!
            let selectedtTaskModel = tasks[MyTasksTV.indexPathForSelectedRow!.row]
            destinationVC.taskModel = selectedtTaskModel
            destinationVC.delegate = self
        }
    }
    
    @objc func handleRefreshControl() {
        updateUI()
        
        DispatchQueue.main.async {
            self.MyTasksTV.refreshControl?.endRefreshing()
            self.notification.selectionChanged()
        }
    }
    
    func updateUI(sortOption : SortOptionEnum = SortOptionEnum.byTitle) -> Void {
        apiClient!.getTasks(page: 0, sortOption : sortOption.rawValue)
        { tasks, error in
            if let error = error {
                self.showErrorPopup(msg : error.message)
            } else {
                self.tasks = tasks
                self.MyTasksTV.reloadData()
            }
        }
    }
    
    private func showErrorPopup(msg : String?) -> Void {
        let alertController = UIAlertController(title: "Error", message:
            msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try again", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func configureRefreshControl () {
        MyTasksTV.refreshControl = UIRefreshControl()
        MyTasksTV.refreshControl?.tintColor = .white
        MyTasksTV.refreshControl?.addTarget(self, action:#selector(handleRefreshControl), for: .valueChanged)
    }
    
    private func showPopupFilter() -> Void {
        let alert = UIAlertController(title: "Filter", message: "Choose filtration for tasks displaying", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "By title", style: .default, handler: { action in
            self.updateUI(sortOption: SortOptionEnum.byTitle)
        }))
        alert.addAction(UIAlertAction(title: "By priority", style: .default, handler: { action in
            self.updateUI(sortOption: SortOptionEnum.byPriority)
        }))
        alert.addAction(UIAlertAction(title: "By date", style: .default, handler: { action in
            self.updateUI(sortOption: SortOptionEnum.byDate)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    @objc private func handleFilterActionTitle() {

    }
}
