//
//  RealmTestObj.h
//  PhotoSelectDemo
//
//  Created by mude on 2017/12/19.
//  Copyright © 2017年 DreamTouch. All rights reserved.
//

#import <Realm/Realm.h>

@interface RealmTestObj : RLMObject

@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *title;
    
@end
