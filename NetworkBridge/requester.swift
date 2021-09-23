//
//  requester.swift
//  NetworkBridge
//
//  Created by Egor Spirin on 23.09.2021.
//

import Foundation

func requestTasks() -> String {
    let url = URL(string: "http://127.0.0.1:5000/api/tasks/get_not_completed_tasks")!
    let semaphore = DispatchSemaphore(value: 0)
    var result = ""

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else {
            result = "error"
            return
        }
        let stringData = String(data: data, encoding: .utf8)!
        print(stringData)
        
        result = stringData
        
        semaphore.signal()
    }

    task.resume()
    semaphore.wait()
    return result
}

func postLiveData(data: String, droneId: String) {
    let urlSession = URLSession.shared
    let semaphore = DispatchSemaphore(value: 0)

    var request = URLRequest(
        url: URL(string: "http://127.0.0.1:5000/api/drones/\(droneId)/live-info")!,
        cachePolicy: .reloadIgnoringLocalCacheData
    )
    
    request.httpMethod = "POST"
    request.httpBody = try? JSONSerialization.data(withJSONObject: ["data": data])

    let task = urlSession.dataTask(
        with: request,
        completionHandler: { data, response, error in
            print("completed")
            semaphore.signal()
        }
    )

    task.resume()
    semaphore.wait()
}
