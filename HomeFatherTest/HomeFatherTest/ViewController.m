//
//  ViewController.m
//  HomeFatherTest
//
//  Created by hanqiyuan on 2018/10/28.
//  Copyright © 2018年 hanqiyuan. All rights reserved.
//
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#import "ViewController.h"
#import "PagerView.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThreeViewController.h"

@interface ViewController ()
@property(nonatomic,strong) PagerView * pagerView;
@property(nonatomic,strong) FirstViewController * firstVC;
@property(nonatomic,strong) SecondViewController * secondVC;
@property(nonatomic,strong) ThreeViewController * threeVC;

@end

@implementation ViewController
-(FirstViewController *)firstVC
{
    if (_firstVC == nil) {
        _firstVC = [[FirstViewController alloc]init];
    }
    return _firstVC;
}
-(SecondViewController *)secondVC
{
    if (_secondVC== nil) {
        _secondVC = [[SecondViewController alloc]init];
    }
    return _secondVC;
}
-(ThreeViewController *)threeVC
{
    if (_threeVC == nil) {
        _threeVC = [[ThreeViewController alloc]init];
    }
    return _threeVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self addChildViewControllers];
    [self newCreateUI];
}
#pragma mark - 设置界面
- (void)addChildViewControllers
{
    [self addChildViewController:self.firstVC];
    [self addChildViewController:self.secondVC];
    [self addChildViewController:self.threeVC];
}
- (void)newCreateUI
{
    NSMutableArray *titleArray = [[NSMutableArray alloc] init];

    [titleArray addObject:@"智能出借"];
    [titleArray addObject:@"债权转让"];
    [titleArray addObject:@"债权转让"];
    CGRect stateFrame = [[UIApplication sharedApplication] statusBarFrame];
    _pagerView = [[PagerView alloc] initWithFrame:CGRectMake(0,stateFrame.size.height,ScreenWidth,ScreenHeight - 20 - 49)
                                SegmentViewHeight:44
                                       titleArray:titleArray
                                       Controller:self
                                        lineWidth:70
                                       lineHeight:3];
    
    [self.view addSubview:_pagerView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
