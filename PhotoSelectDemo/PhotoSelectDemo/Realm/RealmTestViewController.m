//
//  RealmTestViewController.m
//  PhotoSelectDemo
//
//  Created by mude on 2017/12/19.
//  Copyright © 2017年 DreamTouch. All rights reserved.
//

#import "RealmTestViewController.h"
#import <Realm/Realm.h>
#import "RealmTestObj.h"
#import "RealmShare.h"

@interface RealmTestViewController ()<UITableViewDelegate,UITableViewDataSource>{
    RLMResults *results;
    RLMRealm *realm;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UITextField *titleTxt;
@property (weak, nonatomic) IBOutlet UIView *insertView;
    
@end

@implementation RealmTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = CustomLocalizedString(@"realmTitle", nil);
//    realm = [RLMRealm defaultRealm];
    realm = [RLMRealm realmWithURL:[[RealmShare shareManager] getRLMDefaultRealmURL]];
    results = [RealmTestObj allObjectsInRealm:realm];
    
    //获取模拟器地址可以打开数据库文件所在文件
    DDLogDebug(@"%@", [RLMRealmConfiguration defaultConfiguration].fileURL);
    self.insertView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.insertView.layer.borderWidth = 0.5f;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)getData:(id)sender {
    results = [RealmTestObj allObjectsInRealm:realm]; // 从默认的 Realm 数据库中
    [self.tableView reloadData];
    NSLog(@"%@", results);
}
- (IBAction)createTable:(id)sender {
    if (self.nameTxt.text.length == 0 || self.titleTxt.text.length == 0){
        UIAlertController *ac=[UIAlertController alertControllerWithTitle:ALERT_TITLE message:@"name跟title别为空好么？" preferredStyle:UIAlertControllerStyleAlert];
        [ac addAction:[UIAlertAction actionWithTitle:@"好的！" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:ac animated:YES completion:nil];
    }else{
        RealmTestObj *data = [[RealmTestObj alloc] init];
        data.name = self.nameTxt.text;
        data.title = self.titleTxt.text;
        //    开放RLMRealm事务
        [realm beginWriteTransaction];
        //    添加到数据库 me为RLMObject
        [realm addObject:data];
        //    提交事务
        [realm commitWriteTransaction];
        
        self.nameTxt.text = @"";
        self.titleTxt.text = @"";
        [self.tableView reloadData];
    }
}
    
    
#pragma mark - tableview delegate
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return results.count;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
    
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    RealmTestObj *result = results[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"name:%@   |   title:%@",result.name,result.title];
    return cell;
}
    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
    
    //设置cell分割线做对齐
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
    
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
    
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        RealmTestObj *obj = results[indexPath.row]; // 存储在 Realm 中的 Book 对象
        // 在事务中删除一个对象
        [realm beginWriteTransaction];
        [realm deleteObject:obj];
        [realm commitWriteTransaction];
        
        [self.tableView reloadData];
        // Delete the row from the data source.
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*获得系统日志的路径**/
-(NSArray*)getLogPath
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * logPath = [docPath stringByAppendingPathComponent:@"Caches"];
    logPath = [logPath stringByAppendingPathComponent:@"Logs"];
    NSFileManager * fileManger = [NSFileManager defaultManager];
    NSError * error = nil;
    NSArray * fileList = [[NSArray alloc]init];
    fileList = [fileManger contentsOfDirectoryAtPath:logPath error:&error];
    NSMutableArray * listArray = [[NSMutableArray alloc]init];
    for (NSString * oneLogPath in fileList)
    {
        //带有工程名前缀的路径才是我们存储的日志路径
        if([oneLogPath hasPrefix:[NSBundle mainBundle].bundleIdentifier])
        {
            NSString * truePath = [logPath stringByAppendingPathComponent:oneLogPath];
            [listArray addObject:truePath];
        }
    }
    return listArray;
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
