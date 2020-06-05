//
//  ZYKeyboardTool.h
//  zoneyet_iOS
//
//  Created by 许锋 on 2020/6/3.
//  Copyright © 2020 zhangmeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYValidateTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZYKeyboardTool : NSObject

//键盘上方工具栏视图
@property(nonatomic, strong) UIView *toolBarView;
//TextView输入框
@property(nonatomic, strong) ZYValidateTextView *textView;
//占位符
@property(nonatomic, copy) NSString *placeholder;
//父视图
@property(nonatomic, strong) UIView *superView;
//是否完全完全隐藏工具栏 YES 则消失的时候彻底消失 NO 则键盘消失 ToolBar显示在底部
@property(nonatomic, assign) BOOL isHiddenToolBar;
// 点击Return键代码块
@property(nonatomic, copy)  void (^returnBlcok)(NSString *inputStr);

//进入激活状态
- (void)becomeFirstResponder;

/// 添加键盘监听
- (void)addKeyboardObserver;
/// 移除观察监听者
- (void)removeObserver;

@end

NS_ASSUME_NONNULL_END
