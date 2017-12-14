//
//  SemanticUnderstandingViewController.h
//  PhotoSelectDemo
//
//  Created by mude on 17/1/12.
//  Copyright © 2017年 DreamTouch. All rights reserved.
//

#import <UIKit/UIKit.h>
//forward declare
@class PopupView;
@class IFlyDataUploader;
@class IFlySpeechUnderstander;

/**
 语音理解demo
 使用该功能仅仅需要三步
 *
 1.创建语义理解对象；
 2.有选择的实现识别回调；
 3.启动语义理解
 ****/
@interface SemanticUnderstandingViewController : UIViewController<IFlySpeechRecognizerDelegate>


//语音语义理解对象
@property (nonatomic,strong) IFlySpeechUnderstander *iFlySpeechUnderstander;
//文本语义理解对象
@property (nonatomic,strong) IFlyTextUnderstander *iFlyUnderStand;

@property (nonatomic,weak)   UITextView *resultView;
@property (nonatomic,strong) PopupView  *popUpView;
@property (nonatomic, copy)  NSString * defaultText;

@property (nonatomic) BOOL isCanceled;
@property (nonatomic,strong) NSString *result;

@property (nonatomic) BOOL isSpeechUnderstander;//当前状态是否是语音语义理解
@property (nonatomic) BOOL isTextUnderstander;//当前状态是否是文本语义理解

@end
