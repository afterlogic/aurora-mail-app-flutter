#import "NotificationsUtilsPlugin.h"
#if __has_include(<notifications_utils/notifications_utils-Swift.h>)
#import <notifications_utils/notifications_utils-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "notifications_utils-Swift.h"
#endif

@implementation NotificationsUtilsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNotificationsUtilsPlugin registerWithRegistrar:registrar];
}
@end
