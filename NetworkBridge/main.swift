//
//  main.swift
//  NetworkBridge
//
//  Created by Egor Spirin on 23.09.2021.
//

import Foundation
import CoatySwift

//requestTasks()
//postLiveData(data: """
//             {"id": "2021-09-23T13:48:15.916016", "drone_id": "123", "coordinate": {"latitude": 46.746031703004796, "longitude": 11.35859858499762, "altitude": 100}}
//             """, droneId: "123")

// Resolve your components with the given configuration and get
// your CoatySwift controllers up and running.
if let configuration = createDroneCoatyConfiguration() {
    let components = Components(controllers: [
        "MissionController": MissionController.self
    ], objectTypes: [
        TasksDetails.self,
        LiveData.self
    ])
    
    let container = Container.resolve(components: components,
                                       configuration: configuration)
    let missionController = (container.getController(name: "MissionController") as! MissionController)
}
RunLoop.main.run()


func createDroneCoatyConfiguration() -> Configuration? {
    return try? .build { config in
        
        // Adjusts the logging level of CoatySwift messages.
        config.common = CommonOptions()
        
        // Adjusts the logging level of CoatySwift messages, which is especially
        // helpful if you want to test or debug applications (default is .error).
        config.common?.logLevel = .info
        
        // Configure `name` of the container's identity here.
        // Do not change the given name, it is used by Coaty JS light
        // controller to track all active light and control agents.
        config.common?.agentIdentity = ["name": "iControl Agent"]
        
        // Here, we define initial values for specific options of
        // the light controller and the light control controller.
        
        
        // Define communication-related options, such as the host address of your broker
        // and the port it exposes. Also, make sure to immediately connect with the broker,
        // indicated by `shouldAutoStart: true`.
        //
        // Note: Keep alive for the broker connection has been reduced to 10secs to minimize
        // connectivity issues when running with a remote public broker.
        let mqttClientOptions = MQTTClientOptions(host: "192.168.1.194",
                                                  port: 1883,
                                                  keepAlive: 10)
        config.communication = CommunicationOptions(namespace: "coaty.examples.remoteops",
                                                    mqttClientOptions: mqttClientOptions,
                                                    shouldAutoStart: true)
    }
}
