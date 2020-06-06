//
//  NSString+Addition.m
//  BeiAi
//
//  Created by Apple on 14-3-11.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "NSString+Addition.h"
#import "NSData+CommonCrypto.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    #define UP_LTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
        boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) \
    attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
    #define UP_LTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
        sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif


@implementation NSString (Addition)

+ (NSString *)randomStringWithLength:(int)length
{
    char codeList[] = "0123456789abcdefghijklmnopqrstuvwxyz";
    NSMutableString *randomString = [[NSMutableString alloc] init];
    for (int i = 0; i < length; i++) {
        char codeIndex = arc4random() % 26;
        [randomString appendString:[NSString stringWithFormat:@"%c", codeList[codeIndex]]];
    }
    
    return randomString;
}

// 字符串转换成十六进制
+ (NSString *)stringToHex:(const char *)key len:(NSUInteger)len
{
    static char hex[1024];
    char buffer[8];
    for(unsigned n=0; n < len ; ++n) {
        sprintf(buffer, "%02x", (unsigned char)key[n]);
        hex[2*n]=buffer[0];
        hex[2*n+1]=buffer[1];
    }
    hex[len*2]='\0';
    
    return [NSString stringWithUTF8String:hex];
}

+ (NSString *)stringWithOutSpace:(NSString *)str  //去除两边的空格
{
    if(!str)
        return nil;
        
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (BOOL)isInt:(NSString *)str
{
    NSScanner* scan = [NSScanner scannerWithString:str];
    int iVal;
    return[scan scanInt:&iVal] && [scan isAtEnd];
}

+ (BOOL)isFloat:(NSString *)str
{
    NSScanner* scan = [NSScanner scannerWithString:str];
    float fVal;
    return[scan scanFloat:&fVal] && [scan isAtEnd];
}

+ (BOOL)isEmptyOrNull:(NSString *)str
{
	if (!str) {
		return YES;
	} else {
        if (![str isKindOfClass:[NSString class]]) {//chark add teacher221
            return YES;
        }

		NSString *trimedString = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
		if ([trimedString length] == 0) {
			// empty string
			return YES;
		} else {
			// is neither empty nor null
			return NO;
		}
	}
}

+ (NSString *)getPromptStringWithCode:(long)aCode
{
	NSNumberFormatter	*numberFormatter	= [[NSNumberFormatter alloc] init];
	NSNumber			*num				= [[NSNumber alloc] initWithLong:aCode];
	NSString			*numberString		= [numberFormatter stringFromNumber:num];
    
	NSString *string = NSLocalizedString(numberString, nil);
	return string;
}

+ (NSString *)getPromptStringWithNumber:(NSNumber *)aNumber
{
	if (!aNumber) {
		return @"error";
	}
    
	NSNumberFormatter	*numberFormatter	= [[NSNumberFormatter alloc] init];
	NSString			*numberString		= [numberFormatter stringFromNumber:aNumber];
    
	NSString *string = NSLocalizedString(numberString, nil);
	return string;
}

+ (NSString *)getStringWithString:(NSString *)aString
{
	NSString *string = NSLocalizedString(aString, nil);
    
	return string;
}

- (NSData*)hexToBytes {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}
-(NSString *) stringByStrippingHTML {
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

- (CGSize)safeSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)constrainedToSize
{
    return UP_LTILINE_TEXTSIZE(self, font, constrainedToSize, NSLineBreakByWordWrapping);
}

- (CGFloat)safeWidthWithFont:(UIFont *)font
{
    return [self safeSizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)].width;
}

- (CGFloat)safeHeightWithFont:(UIFont *)font width:(CGFloat)width
{
    return [self safeSizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)].height;
}

/*
 *设置安全object for key
 */
- (id)safetyObjectForKey:(id)key {
    return @"";
}

- (CGFloat)calculateStringWidthWithSize:(CGSize)size attributes:(NSDictionary *)attr {
    return [self calculateStringRectWithSize:size attributes:attr].size.width;
}
- (CGFloat)calculateStringHeightWithSize:(CGSize)size attributes:(NSDictionary *)attr {
    return [self calculateStringRectWithSize:size attributes:attr].size.height;
}
- (CGRect)calculateStringRectWithSize:(CGSize)size attributes:(NSDictionary *)attr {
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attr context:nil];
}

- (CGFloat)calculateAttributeStringHeightWithSize:(CGSize)size attributes:(NSDictionary *)attr {
    NSMutableAttributedString *attributes = [[NSMutableAttributedString alloc] initWithString:self attributes:attr];
    CGSize attSize = [attributes boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return attSize.height;
}

/*字典数组转为json字符串*/
+ (instancetype)stringWithJsonObject:(id)object {
    NSData *data=[NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

//HmacSHA1加密
+(NSString *)Base_HmacSha1:(NSString *)key data:(NSString *)data {
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    //Sha256:
    // unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    //CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    //sha1
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    
    
    NSString *hehe = [[NSString alloc] initWithData:HMAC encoding:NSUTF8StringEncoding];
    NSLog(@"----cccccccc-------%@",hehe);
    //将加密结果进行一次BASE64编码。
    NSString *hash = [HMAC base64EncodedStringWithOptions:0];////
    return hash;
}

+ (NSString *) hmacSha1:(NSString*)key text:(NSString*)text
{
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    //NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash;
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", cHMAC[i]];
    hash = output;
    
    return hash;
}

//设备的uuid
+ (NSString *)unique_id {
    NSString *uuid = [NSUUID UUID].UUIDString;
    return uuid;
}

/// 检测字符串是否为空
/// @param aStr 要判断的字符串
+ (BOOL)isBlankString:(NSString *)aStr {
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

/// 校验链接的合法性
/// @param str 要校验的链接
+ (BOOL)verifyUrlLinkWithStr:(NSString *)str {
    NSString *emailRegex = @"[a-zA-z]+://[^\s]*";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:str];
}

/// 是否是纯数字
/// @param string description
+ (BOOL)isPureInt:(NSString*)string {
    if ([NSString isBlankString:string]) {
        return NO;
    }
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}


/// 获取发送的文本中，是否有圣诞节活动的关键字（有的话，在聊天的界面中弹出动画效果）
/// @param str str description
/// @param activityType 活动类型 0活动关闭 1圣诞节  其他跳转h5 3是2019圣诞节  42020情人节活动
+ (NSString *)getChatAnimationWithStr:(NSString *)str activityType:(NSString *)activityType {
    NSString *lowerStr = [str lowercaseString];    //小写
    if ([activityType isEqualToString:@"3"]) {
        // 2019圣诞节
        if ([lowerStr containsString:@"圣诞快乐"]||
            [lowerStr containsString:@"圣诞节快乐"]||
            [lowerStr containsString:@"圣诞老人"]||
            [lowerStr containsString:@"圣诞树"]||
            [lowerStr containsString:@"圣诞礼物"]||
            [lowerStr containsString:@"merry christmas"]||
            [lowerStr containsString:@"happy christmas"]||
            [lowerStr containsString:@"santa claus"]||
            [lowerStr containsString:@"christmas tree"]||
            [lowerStr containsString:@"christmas gifts"]) {
            NSArray *arr = @[@"icon_christmas_cq",
                             @"icon_christmas_liwu",
                             @"icon_christmas_sdlr",
                             @"icon_christmas_sdw",
                             @"icon_christmas_tree",
                             @"icon_christmas_xh"];
            return arr[arc4random() % 5];
        }
    } else if ([activityType isEqualToString:@"4"]) {
        // 2020情人节
        if ([lowerStr containsString:@"情人节快乐"]||
            [lowerStr containsString:@"情人节"]||
            [lowerStr containsString:@"happy valentine's day"]||
            [lowerStr containsString:@"valentine's day"]) {
            NSArray *arr = @[@"icon_lover_heart",
                             @"icon_lover_flowers"];
            return arr[arc4random() % 2];
        }
        if ([lowerStr containsString:@"玫瑰"]||
        [lowerStr containsString:@"rose"]) {
            return @"icon_lover_flowers";
        }
    }
    return @"";
}

/// 连续的数字大于7位的替换为*
/// @param text 要判断的文本
+ (NSString *)filterSensitiveWordsWithText:(NSString*)text {
    if ([NSString isBlankString:text]) {
        return @"";
    }
    NSMutableString *changeText = [NSMutableString stringWithString:text];
    NSInteger i = 0;
    NSInteger count = 0;
    while (i < text.length) {
        NSString * str = [text substringWithRange:NSMakeRange(i, 1)];
        if (str.length > 0) {
            NSString *regex = @"[0-9]*";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
            // 是数字
            if ([pred evaluateWithObject:str]) {
                count++;
                if (count > 7) {
                    for (NSInteger j = i + 1 - count; j <= i; j++) {
                        changeText = (NSMutableString *)[changeText stringByReplacingCharactersInRange:NSMakeRange(j, 1) withString:@"*"];
                    }
                }
            } else {
                // 不是
                count = 0;
            }
        } else {
            count = 0;
        }
        i++;
    }
    return changeText;
}


/// 判断字符串中是否存在emoji
/// @param string 要判断的字符串
/// @return YES(含有表情)
+ (BOOL)stringContainsEmoji:(NSString *)string {
    if ([NSString isBlankString:string]) {
        return NO;
    }
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    return returnValue;
}

/// 判断字符串中是否存在emoji
/// @param string 要判断的字符串
/// @return YES(含有表情)
+ (BOOL)hasEmoji:(NSString*)string {
    if ([NSString isBlankString:string]) {
        return NO;
    }
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}


/// 判断是不是九宫格
/// @param string 输入的字符
/// @return YES(是九宫格拼音键盘)
+(BOOL)isNineKeyBoard:(NSString *)string {
    if ([NSString isBlankString:string]) {
        return NO;
    }
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for( int i = 0; i < len; i++) {
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}

/// 判断字符串中是否存在emoji
/// @param string 要判断的字符串
/// @return YES(含有表情)
+ (BOOL)containEmoji:(NSString *)string {
    NSUInteger len = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    if (len < 3) {  // 大于2个字符需要验证Emoji(有些Emoji仅三个字符)
        return NO;
    }
    // 仅考虑字节长度为3的字符,大于此范围的全部做Emoji处理
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bts = (Byte *)[data bytes];
    Byte bt;
    short v;
    for (NSUInteger i = 0; i < len; i++) {
        bt = bts[i];
        
        if ((bt | 0x7F) == 0x7F) {// 0xxxxxxxASIIC编码
            continue;
        }
        if ((bt | 0x1F) == 0xDF) {// 110xxxxx两个字节的字符
            i += 1;
            continue;
        }
        if ((bt | 0x0F) == 0xEF) {// 1110xxxx三个字节的字符(重点过滤项目)
            // 计算Unicode下标
            v = bt & 0x0F;
            v = v << 6;
            v |= bts[i + 1] & 0x3F;
            v = v << 6;
            v |= bts[i + 2] & 0x3F;
            
            // NSLog(@"%02X%02X", (Byte)(v >> 8), (Byte)(v & 0xFF));
            if ([NSString emojiInSoftBankUnicode:v] || [NSString emojiInUnicode:v]) {
                return YES;
            }
            
            i += 2;
            continue;
        }
        if ((bt | 0x3F) == 0xBF) {// 10xxxxxx10开头,为数据字节,直接过滤
            continue;
        }
        
        return YES; // 不是以上情况的字符全部超过三个字节,做Emoji处理
    }
    return NO;
}

+ (BOOL) emojiInSoftBankUnicode:(short)code {
    return ((code >> 8) >= 0xE0 && (code >> 8) <= 0xE5 && (Byte)(code & 0xFF) < 0x60);
}

+ (BOOL) emojiInUnicode:(short)code {
    if (code == 0x0023
        || code == 0x002A
        || (code >= 0x0030 && code <= 0x0039)
        || code == 0x00A9
        || code == 0x00AE
        || code == 0x203C
        || code == 0x2049
        || code == 0x2122
        || code == 0x2139
        || (code >= 0x2194 && code <= 0x2199)
        || code == 0x21A9 || code == 0x21AA
        || code == 0x231A || code == 0x231B
        || code == 0x2328
        || code == 0x23CF
        || (code >= 0x23E9 && code <= 0x23F3)
        || (code >= 0x23F8 && code <= 0x23FA)
        || code == 0x24C2
        || code == 0x25AA || code == 0x25AB
        || code == 0x25B6
        || code == 0x25C0
        || (code >= 0x25FB && code <= 0x25FE)
        || (code >= 0x2600 && code <= 0x2604)
        || code == 0x260E
        || code == 0x2611
        || code == 0x2614 || code == 0x2615
        || code == 0x2618
        || code == 0x261D
        || code == 0x2620
        || code == 0x2622 || code == 0x2623
        || code == 0x2626
        || code == 0x262A
        || code == 0x262E || code == 0x262F
        || (code >= 0x2638 && code <= 0x263A)
        || (code >= 0x2648 && code <= 0x2653)
        || code == 0x2660
        || code == 0x2663
        || code == 0x2665 || code == 0x2666
        || code == 0x2668
        || code == 0x267B
        || code == 0x267F
        || (code >= 0x2692 && code <= 0x2694)
        || code == 0x2696 || code == 0x2697
        || code == 0x2699
        || code == 0x269B || code == 0x269C
        || code == 0x26A0 || code == 0x26A1
        || code == 0x26AA || code == 0x26AB
        || code == 0x26B0 || code == 0x26B1
        || code == 0x26BD || code == 0x26BE
        || code == 0x26C4 || code == 0x26C5
        || code == 0x26C8
        || code == 0x26CE
        || code == 0x26CF
        || code == 0x26D1
        || code == 0x26D3 || code == 0x26D4
        || code == 0x26E9 || code == 0x26EA
        || (code >= 0x26F0 && code <= 0x26F5)
        || (code >= 0x26F7 && code <= 0x26FA)
        || code == 0x26FD
        || code == 0x2702
        || code == 0x2705
        || (code >= 0x2708 && code <= 0x270D)
        || code == 0x270F
        || code == 0x2712
        || code == 0x2714
        || code == 0x2716
        || code == 0x271D
        || code == 0x2721
        || code == 0x2728
        || code == 0x2733 || code == 0x2734
        || code == 0x2744
        || code == 0x2747
        || code == 0x274C
        || code == 0x274E
        || (code >= 0x2753 && code <= 0x2755)
        || code == 0x2757
        || code == 0x2763 || code == 0x2764
        || (code >= 0x2795 && code <= 0x2797)
        || code == 0x27A1
        || code == 0x27B0
        || code == 0x27BF
        || code == 0x2934 || code == 0x2935
        || (code >= 0x2B05 && code <= 0x2B07)
        || code == 0x2B1B || code == 0x2B1C
        || code == 0x2B50
        || code == 0x2B55
        || code == 0x3030
        || code == 0x303D
        || code == 0x3297
        || code == 0x3299
        // 第二段
        || code == 0x23F0) {
        return YES;
    }
    return NO;
}

@end
