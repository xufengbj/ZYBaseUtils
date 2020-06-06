//
//  TestModel.h
//  zoneyet_iOS
//
//  Created by zhangmeng on 2020/6/2.
//  Copyright © 2020 zhangmeng. All rights reserved.
//
//  测试model

#import "ZYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestModel : ZYBaseModel
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *gender;

@end

NS_ASSUME_NONNULL_END
