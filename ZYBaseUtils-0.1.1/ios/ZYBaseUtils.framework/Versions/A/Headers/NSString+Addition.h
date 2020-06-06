//
//  NSString+Addition.h
//  BeiAi
//
//  Created by Apple on 14-3-11.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Addition)

// 随机生成多少位的字符串
+ (NSString *)randomStringWithLength:(int)length;

// 字符串转换成十六进制
+ (NSString *)stringToHex:(const char *)key len:(NSUInteger)len;

+ (NSString *)stringWithOutSpace:(NSString *)str ;  //去除前后的空格

+ (BOOL)isInt:(NSString *)str ;  //是否全数字

+ (BOOL)isFloat:(NSString *)str ; //是否小数

+ (BOOL)isEmptyOrNull:(NSString *)str;
+ (NSString *)getPromptStringWithCode:(long)aCode;
+ (NSString *)getPromptStringWithNumber:(NSNumber *)aNumber;
+ (NSString *)getStringWithString:(NSString *)aString;

- (NSData *)hexToBytes;
- (NSString *)stringByStrippingHTML;
- (CGSize)safeSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)constrainedToSize;
- (CGFloat)safeWidthWithFont:(UIFont *)font;
- (CGFloat)safeHeightWithFont:(UIFont *)font width:(CGFloat)width;

/*
 *设置安全object for key
 */
- (id)safetyObjectForKey:(id)key;

- (CGFloat)calculateStringHeightWithSize:(CGSize)size attributes:(NSDictionary *)attr; //计算文本的高度

- (CGFloat)calculateStringWidthWithSize:(CGSize)size attributes:(NSDictionary *)attr; //计算文本的宽度

- (CGRect)calculateStringRectWithSize:(CGSize)size attributes:(NSDictionary *)attr;//计算文本的size

- (CGFloat)calculateAttributeStringHeightWithSize:(CGSize)size attributes:(NSDictionary *)attr; //计算富文本的高度

/*字典数组转为json字符串*/
+ (instancetype)stringWithJsonObject:(id)object;

//HmacSha1加密
+ (NSString *)Base_HmacSha1:(NSString *)key data:(NSString *)data;

+ (NSString *)hmacSha1:(NSString*)key text:(NSString*)text;

//设备的uuid
+ (NSString *)unique_id;



/// 检测字符串是否为空
/// @param aStr 要判断的字符串
+ (BOOL)isBlankString:(NSString *)aStr;

/// 校验链接的合法性
/// @param str 要校验的链接
+ (BOOL)verifyUrlLinkWithStr:(NSString *)str;


/// 是否是纯数字
/// @param string description
+ (BOOL)isPureInt:(NSString*)string;


/// 获取发送的文本中，是否有圣诞节活动的关键字（有的话，在聊天的界面中弹出动画效果）
/// @param str str description
/// @param activityType 活动类型 0活动关闭 1圣诞节  其他跳转h5 3是2019圣诞节  42020情人节活动
+ (NSString *)getChatAnimationWithStr:(NSString *)str activityType:(NSString *)activityType;

/// 连续的数字大于7位的替换为*
/// @param text 要判断的文本
+ (NSString *)filterSensitiveWordsWithText:(NSString*)text;


/// 判断字符串中是否存在emoji
/// @param string 要判断的字符串
/// @return YES(含有表情)
+ (BOOL)stringContainsEmoji:(NSString *)string;

/// 判断字符串中是否存在emoji
/// @param string 要判断的字符串
/// @return YES(含有表情)
+ (BOOL)hasEmoji:(NSString*)string;


/// 判断是不是九宫格
/// @param string 输入的字符
/// @return YES(是九宫格拼音键盘)
+ (BOOL)isNineKeyBoard:(NSString *)string;

/// 判断字符串中是否存在emoji
/// @param string 要判断的字符串
/// @return YES(含有表情)
+ (BOOL)containEmoji:(NSString *)string;

@end
