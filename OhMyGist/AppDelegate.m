//
//  AppDelegate.m
//  OhMyGist
//
//  Created by wangzz on 15/1/14.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "AppDelegate.h"
#import "OctoKit.h"
#import "RESideMenu.h"
#import "FGLeftMenuViewController.h"
#import "FGAllGistsViewController.h"
#import "NSUserDefaults+SecureAdditions.h"
#import "FGAccountManager.h"
#import "FGLoginViewController.h"
#import "FGNavigationController.h"


@interface AppDelegate () <RESideMenuDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[NSUserDefaults standardUserDefaults] setSecret:@"com.wangzz.ohmygist"];
    [OCTClient setClientID:@"7dad4336cf76fac2e8b3" clientSecret:@"3ea591db02ea0ee3cc6b1008af60385146ca31be"];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    FGNavigationController *navigationController = [[FGNavigationController alloc] initWithRootViewController:[[FGAllGistsViewController alloc] init]];
    FGLeftMenuViewController *leftMenuViewController = [[FGLeftMenuViewController alloc] init];

    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController:leftMenuViewController
                                                                   rightMenuViewController:nil];
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"StarsSky"];
    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    
    self.window.rootViewController = sideMenuViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    if (![FGAccountManager defaultManager].isAuthenticated) {
        FGLoginViewController *loginController = [[FGLoginViewController alloc] init];
        [navigationController presentViewController:loginController animated:NO completion:^{
            
        }];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
