//
//  EditViewController.m
//  MYAddressBook
//
//  Created by zhiangkeji on 16/5/25.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "Contact.h"

@implementation Contact


static NSString *nameKey = @"name";
static NSString *phoneKey = @"phone";

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    // name.phone
    [aCoder encodeObject:_name forKey:nameKey];
    
    [aCoder encodeObject:_phone forKey:phoneKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        _name = [aDecoder decodeObjectForKey:nameKey];
        _phone = [aDecoder decodeObjectForKey:phoneKey];
        
    }
    
    return self;
}

+ (instancetype)contactWithName:(NSString *)name phone:(NSString *)phone
{
    Contact *c = [[self alloc] init];
    
    c.name = name;
    c.phone = phone;
    
    return c;
}
@end
