//
//  TaskDetailsVC.swift
//  TodoList
//
//  Created by Anton Skomarovskyi on 10/6/19.
//  Copyright © 2019 Anton Skomarovskyi. All rights reserved.
//

import UIKit

class AddTaskVC: UIViewController {
    var apiCLient : APIClient?
    
    weak var delegate: MyTasksTVCProtocol?
    
    @IBOutlet weak var TitleTV: UITextView!
    @IBOutlet weak var PrioritySC: UISegmentedControl!
    @IBOutlet weak var DescriptionTV: UITextView!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var ChangeBProperties: UIButton!
    @IBOutlet weak var DatePickerProperties: UIDatePicker!
    
    @IBAction func DatePicker(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: DatePickerProperties.date)
        DateLabel.text = strDate
    }
    
    @IBAction func ChangeB(_ sender: Any) {
        var priority : String?
        
        switch PrioritySC.selectedSegmentIndex {
        case 0:
            priority = PriorityEnum.high.rawValue
        case 1:
            priority = PriorityEnum.medium.rawValue
        case 2:
            priority = PriorityEnum.low.rawValue
        default:
            priority = PriorityEnum.low.rawValue
        }
        
        apiCLient!.createTask(
            title: TitleTV.text,
            dueBy: Int(DatePickerProperties.date.timeIntervalSince1970),
            priority: priority!,
            completionHandler: { error in
                if let error = error {
                    self.showErrorPopup(msg : error.message)
                } else {
                    self.delegate?.updateUI(sortOption: SortOptionEnum.byTitle)
                    self.navigationController?.popViewController(animated: true)
                }
            })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    private func updateUI() -> Void {
        TitleTV.layer.borderWidth = 0.5
        TitleTV.layer.cornerRadius = 6
        
        DescriptionTV.layer.borderWidth = 0.5
        DescriptionTV.layer.cornerRadius = 6
    }
    
    private func showErrorPopup(msg : String?) -> Void {
        let alertController = UIAlertController(title: "Error", message:
            msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try again", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

