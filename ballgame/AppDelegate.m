//
//  AppDelegate.m
//  ballgame
//
//  Created by Nathaniel Symer on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    application.idleTimerDisabled = YES;
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    NSString *savedScore = [[NSUserDefaults standardUserDefaults]objectForKey:@"savedScore"];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"savedScore"];
    BOOL gameOver = [[NSUserDefaults standardUserDefaults]boolForKey:@"gameOver"];
    
    if (!gameOver) {
        [_viewController.score setText:savedScore];
        [_viewController setStartButtonTitle:@"Resume"];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    if ([UIAccelerometer sharedAccelerometer].delegate != nil) {
        [_viewController togglePause:nil];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSString *savedScore = _viewController.score.text;
    [[NSUserDefaults standardUserDefaults]setObject:savedScore forKey:@"savedScore"];
}

@end