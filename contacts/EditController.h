//
//  EditController.h
//  contacts
//
//  Created by wei cui on 2019/11/24.
//  Copyright © 2019 wei cui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contacts, EditController;
NS_ASSUME_NONNULL_BEGIN
//协议
@protocol EditControllerDelegate <NSObject>

@optional
-(void)editNotify;

@end
//定义block类型别名
typedef void(^EditControllerBlock) ();
@interface EditController : UIViewController
/** 用于接收 list控制器传过来的contacts模型对象 */
@property (nonatomic, strong) Contacts *contact;
/** 代理*/
@property (nonatomic, weak) id delegate;
/** 备注 */
@property (nonatomic, strong) EditControllerBlock blok;
@end

NS_ASSUME_NONNULL_END
