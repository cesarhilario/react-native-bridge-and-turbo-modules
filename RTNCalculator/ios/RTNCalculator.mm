#import "RTNCalculatorSpec.h"
#import "RTNCalculator.h"

@implementation RTNCalculator

RCT_EXPORT_MODULE(RTNCalculator) // <--- This is MACRO

RCT_REMAP_BLOCKING_SYNCHRONOUS_METHOD(add, NSNumber*, addA:(NSInteger)a
                      andB:(NSInteger)b)
{
    NSNumber *result = [[NSNumber alloc] initWithInteger:a+b];
    return result;
}
// shared_ptr return an instance from the type facebook::react::TurboModule
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeCalculatorSpecJSI>(params);
}

@end