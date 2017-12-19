//
//  RealmShare.h
//  PhotoSelectDemo
//
//  Created by mude on 2017/12/19.
//  Copyright © 2017年 DreamTouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RealmShare : NSObject
+ (instancetype)shareManager;

- (NSURL *)getRLMDefaultRealmURL;
@end
