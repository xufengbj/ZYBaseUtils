//
//  ZYBasePresenter.m
//  GChat
//
//  Created by zhangmeng on 2020/6/1.
//  Copyright © 2020 zhangmeng. All rights reserved.
//

#import "ZYBasePresenter.h"

@implementation ZYBasePresenter
/**
 初始化函数
 */
- (instancetype)initWithView:(id)viewObj {
    self = [super init];
    if (self) {
        _viewObject = viewObj;
    }
    return self;
}

/**
 * 绑定视图
 * @param view 要绑定的视图
 */
- (void)attachView:(id)viewObj {
    _viewObject = viewObj;
}

/**
 解绑视图
 */
- (void)detachView {
    _viewObject = nil;
}
@end
