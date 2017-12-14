//
//  DTMutableLanguage.m
//  PhotoSelectDemo
//
//  Created by mude on 17/1/10.
//  Copyright © 2017年 DreamTouch. All rights reserved.
//

#import "DTMutableLanguage.h"

@implementation DTMutableLanguage

+ (DTMutableLanguage *)shareInstance{
    
    static DTMutableLanguage *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DTMutableLanguage alloc] init];
    });
    
    return instance;
}

-(void)setDelegate:(id<DTLanguageMutableDelegate>)delegate{
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
    
    //第一次运行
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLanaguagesLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLanaguagesLaunched"];
        //是否曾经设置过语言
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"everSettingLanguages"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"everSettingLanguages"] == NO) {
        //从来未在程序内设置过语言，则获取当前的系统语言
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
        NSString *currentLanguage = [languages objectAtIndex:0];
        NSLog(@"%@",currentLanguage);
        
        if ([currentLanguage hasPrefix:@"zh-Hans"]) { // 简体中文
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:AppLanguage];
        }else if ([currentLanguage hasPrefix:@"zh-Hant"] || [currentLanguage hasPrefix:@"zh-TW"] || [currentLanguage hasPrefix:@"zh-HK"]) { // 繁体中文
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hant" forKey:AppLanguage];
        }else { // 英语
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:AppLanguage];
        }
    }
}

- (void)setChineseSimpleLanguage{
    //设置过语言后，就不再从系统中读取
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everSettingLanguages"];
    [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:AppLanguage];
    [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_STATE_NOTIFICATION object:nil];
}

- (void)setChineseTraditionalLanguage {
    //设置过语言后，就不再从系统中读取
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everSettingLanguages"];
    [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hant" forKey:AppLanguage];
    [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_STATE_NOTIFICATION object:nil];
}

- (void)setEnglishLanguage{
    //设置过语言后，就不再从系统中获取
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everSettingLanguages"];
    [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:AppLanguage];
    [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_STATE_NOTIFICATION object:nil];
}

- (BOOL)isChineseSimpleLanguage{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"everSettingLanguages"] == YES) {
        //已设置过语言
        return [[[NSUserDefaults standardUserDefaults] objectForKey:AppLanguage] isEqualToString:@"zh-Hans"];
    }else{
        //未设置过，从当前的系统语言中读取
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
        NSString *currentLanguage = [languages objectAtIndex:0];
        NSLog(@"currentLanguage:%@",currentLanguage);
        
        return [currentLanguage hasPrefix:@"zh-Hans"];
    }
    
    return YES;
}

- (BOOL)isChineseTraditionalLanguage {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"everSettingLanguages"] == YES) {
        //已设置过语言
        return [[[NSUserDefaults standardUserDefaults] objectForKey:AppLanguage] isEqualToString:@"zh-Hant"];
    }else{
        //未设置过，从当前的系统语言中读取
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
        NSString *currentLanguage = [languages objectAtIndex:0];
        NSLog(@"currentLanguage:%@",currentLanguage);
        
        return ([currentLanguage hasPrefix:@"zh-Hant"] || [currentLanguage hasPrefix:@"zh-TW"] || [currentLanguage hasPrefix:@"zh-HK"]);
    }
    
    return YES;
}

- (BOOL)isEnglishLanguage{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"everSettingLanguages"] == YES) {
        //已设置过语言
        return [[[NSUserDefaults standardUserDefaults] objectForKey:AppLanguage] isEqualToString:@"en"];
    }else{
        //未设置过，从当前的系统语言中读取
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
        NSString *currentLanguage = [languages objectAtIndex:0];
        NSLog(@"currentLanguage:%@",currentLanguage);
        
        return [currentLanguage hasPrefix:@"en"];
    }
    
    return YES;
}

@end
