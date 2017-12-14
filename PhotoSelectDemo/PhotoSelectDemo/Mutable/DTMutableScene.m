//
//  DTMutableScene.m
//  PhotoSelectDemo
//
//  Created by mude on 17/1/10.
//  Copyright © 2017年 DreamTouch. All rights reserved.
//

#import "DTMutableScene.h"
#import "AppDelegate.h"

@implementation DTMutableScene

+ (DTMutableScene *)shareManager{
    
    static DTMutableScene *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DTMutableScene alloc] init];
    });
    return instance;
}
-(void)setDelegate:(id<DTMutableSceneDelegate>)delegate{
    _delegate = delegate;
    //接受更改语言时的发出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(languageChanged:)
                                                 name:LANGUAGE_STATE_NOTIFICATION
                                               object:nil];
}

-(void)languageChanged:(id) sender{
    if(_delegate !=nil && [_delegate respondsToSelector:@selector(updateLanguage)]) {
        [_delegate updateLanguage];
    }
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:LANGUAGE_STATE_NOTIFICATION
                                                  object:nil];
    _delegate = nil;
}

//初始化
-(void)initialize{
    
//    第一次运行
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everScenesLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everScenesLaunched"];
        //是否曾经设置过scene
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"everSettingScenes"];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"everSettingScenes"] == NO) {
        [[NSUserDefaults standardUserDefaults] setObject:LocalizedString(@"backgroundColor_0", nil) forKey:@"backgroundColor"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everSettingScenes"];
    }
}

- (void)setBackgroundColorWithColor:(NSString *)colorStr{
    [[NSUserDefaults standardUserDefaults] setObject:LocalizedString(colorStr, nil) forKey:@"backgroundColor"];
}

- (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];//字符串处理
    //例子，stringToConvert #ffffff
    if ([cString length] < 6)
        return [UIColor whiteColor];//如果非十六进制，返回白色
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];//去掉头
    if ([cString length] != 6)//去头非十六进制，返回白色
        return [UIColor whiteColor];
    //分别取RGB的值
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    //NSScanner把扫描出的制定的字符串转换成Int类型
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //转换为UIColor
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}



@end
