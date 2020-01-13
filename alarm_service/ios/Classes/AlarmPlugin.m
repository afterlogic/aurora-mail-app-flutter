#import "AlarmPlugin.h"
#import <alarm_service/alarm_service-Swift.h>

@implementation AlarmPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAlarmPlugin registerWithRegistrar:registrar];
}
@end
