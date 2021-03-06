//
//  Contacts.m
//  contacts
//
//  Created by wei cui on 2019/11/23.
//  Copyright © 2019 wei cui. All rights reserved.
//

#import "Contacts.h"
#import <objc/runtime.h>

@implementation Contacts
#pragma mark 打印模型
- (NSString *)description{
    // warning : 一定要引入头文件  #import <objc/runtime.h>
    NSString * desc= [super description];
    desc = [NSString stringWithFormat:@"\n%@\n", desc];

    unsigned int outCount;
    //获取obj的属性数目
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);

    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        //获取property的C字符串
        const char * propName = property_getName(property);
        if (propName) {
            //获取NSString类型的property名字
            NSString    * prop = [NSString stringWithCString:propName encoding:[NSString defaultCStringEncoding]];
            //获取property对应的值
            id obj = [self valueForKey:prop];
            //将属性名和属性值拼接起来
            desc = [desc stringByAppendingFormat:@"%@ : %@,\n",prop,obj];
        }
    }

    free(properties);
    return desc;
}
@end
