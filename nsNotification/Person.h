//
//  Person.h
//  nsNotification
//
//  Created by wei cui on 2020/4/5.
//  Copyright © 2020 wei cui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
/** 备注 */
@property (strong, nonatomic) NSString *name;
-(void)test;
@end

NS_ASSUME_NONNULL_END
