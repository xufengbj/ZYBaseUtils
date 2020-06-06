//
//  ZYEnumDefine.h
//  GChat
//
//  Created by 许锋 on 2020/6/2.
//  Copyright © 2020 zhangmeng. All rights reserved.
//
//  描述：主要声明一些项目中常用统一的枚举类型

#ifndef ZYEnumDefine_h
#define ZYEnumDefine_h

//TabBar枚举类型
typedef NS_ENUM(NSUInteger, ZYTabbar) {
    ZYTabbarEncounter = 0,  //偶遇
    ZYTabbarFind = 1,  //发现
    ZYTabbarMessage = 2,  //消息
    ZYTabbarMe = 3  //我的
};

//验证链接字符合法性类型
typedef NS_ENUM(NSInteger, ZYValidateType){
     ZYValidateType_imChat = 0, // im聊天输入框
     ZYValidateType_exploreDetail_Comment = 1, // 探索详情评论
     ZYValidateType_imChat_GaGaService = 2, // GaGa客服
     ZYValidateType_store_address = 3, // 商城地址
     ZYValidateType_comment = 4, // 视频详情评论
     ZYValidateType_login_Account = 5, //  用户登录输入框【长度为小于40过滤关键字符】
     ZYValidateType_phone = 6, //  手机号输入框【长度为小于15的数字】
     ZYValidateType_money = 7, //  金额输入框【长度4过滤关键字符】
     ZYValidateType_searchName = 8, //  根据昵称、gagaid号搜索输入框【长度30过滤关键字符】
     ZYValidateType_password = 9, // 密码输入框【6-20位数字和字母加密传输】
     ZYValidateType_email = 10, //  邮箱输入框【长度40过滤关键字符】
     ZYValidateType_code = 11, //  短信验证码输入框【长度为6位的数字】
     ZYValidateType_redPacket_count = 12, //  红包个数【长度为2位的数字】
     ZYValidateType_groupInfo = 13, //  群组简介【长度为60位】
     ZYValidateType_releserDynamic = 14, //  发动态【长度为500位】
     ZYValidateType_fanyiji = 15, //  翻译机【长度为400位】
     ZYValidateType_adLink = 16, //  广告链接
     ZYValidateType_adTitle = 17, //  广告标题【长度为30位】
     ZYValidateType_individualitySignature = 18, //  个性签名【长度为500位】
     ZYValidateType_nickName = 19, //  用户昵称【长度为16位】
     ZYValidateType_redPacket = 20,    // 红包
     ZYValidateType_czkAccount = 21,    // 充值卡账号
     ZYValidateType_czkPassword     // 充值卡密码
};

#endif /* ZYEnumDefine_h */
