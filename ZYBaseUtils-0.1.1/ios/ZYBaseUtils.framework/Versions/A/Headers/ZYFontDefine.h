//
//  ZYFontDefine.h
//  GChat
//
//  Created by 许锋 on 2020/6/2.
//  Copyright © 2020 zhangmeng. All rights reserved.
//
//  描述：声明项目中字体大小和字体，以及项目中通用的一级二级三级字体大小

#ifndef ZYFontDefine_h
#define ZYFontDefine_h

#define KFontPingFangSemibold       @"PingFangSC-Semibold"
#define KFontPingFangMedium         @"PingFangSC-Medium"
#define KFontPingFangLight          @"PingFangSC-Light"
#define KFontGBK                    @"FZLanTingHei-H-GBK"

#define KFirstLevelFont             FONT(15)
#define KSecondLevelFont            FONT(13)
#define KThirdLevelFont             FONT(11)

//系统字体
#define FONT(n)             [UIFont systemFontOfSize:n]
//Semibold权重字体
#define SemiboldFont(n)     [UIFont fontWithName:KFontPingFangSemibold size:n] ? [UIFont fontWithName:KFontPingFangSemibold size:n] : [UIFont systemFontOfSize:n]
//Medium权重字体
#define MediumFont(n)       [UIFont fontWithName:KFontPingFangMedium size:n] ? [UIFont fontWithName:KFontPingFangMedium size:n] : [UIFont systemFontOfSize:n]
//GBK权重字体
#define GBKFont(n)        [UIFont fontWithName:KFontGBK size:n] ? [UIFont fontWithName:KFontGBK size:n] : [UIFont systemFontOfSize:n]

#endif /* ZYFontDefine_h */
