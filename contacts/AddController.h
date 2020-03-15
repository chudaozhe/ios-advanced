//
//  AddController.h
//  contacts
//
//  Created by wei cui on 2019/11/23.
//  Copyright © 2019 wei cui. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ListController.h"
//#import "Contacts.h"
NS_ASSUME_NONNULL_BEGIN
//协议
@class AddController, Contacts;
@protocol AddControllerDelegate <NSObject>

@optional
-(void)addController:(AddController *)addVc didClickAddBtnWithContact:(Contacts *) contacts;

@end
@interface AddController : UIViewController
//
//@property (nonatomic, strong) ListController *contactVc;
/** 代理解藕 */
@property (nonatomic, weak) id delegate;
@end

NS_ASSUME_NONNULL_END
