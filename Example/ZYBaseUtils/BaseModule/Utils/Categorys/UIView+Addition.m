//
//  UIView+Additions.m
//  WXD
//
//  Created by Fantasy on 10/17/14.
//  Copyright (c) 2014 JD.COM. All rights reserved.
//

#import "UIView+Addition.h"

@implementation UIView (Addition)

- (void)setX:(float)x
{
    self.frame = CGRectMake(x, CGRectGetMinY(self.frame), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (void)setY:(float)y
{
    self.frame = CGRectMake(CGRectGetMinX(self.frame), y, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (void)setWidth:(float)width
{
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), width, CGRectGetHeight(self.bounds));
}

- (void)setHeight:(float)height
{
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.bounds), height);
}

- (void)setOrigin:(CGPoint)origin
{
    self.frame = CGRectMake(origin.x, origin.y, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (void)setSize:(CGSize)size
{
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), size.width, size.height);
}

- (void)setMaxPoint:(CGPoint)maxPoint
{
    self.frame = CGRectMake(maxPoint.x - CGRectGetWidth(self.bounds), maxPoint.y - CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (void)setAbsoluteCenter:(CGPoint)absoluteCenter
{
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), absoluteCenter.x * 2, absoluteCenter.y * 2);
}

- (void)setLeft:(CGFloat)x;
{
    CGRect frame = [self frame];
    frame.origin.x = x;
    [self setFrame:frame];
}

- (void)setTop:(CGFloat)y;
{
    CGRect frame = [self frame];
    frame.origin.y = y;
    [self setFrame:frame];
}

- (void)setRight:(CGFloat)right;
{
    CGRect frame = [self frame];
    frame.origin.x = right - frame.size.width;
    
    [self setFrame:frame];
}

- (void)setBottom:(CGFloat)bottom;
{
    CGRect frame = [self frame];
    frame.origin.y = bottom - frame.size.height;
    
    [self setFrame:frame];
}

- (void)setCenterX:(CGFloat)centerX;
{
    [self setCenter:CGPointMake(centerX, self.center.y)];
}

- (void)setCenterY:(CGFloat)centerY;
{
    [self setCenter:CGPointMake(self.center.x, centerY)];
}

- (float)x
{
    return CGRectGetMinX(self.frame);
}

- (float)y
{
    return CGRectGetMinY(self.frame);
}

- (float)width
{
    return CGRectGetWidth(self.frame);
}

- (float)height
{
    return CGRectGetHeight(self.frame);
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGSize)size
{
    return self.bounds.size;
}

- (CGPoint)absoluteCenter
{
    return CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) /2);
}

- (CGPoint)maxPoint
{
    return CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame));
}

- (CGFloat) top
{
    return self.frame.origin.y;
}

- (CGFloat) left
{
    return self.frame.origin.x;
}

- (CGFloat) bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)centerX;
{
    return [self center].x;
}

- (CGFloat)centerY;
{
    return [self center].y;
}

+ (instancetype)loadNibView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}

//找出当前view所对应的控制器
- (UIViewController *)viewControllerResponder {
    UIResponder *next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    } while (next != nil);
    
    return nil;
}

- (blockFrameSetting)ylyk_frame{
    return ^UIView *(CGFloat x, CGFloat y, CGFloat w, CGFloat h){
        self.frame = CGRectMake(x, y, w, h);
        return self;
    };
}

//判断view是否与window重叠
- (BOOL)intersectWithView:(UIView *)view {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}

/// 设置圆角
/// @param length 圆角大小
- (void)setCornerRadiusWithLength:(CGFloat)length {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = (int)length;
}

@end
