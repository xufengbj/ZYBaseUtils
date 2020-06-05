//
//  ZYPlaceHolderTextView.h
//  zoneyet_iOS
//
//  Created by 许锋 on 2020/6/3.
//  Copyright © 2020 zhangmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYPlaceHolderTextView : UITextView

//占位符
@property (nonatomic, copy) NSString *placeholder;
//占位符颜色
@property (nonatomic, strong) UIColor  *placeholderColor;


/// 文本发送了变化
/// @param notification 通知
- (void)textChanged:(NSNotification *)notification;

@end

NS_ASSUME_NONNULL_END
