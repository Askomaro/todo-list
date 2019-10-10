//
//  EditTaskVC.swift
//  TodoList
//
//  Created by Anton Skomarovskyi on 10/10/19.
//  Copyright © 2019 Anton Skomarovskyi. All rights reserved.
//

import UIKit

class EditTaskVC: UIViewController {
    var apiClient : APIClient?
    var taskModel : TaskModel?
    
    weak var delegate: MyTasksTVCProtocol?
    
    @IBOutlet weak var MainTitleTX: UITextView!
    @IBOutlet weak var PrioritySC: UISegmentedControl!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var DatePickerProperties: UIDatePicker!
    @IBOutlet weak var DescriptionTV: UITextView!
    
    @IBAction func DeleteButton(_ sender: Any) {
        apiClient!.deleteTask(
            task: taskModel!,
            completionHandler: { error in
                if let error = error {
                    self.showErrorPopup(msg : error.message)
                } else {
                    self.delegate?.updateUI(sortOption: SortOptionEnum.byTitle)
                    self.navigationController?.popViewController(animated: true)
                }})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    private func updateUI() -> Void {
        MainTitleTX.text = taskModel!.title
        
        switch taskModel!.priority {
        case PriorityEnum.low.rawValue:
            PrioritySC.selectedSegmentIndex = 2
        case PriorityEnum.medium.rawValue:
            PrioritySC.selectedSegmentIndex = 1
        case PriorityEnum.high.rawValue:
            PrioritySC.selectedSegmentIndex = 0
        default:
            PrioritySC.selectedSegmentIndex = 2
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let date = Date(timeIntervalSince1970: Double(taskModel!.dueBy))
        let strDate = dateFormatter.string(from: date)
        
        DateLabel.text = strDate
        DatePickerProperties.date = date
    }
    
    private func showErrorPopup(msg : String?) -> Void {
        let alertController = UIAlertController(title: "Error", message:
            msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try again", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
