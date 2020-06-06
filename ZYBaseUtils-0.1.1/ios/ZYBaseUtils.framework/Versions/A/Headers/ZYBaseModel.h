//
//  ZYBaseModel.h
//  zoneyet_iOS
//
//  Created by zhangmeng on 2020/6/2.
//  Copyright © 2020 zhangmeng. All rights reserved.
//
//  该类是项目中数据模型的基类，后续项目中使用数据model，都继承于该类
//  该基类包含的功能有：
//  1、根据Json对象转成模型对象
//  2、根据字典转成模型对象
//  3、根据json数组转成模型数组
//  4、根据json字典转成模型字典
//  5、数据模型转成json对象
//  6、数据模型转成json数据流
//  7、数据模型转成json字符串
//  8、打印数据模型信息
//  9、拷贝当前模型数据
//  10、比较数据模型是否相等

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYBaseModel : NSObject

#pragma mark - 类方法，通过json或者字典转成模型

/// Json对象转模型
/// @param jsonObject json对象
+ (nullable instancetype)zyModelWithJsonObject:(id)jsonObject;

/// 字典对象转模型
/// @param dictionary 网络返回的字典对象
+ (nullable instancetype)zyModelWithDictionary:(NSDictionary *)dictionary;

/// 根据json数组转成对应的模型数组
/// @param cls 对应的model类型
/// @param json 是一个数组json
+ (nullable NSArray *)zyModelArrayWithClass:(Class)cls json:(id)json;

/// 根据json字典转成对应的模型字典
/// @param cls 对应的model类型
/// @param json 是一个字典json
+ (nullable NSDictionary *)zyModelDictionaryWithClass:(Class)cls json:(id)json;


#pragma mark - 实例方法

/// 将模型对象转成Json对象
- (nullable id)zyModelToJsonObject;

/// 将模型对象转成Json数据流
- (nullable NSData *)zyModelToJsonData;

/// 将模型对象转成Json字符串
- (nullable NSString *)zyModelToJsonString;

/// 获取当前模型对象的信息
- (NSString *)zyModelDescription;

/// 复制当前模型对象
- (id)zyModelCopy;

/// 比较两个模型对象是否相等
/// @param model 要进行比较的模型对象
- (BOOL)zyModelIsEqual:(id)model;


@end

NS_ASSUME_NONNULL_END
