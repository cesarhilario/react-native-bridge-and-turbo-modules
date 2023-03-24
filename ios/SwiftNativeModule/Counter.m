//
//  Counter.m
//  bridgereactnativeexample
//
//  Created by Cesar Hilario on 23/03/23.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"

/*
 RENAMING -> RCT_EXTERN_REMAP_MODULE(NameExposedToJS. SwiftClass, Superclass)
 @interface RCT_EXTERN_REMAP_MODULE(RNCounter, Counter, NSObject)
 @end
*/

@interface RCT_EXTERN_MODULE(Counter, NSObject)
  // RENAMING Method _RCT_EXTERN_REMAP_METHOD(inc, increment, false)
  // the 3rd Bool argument of _RCT_EXTERN_REMAP_METHOD specifies if the method is synchronous or not. If you make it sync, by setting the flag to true, it will throw an error in DEBUG mode. Keep in mind that it’s NOT a good practice to write sync methods.
  RCT_EXTERN_METHOD(increment)
  RCT_EXTERN_METHOD(getCount: (RCTResponseSenderBlock)callback)
  RCT_EXTERN_METHOD(callbackMethodWithArguments: (RCTResponseSenderBlock)callback)
  RCT_EXTERN_METHOD(
    decrement: (RCTPromiseResolveBlock)resolve
    rejecter: (RCTPromiseRejectBlock)reject
  )
@end
