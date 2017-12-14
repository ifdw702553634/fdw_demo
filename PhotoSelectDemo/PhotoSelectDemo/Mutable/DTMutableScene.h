//
//  DTMutableScene.h
//  PhotoSelectDemo
//
//  Created by mude on 17/1/10.
//  Copyright © 2017年 DreamTouch. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DTMutableSceneDelegate <NSObject>

-(void)updateLanguage;

@end

@interface DTMutableScene : NSObject
@property (nonatomic, weak) id<DTMutableSceneDelegate> delegate;

+ (DTMutableScene *)shareManager;

- (void)setDelegate:(id<DTMutableSceneDelegate>)delegate;

//初始化
- (void)initialize;

/**
 设置背景色
 */
- (void)setBackgroundColorWithColor:(NSString *)color;

- (UIColor *) colorWithHexString: (NSString *) stringToConvert;

@end
