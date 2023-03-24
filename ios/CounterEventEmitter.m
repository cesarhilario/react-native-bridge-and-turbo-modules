//
//  CounterEventEmitter.m
//  bridgereactnativeexample
//
//  Created by Cesar Hilario on 23/03/23.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_REMAP_MODULE(CounterWithEvents, CounterEventEmitter, RCTEventEmitter)
  RCT_EXTERN_METHOD(increment)
@end
