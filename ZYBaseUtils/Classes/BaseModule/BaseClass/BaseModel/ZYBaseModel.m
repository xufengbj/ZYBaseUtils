//
//  ZYBaseModel.m
//  zoneyet_iOS
//
//  Created by zhangmeng on 2020/6/2.
//  Copyright © 2020 zhangmeng. All rights reserved.
//

#import "ZYBaseModel.h"
#import "YYModel.h"

@implementation ZYBaseModel

/// Json对象转模型
/// @param jsonObject json对象
+ (nullable instancetype)zyModelWithJsonObject:(id)jsonObject{
    return [self yy_modelWithJSON:jsonObject];
}

/// 字典对象转模型
/// @param dictionary 网络返回的字典对象
+ (nullable instancetype)zyModelWithDictionary:(NSDictionary *)dictionary{
    return [self yy_modelWithDictionary:dictionary];
}

/// 根据json数组转成对应的模型数组
/// @param cls 对应的model类型
/// @param json 是一个数组json
+ (nullable NSArray *)zyModelArrayWithClass:(Class)cls json:(id)json{
    return [NSArray yy_modelArrayWithClass:cls json:json];
}

/// 根据json字典转成对应的模型字典
/// @param cls 对应的model类型
/// @param json 是一个字典json
+ (nullable NSDictionary *)zyModelDictionaryWithClass:(Class)cls json:(id)json{
    return [NSDictionary yy_modelDictionaryWithClass:cls json:json];
}



#pragma mark - 实例方法

/// 将模型对象转成Json对象
- (nullable id)zyModelToJsonObject{
    return [self yy_modelToJSONObject];
}

/// 将模型对象转成Json数据流
- (nullable NSData *)zyModelToJsonData{
    return [self yy_modelToJSONData];
}

/// 将模型对象转成Json字符串
- (nullable NSString *)zyModelToJsonString{
    return [self yy_modelToJSONString];
}

/// 获取当前模型对象的信息
- (NSString *)zyModelDescription {
    return [self yy_modelDescription];
}

/// 复制当前模型对象
- (id)zyModelCopy{
    return [self yy_modelCopy];
}

/// 比较两个模型对象是否相等
/// @param model 要进行比较的模型对象
- (BOOL)zyModelIsEqual:(id)model{
    return [self yy_modelIsEqual:model];
}

@end
