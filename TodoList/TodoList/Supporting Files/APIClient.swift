//
//  APIRetriever.swift
//  TodoList
//
//  Created by Anton Skomarovskyi on 10/6/19.
//  Copyright © 2019 Anton Skomarovskyi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIClient {
    private let testApiUrl : String = "https://testapi.doitserver.in.ua/api"
    private var token : String = ""
        
    func authorizeUser(email : String, password : String, completionHandler: @escaping (ErrorModel?) -> Void) -> Void {        
        let parameters = [
            "email": email,
            "password": password
        ]
        
        request("\(testApiUrl)/auth", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: ["Content-Type" : "application/json"])
            .responseJSON{ response in
                switch response.result {
                case .success:
                    let error = self.validate(response: response)
                    let json_resp = self.mapToJson(data: response.data!)
                    self.token = json_resp?["token"].string ?? ""
                    
                    completionHandler(error)
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func createUser(email : String, password : String, completionHandler: @escaping (ErrorModel?) -> Void) -> Void {
        let parameters = [
            "email": email,
            "password": password
        ]
        
        request("\(testApiUrl)/users", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: ["Content-Type" : "application/json"])
            .responseJSON{ response in
                switch response.result {
                case .success:
                    let error = self.validate(response: response)
                    let json_resp = self.mapToJson(data: response.data!)
                    self.token = json_resp?["token"].string ?? ""
                    
                    completionHandler(error)
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func getTasks(page : Int = 0, sortOption : String = "title asc", completionHandler: @escaping ([TaskModel], ErrorModel?) -> Void) -> Void {
        var tasks : [TaskModel] = []
        
        request("\(testApiUrl)/tasks",
                method: .get,
                parameters: ["sort" : sortOption, "page" : page],
                headers: [
                    "Content-Type" : "application/json",
                    "Authorization" : "Bearer \(self.token)"
            ])
            .responseJSON{ response in
                switch response.result {
                    case .success:
                        let error = self.validate(response: response)
                        tasks = self.mapToTaskModels(data: response.data!)
                        completionHandler(tasks, error)
                    
                    case .failure(let error):
                        print(error)
                    }
            }
    }
    
    func createTask(title : String, dueBy : Int, priority : String, completionHandler: @escaping (ErrorModel?) -> Void) -> Void {
        
        request("\(testApiUrl)/tasks",
            method: .post,
            parameters: ["title" : title, "dueBy" : dueBy, "priority" : priority],
            encoding: JSONEncoding.default,
            headers: [
                "Content-Type" : "application/json",
                "Authorization" : "Bearer \(self.token)"
            ])
            .debugLog()
            .responseJSON{ response in
                print(response.response)
                switch response.result {
                case .success:
                    let error = self.validate(response: response)
                    completionHandler(error)
                    
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func getTask(task : TaskModel, completionHandler: @escaping (TaskModel, ErrorModel?) -> Void) -> Void {
        request("\(testApiUrl)/tasks/\(task.id)",
            method: .get,
            headers: [
                "Content-Type" : "application/json",
                "Authorization" : "Bearer \(self.token)"
            ])
            .responseJSON{ response in
                switch response.result {
                case .success:
                    let error = self.validate(response: response)
                    let task = self.mapToTaskModel(data: response.data!)
                    completionHandler(task, error)
                    
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func updateTask(task : TaskModel, completionHandler: @escaping (ErrorModel?) -> Void) -> Void {

        request("\(testApiUrl)/tasks/\(task.id)",
            method: .put,
            parameters: ["title" : task.title, "dueBy" : task.dueBy, "priority" : task.priority],
            headers: [
                "Content-Type" : "application/json",
                "Authorization" : "Bearer \(self.token)"
            ])
            .responseJSON{ response in
                switch response.result {
                case .success:
                    let error = self.validate(response: response)
                    completionHandler(error)
                    
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func deleteTask(task : TaskModel, completionHandler: @escaping (ErrorModel?) -> Void) -> Void {
        
        request("\(testApiUrl)/tasks/\(task.id)",
            method: .delete,
            headers: [
                "Content-Type" : "application/json",
                "Authorization" : "Bearer \(self.token)"
            ])
            .responseJSON{ response in
                switch response.result {
                case .success:
                    let error = self.validate(response: response)
                    completionHandler(error)
                    
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    private func validate(response : DataResponse<Any>) -> ErrorModel? {
        var error : ErrorModel? = nil
        
        if(200..<300 ~= response.response!.statusCode){
        } else {
            error = ErrorModel(statusCode: response.response!.statusCode, message: JSON(response.data!)["message"].string)
        }
        
        return error
    }
    
    private func mapToJson(data : Data) -> JSON? {
        var json : JSON? = nil
        do{
            json = try JSON(data: data)
        }
        catch{
            print("JSON Error")
        }

        return json
    }
    
    private func mapToTaskModels(data : Data) -> [TaskModel] {
        var tasks : [TaskModel] = []
        let json_resp = self.mapToJson(data: data)!
        
        for (_, task) in json_resp["tasks"]{
            tasks.append(TaskModel(json_resp: task))
        }
        
        return tasks
    }
    
    private func mapToTaskModel(data : Data) -> TaskModel {
        let json_resp = self.mapToJson(data: data)!
        let task = TaskModel(json_resp:json_resp["task"])
        
        return task
    }
}

