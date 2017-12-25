//
//  DTLogger.h
//  PhotoSelectDemo
//
//  Created by mude on 2017/12/25.
//  Copyright © 2017年 DreamTouch. All rights reserved.
//

#import "DDAbstractDatabaseLogger.h"

@interface DTLogger : DDAbstractDatabaseLogger

@property(nonatomic,strong) NSMutableArray *logMessagesArray;

- (instancetype)init;

@end
