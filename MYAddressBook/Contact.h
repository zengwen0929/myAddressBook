//
//  EditViewController.m
//  MYAddressBook
//
//  Created by zhiangkeji on 16/5/25.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *phone;


+ (instancetype)contactWithName:(NSString *)name phone:(NSString *)phone;


@end
