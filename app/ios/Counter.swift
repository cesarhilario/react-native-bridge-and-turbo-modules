//
//  Counter.swift
//  bridgereactnativeexample
//
//  Created by Cesar Hilario on 23/03/23.
//

import Foundation

@objc(Counter)
class Counter: NSObject {
  private var count = 0;
  
  // How to expose a Swift method
  @objc
  func increment() {
    count += 1;
    print("count is \(count)")
  }
  
  // How to expose static Swift data
  @objc
  func constantsToExport() -> [AnyHashable: Any]! {
    return [
      
      // Examples
      "number": 123.4,
      "string": "foo bar",
      "boolean": true,
      "array": [1, 22.2, "33", false],
      "object": ["a": 1, "b": 2],
      
      // To Export
      "initialCount": count
    ]
  }
  
  // How to exposed a Swift method with a callback
  @objc
  func getCount(_ callback: RCTResponseSenderBlock) {
    callback([count])
  }
  
  // Passing multiple argumenrs to a callback
  @objc
  func callbackMethodWithArguments(_ callback: RCTResponseSenderBlock) {
      callback([
        count, // Variable
        123.9, // int or float
        "second argument", // string
        [1, 2.2, "3"], // array
        ["a": 1, "b": 2] // object
      ])
  }
  
  // How to exposed a Swift promise
  // For this example:
  // resolves by decrementing this count if its greater than 0
  // rejects when the count is less than  0
  @objc
  func decrement(_ resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
    if(count <= 0) {
      let error = NSError(domain: "", code: 200, userInfo: nil);
      reject("E_COUNT", "count cannot be negative", error);
    } else {
      count -= 1;
      resolve("Count was decremented")
    }
  }
  
  // How to exposed a Swift Event Emitter
  
  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true;
  }
}
