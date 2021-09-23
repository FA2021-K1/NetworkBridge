//
//  MissionController.swift
//  iDroneControl
//
//  Created by FA21 on 22.09.21.
//

import CoatySwift
import Foundation
import RxSwift

/// A Coaty controller that invokes remote operations to control lights.
class MissionController: Controller {
    
    override func onInit() {

    }
    
    override func onCommunicationManagerStarting() {
         super.onCommunicationManagerStarting()
         
        try? communicationManager
                    .observeAdvertise(withObjectType: "idrone.sync.task")
                    .compactMap { advertiseEvent in
                        advertiseEvent.data.object as? TasksDetails
                    }
                    .subscribe(onNext: { task in
                        let tasks = requestTasks()
                        
                        // Send the updated task offer out and wait for the first response from a Service.
                       try? self.communicationManager.publishUpdate(UpdateEvent.with(object: tasks))
                           .take(1)
                           .compactMap { completeEvent in
                               print("hey")
                           }
                       }
                    ).disposed(by: self.disposeBag)
     }
    
    func publishMissionTimeout(retry: Bool = true){
        
    }
    
    func postNewMission(){
        
    }
    
    func observeResultDataEvent(){
        
    }
}
