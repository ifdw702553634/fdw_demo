//
//  FirstViewController.m
//  PhotoSelectDemo
//
//  Created by mude on 16/12/2.
//  Copyright © 2016年 DreamTouch. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstTableViewCell.h"


static NSString *kFirstTableViewCell = @"FirstTableViewCell";

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_dataArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

    
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = CustomLocalizedString(@"homeTitle", nil);
    [self loadData];
    [self prepareView];
}

- (void)prepareView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
}
- (void)loadData{
    _dataArr = @[
  @{@"title":CustomLocalizedString(@"home_Photo", nil),@"controller":@"SelectPhotoViewController"},
  @{@"title":CustomLocalizedString(@"home_MutableLanguage", nil),@"controller":@"MutableLanguageViewController"},
  @{@"title":CustomLocalizedString(@"home_MutableScene", nil),@"controller":@"MutableSceneViewController"},
  @{@"title":CustomLocalizedString(@"home_Speech", nil),@"controller":@"SpeechRecognitionViewController"},
  @{@"title":CustomLocalizedString(@"home_SID", nil),@"controller":@"SIDViewController"},
  @{@"title":CustomLocalizedString(@"home_constraint", nil),@"controller":@"ConstraintTestViewController"},
  @{@"title":CustomLocalizedString(@"home_realm", nil),@"controller":@"RealmTestViewController"}];
}


#pragma mark - tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFirstTableViewCell];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:kFirstTableViewCell owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.title.text = _dataArr[indexPath.row][@"title"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [[NSClassFromString(_dataArr[indexPath.row][@"controller"]) alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
    

@end
