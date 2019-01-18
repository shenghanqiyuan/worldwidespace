//
//  TestTableViewCell.m
//  HomeFatherTest
//
//  Created by apple on 2018/10/29.
//  Copyright © 2018年 hanqiyuan. All rights reserved.
//
#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT  [[UIScreen mainScreen] bounds].size.height
#import "TestTableViewCell.h"
@interface TestTableViewCell ()
@property(nonatomic,strong) UIButton *button;
@property(nonatomic,strong) UIView *upView;
@property(nonatomic,strong) UIView *downView;
@end
@implementation TestTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUIInfo];
    }
    return  self;
}
-(UIView *)downView
{
    if (_downView == nil) {
        _downView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.upView.frame),WIDTH, 0)];
        _downView.backgroundColor = [UIColor blueColor];
        

        float xOff = 30;
        float bettow = 65/2.0;
        
        for ( int  i  = 0; i < 5; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(xOff +(46 + bettow) * i, 0, 46, 115/2.0);
            [button setBackgroundImage:[UIImage imageNamed:@"icon-xie"] forState:UIControlStateNormal];
            button.hidden = NO;
            [_downView addSubview:button];
        }
    }
    return _downView;
}
-(void)createUIInfo
{
    
    self.upView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, 50)];
    self.upView.backgroundColor = [UIColor whiteColor];
    
//    self.downView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.upView.frame),WIDTH, 0)];
//     self.downView.backgroundColor = [UIColor blueColor];
//
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame =CGRectMake(WIDTH - 15 - 100, 10, 100, 25);
    
    
//    float xOff = 30;
//    float bettow = 65/2.0;
//    
//    for ( int  i  = 0; i < 5; i++)
//    {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(xOff +(46 + bettow) * i, 0, 46, 115/2.0);
//        [button setBackgroundImage:[UIImage imageNamed:@"icon-xie"] forState:UIControlStateNormal];
//        button.hidden = YES;
//        [self.downView addSubview:button];
//    }
    
    
    
    
    
    [self.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.button setTitle:@"展开" forState:UIControlStateNormal];
    [self.button setTitle:@"关闭" forState:UIControlStateSelected];

    
    [self.button addTarget:self action:@selector(openDownCell:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.upView];
    [self.contentView addSubview:self.downView];
    [self.upView addSubview:self.button];
    
}
-(void)openDownCell:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(cell:withFrameModel:)]) {
        [self.delegate cell:self withFrameModel:self.frameModel];
    }
    
}
-(void)setFrameModel:(TestDataFrameModel *)frameModel
{
    _frameModel = frameModel;
    self.upView.frame = frameModel.upViewFrame;
    self.downView.frame  = frameModel.downViewFrame;
    self.downView.hidden = !frameModel.isOpen;
    if (frameModel.isOpen) {
//        self.downView.hidden  = NO;
         [self.contentView addSubview:self.downView];
        
    }else{
//        self.downView.hidden  = YES;
//        for (UIView *view  in self.downView.subviews) {
//            view.hidden = YES;
//        }
        [self.downView removeFromSuperview];


//
    }
    self.button.selected = frameModel.isOpen;
}
-(void)layoutSubviews
{
    self.upView.frame = _frameModel.upViewFrame;
    self.downView.frame  = _frameModel.downViewFrame;
    self.contentView.frame = CGRectMake(0, 0,WIDTH, _frameModel.cellHeight);
}
@end
