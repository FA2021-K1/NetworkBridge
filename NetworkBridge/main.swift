//
//  main.swift
//  NetworkBridge
//
//  Created by Egor Spirin on 23.09.2021.
//

import Foundation

print("Hello, World!")

requestTasks()
postLiveData(data: """
             {"id": "2021-09-23T13:38:15.916016", "drone_id": "123", "coordinate": {"latitude": 46.746031703004796, "longitude": 11.35859858499762, "altitude": 100}}
             """, droneId: "123")
