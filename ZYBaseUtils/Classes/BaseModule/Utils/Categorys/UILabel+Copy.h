//
//  UILabel+Copy.h
//  GChat
//
//  Created by 许锋 on 2020/6/2.
//  Copyright © 2020 zhangmeng. All rights reserved.
//
//  描述：可打开支持长按复制

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Copy)

//是否支持长按复制
@property (nonatomic, assign) BOOL isCopyable;

@end

NS_ASSUME_NONNULL_END
