//
//  DTLogFormatter.h
//  PhotoSelectDemo
//
//  Created by mude on 2017/12/25.
//  Copyright © 2017年 DreamTouch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTLogFormatter : NSObject<DDLogFormatter>

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage;

@end
