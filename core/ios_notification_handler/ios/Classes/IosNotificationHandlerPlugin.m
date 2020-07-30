#import "IosNotificationHandlerPlugin.h"
#if __has_include(<ios_notification_handler/ios_notification_handler-Swift.h>)
#import <ios_notification_handler/ios_notification_handler-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ios_notification_handler-Swift.h"
#endif

@implementation IosNotificationHandlerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftIosNotificationHandlerPlugin registerWithRegistrar:registrar];
}
@end
