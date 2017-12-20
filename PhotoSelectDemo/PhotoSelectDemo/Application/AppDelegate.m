//
//  AppDelegate.m
//  PhotoSelectDemo
//
//  Created by mude on 16/11/21.
//  Copyright © 2016年 DreamTouch. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SelectPhotoViewController.h"
#import "DTMutableLanguage.h"
#import "DTMutableScene.h"
//#import <DTDoorbellControl/DTBellMethod.h>

#define iflyAppId @"587593cd"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [super application:application didFinishLaunchingWithOptions:launchOptions];
    
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:[[FirstViewController alloc]init]];
    self.window.rootViewController=navc;
    [self.window makeKeyAndVisible];
    
    [[DTMutableLanguage shareInstance] initialize];
    [[DTMutableScene shareManager] initialize];
    
    //开启使用 XcodeColors
    setenv("XcodeColors", "YES", 0);
    //检测
    char *xcode_colors = getenv("XcodeColors");
    if (xcode_colors && (strcmp(xcode_colors, "YES") == 0))
    {
        // XcodeColors is installed and enabled!
        NSLog(@"XcodeColors is installed and enabled");
    }
    //开启DDLog 颜色
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:DDLogFlagVerbose];
    
    //配置DDLog
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    
    
    
    //导航栏通用设置
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:THEME_COLOR] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc]init] ];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //设置自定义返回按钮图片
    [self setNaviBack];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor],NSForegroundColorAttributeName,
                                                          [UIFont boldSystemFontOfSize:18],
                                                          NSFontAttributeName
                                                          ,nil]];
    
    [self registerIflyMSC];

    // Override point for customization after application launch.
    return YES;
}

/**
 *  设置自定义返回按钮图片
 */
- (void)setNaviBack{
    UINavigationBar * navigationBar = [UINavigationBar appearance];
    //设置返回样式图片
    UIImage *image = [UIImage imageNamed:@"arrow_white_left"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationBar.backIndicatorImage = image;
    navigationBar.backIndicatorTransitionMaskImage = image;
    UIOffset offset;
    
    //添加iOS11适配
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
        //
    }else{
        offset.horizontal = -500;
        offset.vertical = -500;
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
    }
}

-(void)registerIflyMSC{
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",iflyAppId];
    [IFlySpeechUtility createUtility:initString];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    if ([url.absoluteString hasPrefix:@"todaywidget"]) {
        if ([url.absoluteString hasSuffix:@"home"]) {//判断是否是直接跳入到添加页面
            FirstViewController *vc = [[FirstViewController alloc] init];
            UINavigationController *rootNav = (UINavigationController*)self.window.rootViewController;
            [rootNav pushViewController:vc animated:YES];
        }else if ([url.absoluteString hasSuffix:@"select"]){
            SelectPhotoViewController *vc = [[SelectPhotoViewController alloc] init];
            UINavigationController *rootNav = (UINavigationController*)self.window.rootViewController;
            [rootNav pushViewController:vc animated:YES];
        }
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
