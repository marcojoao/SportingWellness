#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

// Hide your app’s key window when your app will resign active.
- (void)applicationWillResignActive:(UIApplication *)application {
    self.window.hidden = YES;
}
// Show your app’s key window when your app becomes active again.
- (void)applicationDidBecomeActive:(UIApplication *)application {
    self.window.hidden = NO;
}


@end
