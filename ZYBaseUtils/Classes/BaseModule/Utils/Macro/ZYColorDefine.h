//
//  ZYColorDefine.h
//  GChat
//
//  Created by 许锋 on 2020/6/2.
//  Copyright © 2020 zhangmeng. All rights reserved.
//
//  描述：主要声明一些获取颜色的方法包括RGB HEX两种方法,已经声明项目中的主色调颜色和主色调背景颜色等。


#ifndef ZYColorDefine_h
#define ZYColorDefine_h

//主颜色
#define KMainColor
//主背景颜色
#define KMainBackgroundColor


//随机颜色
#define KRandomColor        [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
//RGB颜色
#define KRGBA(a,b,c,d)      [UIColor colorWithRed:a/255. green:b/255. blue:c/255. alpha:d]
//HEX颜色
#define KColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//清除颜色
#define KCLEARCOLOR         [UIColor clearColor]

#endif /* ZYColorDefine_h */
