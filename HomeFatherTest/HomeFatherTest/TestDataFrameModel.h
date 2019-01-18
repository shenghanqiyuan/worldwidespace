//
//  TestDataFrameModel.h
//  HomeFatherTest
//
//  Created by apple on 2018/10/29.
//  Copyright © 2018年 hanqiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestDataModel.h"
@interface TestDataFrameModel : NSObject
@property (nonatomic,strong) TestDataModel *testDataModel;

@property (nonatomic,assign,readonly) CGRect upViewFrame;

@property (nonatomic,assign,readonly) CGRect downViewFrame;

@property (nonatomic,assign,readonly) CGFloat cellHeight;
@property (nonatomic,assign) BOOL isOpen;//是否打开啦

@end
