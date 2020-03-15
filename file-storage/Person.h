//
//  Person.h
//  file-storage
//
//  Created by wei cui on 2019/11/25.
//  Copyright © 2019 wei cui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//如果一个自定义对象想要归档， 必须遵守nscoding协议， 实现协议方法
@interface Person : NSObject<NSCoding>
/** 年龄 */
@property (nonatomic, assign) NSInteger age;
/** 姓名 */
@property (nonatomic, strong) NSString *name;

@end

NS_ASSUME_NONNULL_END
