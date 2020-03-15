//
//  Person.m
//  file-storage
//
//  Created by wei cui on 2019/11/25.
//  Copyright © 2019 wei cui. All rights reserved.
//

#import "Person.h"

@implementation Person
//自定义对象归档时调用
//作用：描述哪些属性需要归档
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeInt:_age forKey:@"age"];
}
//解档对象时调用
//作用：描述哪些属性需要解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    //什么时候需要调用super initWithCode
    //解析文件的时候，xib,storyboard，详见RedView.m
    if (self = [super init ]) {
        //注意：一定要给成员变量赋值
        //name
        _name = [aDecoder decodeObjectForKey:@"name"];
        _age = [aDecoder decodeIntForKey:@"age"];
    }
    return self;
}
@end
