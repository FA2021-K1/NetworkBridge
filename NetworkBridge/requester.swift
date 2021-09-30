//
//  requester.swift
//  NetworkBridge
//
//  Created by Egor Spirin on 23.09.2021.
//

import Foundation

func requestTasks() -> TasksDetails {
    let url = URL(string: "http://127.0.0.1:5000/api/tasks/get_not_completed_tasks")!
    let semaphore = DispatchSemaphore(value: 0)
    var result = ""

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else {
            result = "error"
            return
        }
        let stringData = String(data: data, encoding: .utf8)!
        
        result = stringData
        
        semaphore.signal()
    }

    task.resume()
    semaphore.wait()
    print("Received tasks")
    return TasksDetails(json: result)
}

func postLiveData(data: String) {
    let urlSession = URLSession.shared
    let semaphore = DispatchSemaphore(value: 0)

    var request = URLRequest(
        url: URL(string: "http://127.0.0.1:5000/api/drones/live-info-json")!,
        cachePolicy: .reloadIgnoringLocalCacheData
    )
    
    request.httpMethod = "POST"
    request.httpBody = try? JSONSerialization.data(withJSONObject: ["data": data])

    let task = urlSession.dataTask(
        with: request,
        completionHandler: { data, response, error in
            print("Live data posted")
            semaphore.signal()
        }
    )

    task.resume()
    semaphore.wait()
}
