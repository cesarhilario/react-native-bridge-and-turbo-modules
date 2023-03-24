//
//  CounterEventEmiiter.swift
//  bridgereactnativeexample
//
//  Created by Cesar Hilario on 23/03/23.
//

import Foundation

@objc(CounterEventEmitter)
class CounterEventEmitter: RCTEventEmitter {
  private var count = 0;
  
  @objc
  func increment() {
    count += 1;
    print("Count is \(count)");
    
    sendEvent(withName: "onIncrement", body: ["count": count])
  }
  
  override func supportedEvents() -> [String]! {
    return ["onIncrement"]
  }
  
  override func constantsToExport() -> [AnyHashable : Any]! {
    return ["initialCount": count]
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
