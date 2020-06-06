//
//  ZYDataDefine.h
//  GChat
//
//  Created by 许锋 on 2020/6/2.
//  Copyright © 2020 zhangmeng. All rights reserved.
//
//  描述：主要声明一些项目中经常用到的数据类型宏定义
//  1:  常见数字，比如分割线大小 0.5，一行文字高度15等
//  2:  自定义基础类型数据 KData(d)
//  3:  网络请求常用状态码

#ifndef ZYDataDefine_h
#define ZYDataDefine_h

#define KData_Min        0.5
#define KData_2          2
#define KData_10         10
#define KData_15         15
#define KData_20         20
#define KData_44         44

#define KData(d)         d

//请求成功码
#define KSuccessCode     200
//请求成功状态
#define KSuccessStatus   0
//请求错误码
#define KErrorCode       401


#endif /* ZYDataDefine_h */
