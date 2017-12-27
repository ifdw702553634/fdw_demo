//
//  TableViewAnViewController.m
//  PhotoSelectDemo
//
//  Created by mude on 2017/12/27.
//  Copyright © 2017年 DreamTouch. All rights reserved.
//

#import "TableViewAnViewController.h"
#import "FirstTableViewCell.h"
#import "AnButtonTableViewCell.h"

static NSString *kFirstTableViewCell = @"FirstTableViewCell";
static NSString *kAnButtonTableViewCell = @"AnButtonTableViewCell";

static CGFloat cellHeight = 100;
static CGFloat btnCellHeight = 60;
static CGFloat headerHeight = 10;
@interface TableViewAnViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_dataArr;
    BOOL _isInsert;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TableViewAnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = CustomLocalizedString(@"tableViewAnTitle", nil);
    [self prepareView];
    
    _dataArr = [[NSMutableArray alloc] init];
    _isInsert = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)prepareView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count+1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == _dataArr.count) {
        return btnCellHeight;
    }
    return cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == _dataArr.count) {
        AnButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAnButtonTableViewCell];
        if (cell == nil) {
            //通过xib的名称加载自定义的cell
            cell = [[[NSBundle mainBundle] loadNibNamed:kAnButtonTableViewCell owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        __block AnButtonTableViewCell *weakCell = cell;
        cell.addCellBolck = ^(){
            CATransform3D transform = CATransform3DIdentity;
            transform = CATransform3DTranslate(transform, 0, 0, 0);
            weakCell.layer.transform = transform;
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakCell.layer.transform = CATransform3DTranslate(transform, 0, -10, 0);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    weakCell.layer.transform = CATransform3DTranslate(weakCell.layer.transform, 0, cellHeight+headerHeight+30, 0);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        weakCell.layer.transform = CATransform3DTranslate(weakCell.layer.transform, 0, -20, 0);
                    } completion:^(BOOL finished) {
                        _isInsert = YES;
                        [_dataArr addObject:[NSString stringWithFormat:@"插入数据%ld",(long)indexPath.section]];
                        [self.tableView reloadData];
                    }];
                }];
            }];
        };
        return cell;
    }else{
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFirstTableViewCell];
        if (cell == nil) {
            //通过xib的名称加载自定义的cell
            cell = [[[NSBundle mainBundle] loadNibNamed:kFirstTableViewCell owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.title.text = _dataArr[indexPath.section];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return headerHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

//设置cell分割线做对齐
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if (_isInsert == YES) {
        if (indexPat.section == _dataArr.count - 1) {
            CATransform3D transform = CATransform3DIdentity;
            transform = CATransform3DTranslate(transform, SCREEN_WIDTH, 0, 0);
            cell.layer.transform = transform;
            [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                cell.layer.transform = CATransform3DIdentity;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    cell.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -50, 0, 0);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        cell.layer.transform = CATransform3DIdentity;
                    } completion:^(BOOL finished) {
                        _isInsert = NO;
                    }];
                }];
            }];
            
        }
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}


@end
