//
//  MyTasksTVC.swift
//  TodoList
//
//  Created by Anton Skomarovskyi on 10/6/19.
//  Copyright © 2019 Anton Skomarovskyi. All rights reserved.
//

import UIKit

class MyTasksTVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    var apiClient : APIClient?
    var tasks: [TaskModel] = []
    
    private let notification = UISelectionFeedbackGenerator()
    
    @IBOutlet weak var MyTasksTV: UITableView!
    @IBOutlet weak var AddTaskButtonProperties: UIButton!
    
    @IBAction func AddTaskButton(_ sender: Any) {
        performSegue(withIdentifier: "GoToDetails", sender: self)
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
        
        cell.detailTextLabel?.text = "Due to \(strDate) \t \(tasks[indexPath.item].priority)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        performSegue(withIdentifier: "GoToDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TaskDetailsVC
        destinationVC.apiCLient = apiClient!
        destinationVC.mainVC = self
    }
    
    @objc func handleRefreshControl() {
        updateUI()
        
        DispatchQueue.main.async {
            self.MyTasksTV.refreshControl?.endRefreshing()
            self.notification.selectionChanged()
        }
    }
    
    private func updateUI() -> Void {
        apiClient!.getTasks{ tasks, error in
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
}
