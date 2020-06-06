//
//  ZYValidateTextView.h
//  zoneyet_iOS
//
//  Created by 许锋 on 2020/6/3.
//  Copyright © 2020 zhangmeng. All rights reserved.
//

#import "ZYPlaceHolderTextView.h"
#import "ZYEnumDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZYValidateTextView : ZYPlaceHolderTextView

//合法性验证类型
@property (nonatomic, assign) ZYValidateType validateType;
//字符最大输入数量
@property (nonatomic, assign) NSInteger inputCount;
//验证合法性字符串
@property (nonatomic, copy) NSString *validateStr;


/// 验证字符串的合法性
/// @param range 要验证的字符串Range
/// @param text 要验证的字符串
- (BOOL)validateTextViewStrInRange:(NSRange)range replacementText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
