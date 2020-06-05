//
//  ZYLanguageTool.m
//  GChat
//
//  Created by 许锋 on 2020/6/1.
//  Copyright © 2020 zhangmeng. All rights reserved.
//

#import "ZYLanguageTool.h"

NSDictionary *bundle = nil; //语言资源
NSString *setL = nil; //当前设置的语言

@implementation ZYLanguageTool

+ (void)initialize {
    NSUserDefaults  *defs = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defs objectForKey:@"AppleLanguages"];
    NSString *current = [languages objectAtIndex:0];
    
    [self setLanguage:current];
    
    //把用户设置语言保存在数据中
    [[NSUserDefaults standardUserDefaults] setValue:current forKey:@"lastLanguageSet"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 设置系统语言
 @param language 语言环境 包括 简体中文 繁体中文 en de es ja ko ru
*/
+ (void)setLanguage:(NSString *)language {
    NSUserDefaults  *defs = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defs objectForKey:@"AppleLanguages"];
    NSString *current = [languages objectAtIndex:0];
    setL = language;
    
    if (bundle) {
        bundle = nil;
    }
    
    if ([current hasPrefix:@"zh-Hans"]) {
        current = @"zh-Hans";
    } else if ([current hasPrefix:@"de"]) {
        current = @"de";
    } else if ([current hasPrefix:@"es"]) {
        current = @"es";
    } else if ([current hasPrefix:@"zh-Hant"]) {
        current = @"zh-Hant";
    } else if ([current hasPrefix:@"ja"]) {
        current = @"ja";
    } else if ([current hasPrefix:@"ko"]) {
        current = @"jo";
    } else if ([current hasPrefix:@"ru"]) {
        current = @"ru";
    } else if ([current hasPrefix:@"en"]) {
        current = @"en";
    }

    //如果找不到用户设置的内容，默认使用系统设置的语言
    NSString  *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    if (!path || !language) {
        setL = current;
        path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",current] ofType:@"lproj"];
    }
    if(!path) {
        path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    }
    NSString *paths = [path stringByAppendingPathComponent:@"Main.strings"];
    bundle = [[NSDictionary alloc] initWithContentsOfFile:paths];
}

/**
 获取多语言下的文本
 @param key 文本key
*/
+ (NSString *)getValueFor:(NSString *)key {
    if (bundle) {
        if (![bundle objectForKey:key]) {
            return key;
        } else {
            return [bundle objectForKey:key];
        }
    } else {
        return key;
    }
}


/**
获取当前语言
*/
+ (NSString *)getSetLanguage {
    return setL;
}


/**
 获取手机当前设置语言
*/
+ (NSString *)getPhoneLanguage {
    NSUserDefaults  *defs = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defs objectForKey:@"AppleLanguages"];
    NSString *current = [languages objectAtIndex:0];
    
    return current;
}

/**
 获取app名称
 */
+ (NSString *)getAppName {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDict objectForKey:@"CFBundleDisplayName"];
    if (app_Name == nil) {
        app_Name = [infoDict objectForKey:@"CFBundleName"];
    }
    return app_Name;
}

@end
