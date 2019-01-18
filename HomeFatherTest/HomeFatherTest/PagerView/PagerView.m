//
//  PagerView.m
//  PagerViewController
//
//  Created by 曾涛 on 2017/6/12.
//  Copyright © 2017年 曾涛. All rights reserved.
//

#import "PagerView.h"
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
//颜色
#define UIColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorWithRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define DefalutColor UIColorWithRGB(0x555555)
#define SelectedColor UIColorWithRGB(0xfd4d4c)
#define ButtonWidth   80
#define Button_OFFX   40 //butoon与左边的距离
@interface PagerView ()<UIScrollViewDelegate>

@property (strong, nonatomic) NSArray           *nameArray;
@property (strong, nonatomic) NSMutableArray    *buttonArray;

@property (strong, nonatomic) UIView            *indicateView;
@property (strong, nonatomic) UIView            *segmentView;
@property (strong, nonatomic) UIView            *bottomLine;
@property (strong, nonatomic) UIScrollView      *segmentScrollV;
@property (strong, nonatomic) UIScrollView      *titleBaseScrollView;
@property (assign, nonatomic) float      lineSeparation;
@end

@implementation PagerView

- (instancetype)initWithFrame:(CGRect)frame SegmentViewHeight:(CGFloat)segmentViewHeight Controller:(UIViewController *)controller titleArray:(NSArray *)titleArray{
    
    if (self = [super initWithFrame:frame]){
     
        self.viewController = controller;
        self.nameArray = titleArray;
        self.buttonArray = [NSMutableArray array]; //按钮数组
        //添加标题视图
        self.segmentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, segmentViewHeight)];
        self.segmentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.segmentView];
    }
    return self;
}
- (UIScrollView *)titleBaseScrollView
{
    if (_titleBaseScrollView) {
        _titleBaseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, CGRectGetHeight(self.segmentView.frame))];
        _titleBaseScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _titleBaseScrollView;
}
//设置头部视图的背景颜色
- (void)setSegmentBaseBackgroudColor:(UIColor *)color
{
    self.segmentView.backgroundColor = color;
}
- (void)setButtonWidth:(float)width Offx:(float)offX;
{
    for(UIView *btnView in self.titleBaseScrollView.subviews) {
        [btnView removeFromSuperview];
    }
    float totalWidth = self.nameArray.count * width;
    if (totalWidth > ScreenWidth) {
        [self.titleBaseScrollView setContentSize:CGSizeMake(2*offX + totalWidth, CGRectGetHeight(self.segmentView.frame))];
    }
    //添加按钮
    for (int i = 0; i < self.nameArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag =  100 + i;
        button.frame = CGRectMake(offX + ButtonWidth * i, 0, ButtonWidth, CGRectGetHeight(self.segmentView.frame));
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitle:self.nameArray[i] forState:UIControlStateNormal];
        [button setTitleColor:DefalutColor forState:UIControlStateNormal];
        [button setTitleColor:SelectedColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.titleBaseScrollView addSubview:button];
        [_buttonArray addObject:button];   //添加顶部按钮
    }
}

- (instancetype)initWithFrame:(CGRect)frame SegmentViewHeight:(CGFloat)segmentViewHeight titleArray:(NSArray *)titleArray Controller:(UIViewController *)controller lineWidth:(float)lineW lineHeight:(float)lineH{
    
    if (self = [super initWithFrame:frame]){
        
        _viewController = controller;
        self.nameArray = titleArray;
        _buttonArray = [NSMutableArray array]; //按钮数组
        
        //添加标题视图
        self.segmentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, segmentViewHeight)];
        self.segmentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.segmentView];
        
        
        self.lineSeparation = (ScreenWidth - ButtonWidth * self.nameArray.count- Button_OFFX*2)/(self.nameArray.count-1);
        
        //添加按钮
        for (int i = 0; i < self.nameArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag =  100 + i;
            button.frame = CGRectMake(Button_OFFX + (ButtonWidth + self.lineSeparation)  * i, 0, ButtonWidth, segmentViewHeight);
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitle:self.nameArray[i] forState:UIControlStateNormal];
            [button setTitleColor:DefalutColor forState:UIControlStateNormal];
            [button setTitleColor:SelectedColor forState:UIControlStateSelected];
            [button addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.segmentView addSubview:button];
            [_buttonArray addObject:button];   //添加顶部按钮
        }
        self.indicateView = [[UILabel alloc]initWithFrame:CGRectMake(Button_OFFX + (ButtonWidth - lineW)/2,segmentViewHeight-lineH, lineW, lineH)];
        self.indicateView.backgroundColor = SelectedColor;
        [self.segmentView addSubview:self.indicateView];
        
        self.bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, segmentViewHeight - 1, frame.size.width, 1)];
        self.bottomLine.backgroundColor = UIColorWithRGB(0xd8d8d8);
        [self.segmentView addSubview:self.bottomLine];
        
        //添加scrollView
        self.segmentScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, segmentViewHeight, frame.size.width, frame.size.height-segmentViewHeight)];
        self.segmentScrollV.bounces = NO;
        self.segmentScrollV.delegate = self;
        self.segmentScrollV.pagingEnabled = YES;
        self.segmentScrollV.showsHorizontalScrollIndicator = NO;
        self.segmentScrollV.contentSize = CGSizeMake(frame.size.width * _viewController.childViewControllers.count, 0);
        [self addSubview:self.segmentScrollV];
        
        //添加、取出ControllerView
        [self initChildViewController];
    }
    
    return self;
}
- (void)setSelectIndex:(NSInteger)index
{
    UIButton *button = [self.segmentView viewWithTag: 100 + index];
    [self Click:button];
}

- (void)Click:(UIButton *)sender {
    
    UIButton *button = sender;
    [button setTitleColor:SelectedColor forState:UIControlStateNormal];
    for (UIButton * btn in _buttonArray) {
        if (button != btn ) {
            [btn setTitleColor:DefalutColor forState:UIControlStateNormal];
        }
    }
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag - 100) * self.frame.size.width, 0) animated:YES ];
    
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue= dispatch_get_main_queue();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), queue, ^{
        [UIView animateWithDuration:0.25  delay:0.1 options: UIViewAnimationOptionCurveLinear animations:^{
            CGPoint  frame = weakSelf.indicateView.center;
            frame.x = button.center.x;
            weakSelf.indicateView.center = frame;

        } completion:^(BOOL finished) {
        }];
    });
    
    
}

#pragma UIScorllerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    __weak typeof(self) weakSelf = self;
        dispatch_queue_t queue= dispatch_get_main_queue();
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), queue, ^{
            [UIView animateWithDuration:0.25  delay:0.1 options: UIViewAnimationOptionCurveLinear animations:^{
                CGPoint  frame = weakSelf.indicateView.center;
                frame.x = Button_OFFX + ButtonWidth / 2 + (weakSelf.lineSeparation + ButtonWidth) * (weakSelf.segmentScrollV.contentOffset.x/self.frame.size.width);
                weakSelf.indicateView.center = frame;
            } completion:^(BOOL finished) {
            }];
        });
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self initChildViewController];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int pageNum = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    for (UIButton * btn in self.buttonArray)
    {
        (btn.tag - 100 == pageNum )?([btn setTitleColor:SelectedColor forState:UIControlStateNormal]):([btn setTitleColor:DefalutColor forState:UIControlStateNormal]);
    }
    [self initChildViewController];
}

//添加、取出ControllerView
- (void)initChildViewController{
    
    NSInteger index = self.segmentScrollV.contentOffset.x / self.segmentScrollV.frame.size.width;
    if (self.viewController.childViewControllers.count >0) {
        UIViewController *childVC = _viewController.childViewControllers[index];
        self.selectIndexStr = [NSString stringWithFormat:@"%ld",index];
        if (!childVC.view.superview) {
            
            childVC.view.frame = CGRectMake(index * self.segmentScrollV.frame.size.width, 0, self.segmentScrollV.frame.size.width, self.self.segmentScrollV.frame.size.height);
            [self.segmentScrollV addSubview:childVC.view];
        }
    }
}

@end
