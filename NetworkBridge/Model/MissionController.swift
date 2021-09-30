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
            .observeAdvertise(withObjectType: LiveData.objectType)
                    .subscribe(onNext: { livedata in
                        postLiveData(data: (livedata.data.object as! LiveData).jsonDetails)
                    }).disposed(by: self.disposeBag)
        

        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let event = try! AdvertiseEvent.with(object: requestTasks())
            
            try? self.communicationManager.publishAdvertise(event)
        }
     }
    
    func publishMissionTimeout(retry: Bool = true){
        
    }
    
    func postNewMission(){
        
    }
    
    func observeResultDataEvent(){
        
    }
}
