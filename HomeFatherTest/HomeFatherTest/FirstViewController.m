//
//  FirstViewController.m
//  HomeFatherTest
//
//  Created by hanqiyuan on 2018/10/28.
//  Copyright © 2018年 hanqiyuan. All rights reserved.
//
#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT  [[UIScreen mainScreen] bounds].size.height

#import "FirstViewController.h"
#import "TestTableViewCell.h"
#import "TestDataFrameModel.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource,TestTableViewCellDeleagte>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *frameModelArray;
@end

@implementation FirstViewController
-(NSMutableArray *)frameModelArray
{
    if (_frameModelArray == nil)
    {
        _frameModelArray = [[NSMutableArray alloc]init];
    }
    return _frameModelArray;
}

-(UITableView *)tableView
{
    if(_tableView == nil)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0 , 0, WIDTH , HEIGHT - 64) style:UITableViewStylePlain];
        [_tableView registerClass:[TestTableViewCell class] forCellReuseIdentifier:@"TestTableViewCellId"];
        _tableView.backgroundColor = [UIColor whiteColor];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 80;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];
    [self initTestData];
}
-(void)initTestData
{
    for (int  i = 0; i < 100; i++)
    {
        TestDataFrameModel *frameModel = [[TestDataFrameModel alloc]init];
        frameModel.testDataModel  = [[TestDataModel alloc]init];
        frameModel.isOpen = NO;
        [self.frameModelArray addObject:frameModel];
    }
    [self.tableView reloadData];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.frameModelArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestDataFrameModel *frameModel = _frameModelArray[indexPath.row];
    return frameModel.cellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestTableViewCellId" forIndexPath:indexPath];
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestTableViewCellId"];
    if (cell == nil) {
        cell = [[TestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TestTableViewCellId"];
    }
    cell.delegate = self;
    TestDataFrameModel *frameModel = _frameModelArray[indexPath.row];
    cell.frameModel = frameModel;
    return cell;
    
}
-(void)cell:(TestTableViewCell *)cell withFrameModel:(TestDataFrameModel *)frameModel
{
    frameModel.isOpen =  !frameModel.isOpen;
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/






@end
