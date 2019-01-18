//
//  TestTableViewCell.h
//  HomeFatherTest
//
//  Created by apple on 2018/10/29.
//  Copyright © 2018年 hanqiyuan. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TestDataFrameModel.h"

@class TestTableViewCell;
@protocol TestTableViewCellDeleagte<NSObject>
-(void)cell:(TestTableViewCell *)cell withFrameModel:(TestDataFrameModel *)frameModel;
@end


@interface TestTableViewCell : UITableViewCell
@property(nonatomic,strong)TestDataFrameModel *frameModel;
@property (nonatomic,weak)id<TestTableViewCellDeleagte> delegate;
@end
