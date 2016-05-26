//
//  AddViewController.h
//  MYAddressBook
//
//  Created by zhiangkeji on 16/5/25.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddViewController,Contact;
typedef void (^AddViewControllerBlock)(Contact *contact) ;


@interface AddViewController : UIViewController
@property (nonatomic,strong) AddViewControllerBlock block;

@end
