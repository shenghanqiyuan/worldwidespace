//
//  TestDataFrameModel.m
//  HomeFatherTest
//
//  Created by apple on 2018/10/29.
//  Copyright © 2018年 hanqiyuan. All rights reserved.
//

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT  [[UIScreen mainScreen] bounds].size.height
#import <UIKit/UIKit.h>

#import "TestDataFrameModel.h"

@implementation TestDataFrameModel
-(void)setTestDataModel:(TestDataModel *)testDataModel
{
    _testDataModel = testDataModel;
    _upViewFrame =  CGRectMake(0, 0,WIDTH, 50);
}
-(void)setIsOpen:(BOOL)isOpen
{
    _isOpen = isOpen;
    if(isOpen)
    {
        _downViewFrame  =  CGRectMake(0, CGRectGetMaxY(_upViewFrame),WIDTH, 115/2.0);
        _cellHeight = 50 + 115/2.0;
    }else{
        _downViewFrame  =  CGRectZero;
        _cellHeight = 50;
    }
}
@end
