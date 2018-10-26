//
//  ViewController.swift
//  DispatchGroup
//
//  Created by Jinu Kim on 26/10/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let group = DispatchGroup()
    let queue1 = DispatchQueue(label: "task1")
    let queue2 = DispatchQueue(label: "task2")
    let queue3 = DispatchQueue(label: "task3")
    let queue4 = DispatchQueue(label: "task4")
    let queue5 = DispatchQueue(label: "task5")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        group.wait()
        let task = DispatchWorkItem(flags: .assignCurrentContext) {
            print("Hello from background!")
        }
        DispatchQueue.global(qos: .background).async(execute: task)
        
        
        
        task.wait()
        queue1.async(group: group) {
            print("task 1-1")
        }
        
        queue2.async(group: group) {
            print("task 1-2")
        }
        
        queue3.async(group: group) {
            print("task 1-3")
        }
        
        group.notify(queue: DispatchQueue.main){
            print("Group notify")
        }
        
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            print("task in Userinitiated")
        }
//        DispatchQoS.userInteractive: 유저 사용성을 위해 즉시 수행되는 타입 => UI 갱신, 사용자 이벤트 처리, 애니메이션
//        DispatchQoS.userInitiated: 비동기 UI queue에서 수행되지만, 시스템의 다른 작업들보다 우선순위가 높게 수행된다 => 일단 시작되면 끝나기 전에 다른 작업이 중간에 다시 시작될일은 거의 없다. 빠르게 수행될 수 있고, UI 상호 작용을 해야 하는 경우에 사용한다. HIGH
//        DispatchQoS.default: 시스템에서 제공하는 Qos class 타입을 따르기 위해 사용하는 것으로 다른 qos와 구분을 위해 정의된 것은 아니다. DEFUALT
//        DispatchQoS.utility: 지속적인 작업이 필요할때 사용할 타입이다. 시스템에서 비교적 높은 레벨로 수행된다. => 에너지 효율적(???)으로 "동작한다고 한다" LOW
//        DispatchQoS.background: 시간에 민감하지 않은 작업들을 수행할때 사용된다. => 언제 수행될지는 GCD가 컨트롤 한다. BACKGROUND
        
        let queue11 = DispatchQueue(label: "task11")
        let queue12 = DispatchQueue(label: "task12")
        let item2 = DispatchWorkItem(flags: .assignCurrentContext) {
            dispatchPrecondition(condition: .onQueue(queue11))
            print("work Item")
        }
        queue11.async(execute: item2)
//        queue12.async(execute: item2)
        
    }


}

class MyObject {
    private var internalState: Int
    private let internalQueue: DispatchQueue = DispatchQueue(label: "Task")
    var state: Int {
        get {
            return internalQueue.sync { internalState }
        }
        set (newState) {
            internalQueue.sync { internalState = newState }
        }
    }
    
    init() {
        internalState = 0
    }
}
