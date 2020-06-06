//
//  UIView+Additions.h
//  WXD
//
//  Created by Fantasy on 10/16/14.
//  Copyright (c) 2014 JD.COM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIView *(^blockFrameSetting)(CGFloat x,CGFloat y,CGFloat w,CGFloat h);

@interface UIView (Addition)

@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint maxPoint;
@property (nonatomic, assign, readonly) CGPoint absoluteCenter;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

//加载xib
+ (instancetype)loadNibView;

//找出当前view所对应的控制器
- (UIViewController *)viewControllerResponder;

//设置frame
- (blockFrameSetting)ylyk_frame;

//判断view是否与window重叠
- (BOOL)intersectWithView:(UIView *)view;

/// 设置圆角
/// @param length 圆角大小
- (void)setCornerRadiusWithLength:(CGFloat)length;

@end
