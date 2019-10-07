//
//  MyTasksTVC.swift
//  TodoList
//
//  Created by Anton Skomarovskyi on 10/6/19.
//  Copyright © 2019 Anton Skomarovskyi. All rights reserved.
//

import UIKit

class MyTasksTVC : UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 5
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell") as! ArticleTableViewCell
//
//
////        cell.mainLabelTitle.text = "ds"
////        cell.infoLabel.text = "tmppp"
//////        cell.mainImageView.sd_setImage(with : articlesModel[indexPath.row].imageURL)
////        cell.textView.text = "desc"
//
//        return cell
//    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section \(section)"
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        cell.textLabel?.text = "Row \(indexPath.row)"
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        SVProgressHUD.show()
//
//        performSegue(withIdentifier: "TaskDetails", sender: self)
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationVC = segue.destination as! TaskDetailsVC
////        let selectedArticleModel = articlesModel[tableView.indexPathForSelectedRow!.row]
////
////        destinationVC.articleModel = selectedArticleModel
////
////        articleRetriever.getExtendedArticleModel(url: selectedArticleModel.extendedArticleUrl, completionHandler: {
////            SVProgressHUD.dismiss()
////
////            destinationVC.extendedArticleModel = $0
////
////            destinationVC.updateUI()
////        })
//    }
}
