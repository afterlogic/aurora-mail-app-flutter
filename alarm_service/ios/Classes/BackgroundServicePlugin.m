#import "BackgroundServicePlugin.h"
#import <background_service/background_service-Swift.h>

@implementation BackgroundServicePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBackgroundServicePlugin registerWithRegistrar:registrar];
}
@end
