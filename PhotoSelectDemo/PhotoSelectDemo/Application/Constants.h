//
//  Constants.h
//  PhotoSelectDemo
//
//  Created by mude on 17/1/10.
//  Copyright © 2017年 DreamTouch. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

//color
#define Rgb2UIColor(r, g, b, a)        [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:((a)/1.0)]
#define THEME_COLOR [[DTMutableScene shareManager] colorWithHexString:[[NSUserDefaults standardUserDefaults] objectForKey:@"backgroundColor"]]

#define SUP_COLOR_ORANGE Rgb2UIColor(251, 165, 74, 1)//辅色 橙
#define SUP_COLOR_RED Rgb2UIColor(236, 73, 73, 1)//辅色 红
#define SUP_COLOR_BLUE Rgb2UIColor(87, 178, 244, 1)//辅色 蓝
#define SUP_COLOR_GREEN Rgb2UIColor(7, 191, 141, 1)//辅色 绿
#define BG_COLOR Rgb2UIColor(248, 248, 248, 1)
#define DARK_TEXT_COLOR Rgb2UIColor(51, 51, 51, 1)// 333
#define SIGNLE_TEXT_COLOR Rgb2UIColor(102, 102, 102, 1)//666
#define LIGHT_TEXT_COLOR Rgb2UIColor(153, 153, 153, 1)//placeholder 999999
#define LINE_COLOR Rgb2UIColor(229, 229, 229, 1)

//size
#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define SCREEN_WIDTH  ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define TABLEVIEW_RECT CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)
#define TABLEVIEW_RECT_WITHOUTNAV CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT+20)
//APP INFO
#define APP_DISPLAYNAME     [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define ALERT_TITLE APP_DISPLAYNAME
#define VERSION             [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define SystemVersion [[UIDevice currentDevice] systemVersion]
#define SystemBuild [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#ifdef DEBUG
#define DBG(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define DBG(format, ...)
#endif


#define IS_NULL_STRING(__POINTER) \
(__POINTER == nil || \
__POINTER == (NSString *)[NSNull null] || \
![__POINTER isKindOfClass:[NSString class]] || \
![__POINTER length])

// 多场景
#define LocalizedString(key, comment) \
[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:@"CustomLocalizable"]

// 多语言
#define LANGUAGE_STATE_NOTIFICATION   @"LANGUAGE_STATE_NOTIFICATION"
#define LANGUAGE_STATE                @"LANGUAGE_STATE"

#define AppLanguage @"appLanguage"
#define CustomLocalizedString(key, comment) \
[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:@"CustomLocalizable"]

#endif /* Constants_h */
