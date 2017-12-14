//
//  DTMutableLanguage.h
//  PhotoSelectDemo
//
//  Created by mude on 17/1/10.
//  Copyright © 2017年 DreamTouch. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DTLanguageMutableDelegate <NSObject>

-(void)updateLanguage;

@end

@interface DTMutableLanguage : NSObject

@property (nonatomic, weak) id<DTLanguageMutableDelegate> delegate;

+ (DTMutableLanguage *)shareInstance;

- (void)setDelegate:(id<DTLanguageMutableDelegate>)delegate;

//初始化
- (void)initialize;

/**
 设置简体中文
 */
- (void)setChineseSimpleLanguage;

/**
 设置繁体中文
 */
- (void)setChineseTraditionalLanguage;

/**
 设置英语
 */
- (void)setEnglishLanguage;

/**
 判断是否是简体中文
 
 @return 是否
 */
- (BOOL)isChineseSimpleLanguage;

/**
 判断是否是繁体中文
 
 @return 是否
 */
- (BOOL)isChineseTraditionalLanguage;

/**
 判断是否是英文
 
 @return 是否
 */
- (BOOL)isEnglishLanguage;


@end
