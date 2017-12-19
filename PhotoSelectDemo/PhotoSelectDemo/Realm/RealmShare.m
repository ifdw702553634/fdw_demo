//
//  RealmShare.m
//  PhotoSelectDemo
//
//  Created by mude on 2017/12/19.
//  Copyright © 2017年 DreamTouch. All rights reserved.
//

#import "RealmShare.h"
#import <Realm/Realm.h>
#import <Realm/RLMRealm_Private.h>
#import <Realm/RLMSchema_Private.h>
#import <Realm/RLMRealmConfiguration_Private.h>
#import "RealmTestViewController.h"
#import "RealmTestObj.h"

static RealmShare *instance;

@implementation RealmShare

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance creatDataBaseWithName:@"TestDB"];
    });
    return instance;
}
    
- (void)creatDataBaseWithName:(NSString *)databaseName
{
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [docPath objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:databaseName];
    NSLog(@"数据库目录 = %@",filePath);
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [NSURL URLWithString:filePath];
    config.readOnly = NO;
    int currentVersion = 1.0;
    config.schemaVersion = currentVersion;
    config.migrationBlock = ^(RLMMigration *migration , uint64_t oldSchemaVersion) {       // 这里是设置数据迁移的block
        if (oldSchemaVersion < currentVersion) {
        }
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
}
    
- (NSURL *)getRLMDefaultRealmURL{
    return [NSURL fileURLWithPath:RLMRealmPathForFileAndBundleIdentifier(@"TestDB.realm", [NSProcessInfo processInfo].environment[@"RLMParentProcessBundleID"])];
}

@end
