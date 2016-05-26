//
//  EditViewController.h
//  MYAddressBook
//
//  Created by zhiangkeji on 16/5/25.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact;
typedef void (^EditViewControllerBlock) ();
@interface EditViewController : UIViewController
@property (nonatomic,strong) Contact *contact;
@property (nonatomic,strong)EditViewControllerBlock block;
@end
