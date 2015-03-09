//
//  MyClass.m
//  ObjcSingleton
//
//  Created by Jerry Lee on 15/3/9.
//  Copyright (c) 2015年 oldratlee.com. All rights reserved.
//

#import "MyClass.h"

@implementation MyClass

- (id)objectAtIndexedSubscript:(NSInteger)idx {
    return @"objectAtIndexedSubscript: Called";
}

- (id)objectForKeyedSubscript:(id)key {
    return @"objectForKeyedSubscript: Called";
}

@end
