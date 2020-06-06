//
//  ZYValidateTextView.m
//  zoneyet_iOS
//
//  Created by 许锋 on 2020/6/3.
//  Copyright © 2020 zhangmeng. All rights reserved.
//

#import "ZYValidateTextView.h"
#import "NSString+Addition.h"

@implementation ZYValidateTextView

/// 验证字符串的合法性
/// @param range 要验证的字符串Range
/// @param text 要验证的字符串
- (BOOL)validateTextViewStrInRange:(NSRange)range replacementText:(NSString *)text{
    if ([NSString isEmptyOrNull:text]) {
        return YES;
    }
    if (_inputCount>0) {
        if (self.text.length>=_inputCount) {
            return NO;
        }
    }
    if ([NSString isBlankString:_validateStr]) {
        return YES;
    }
    BOOL verify = [self verifyInputTextWithStr:text];
    
    if (verify) {
        return NO;
    } else {
        //判断键盘是不是九宫格键盘
        if ([NSString isNineKeyBoard:text] ){
            return YES;
        } else {
            if ([NSString hasEmoji:text] || [NSString stringContainsEmoji:text] || [NSString containEmoji:text]){
                return NO;
            }
        }
    }
    return YES;
    
}


/// 设置校验类型
/// @param validateType 校验类型
- (void)setValidateType:(ZYValidateType)validateType{
    if (_validateType != validateType) {
        _validateType = validateType;
    }
    switch (_validateType) {
        case ZYValidateType_imChat: {
            _inputCount = 0;
        }
            break;
        case ZYValidateType_exploreDetail_Comment: {
            _inputCount = 500;
        }
            break;
        case ZYValidateType_imChat_GaGaService: {
            _inputCount = 1000;
        }
            break;
        case ZYValidateType_store_address: {
            _inputCount = 200;
        }
            break;
        case ZYValidateType_comment: {
            _inputCount = 200;
        }
            break;
        case ZYValidateType_groupInfo: {
            _inputCount = 50;
        }
            break;
        case ZYValidateType_releserDynamic: {
            _inputCount = 500;
        }
            break;
        case ZYValidateType_fanyiji: {
            _inputCount = 400;
        }
            break;
        case ZYValidateType_adLink: {
            _inputCount = 0;
        }
            break;
        case ZYValidateType_adTitle: {
            _inputCount = 30;
        }
            break;
        case ZYValidateType_individualitySignature: {
            _inputCount = 500;
        }
            break;
        default:
            break;
    }
}

/// 校验链接的合法性
/// @param str 要校验的字符串
- (BOOL)verifyInputTextWithStr:(NSString *)str {
     NSString *regex = self.validateStr;
     NSString *character = nil;
     for (int i = 0; i < str.length; i++) {
         character = [str substringWithRange:NSMakeRange(i, 1)];
         NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
         BOOL inputString = [predicate evaluateWithObject:character];
         if (inputString) {
             return YES;
         }
     }
     return NO;
}

@end
