//
//  MyClass.h
//  ObjcSingleton
//
//  Created by Jerry Lee on 15/3/9.
//  Copyright (c) 2015年 oldratlee.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject

- (id)objectAtIndexedSubscript:(NSInteger)idx;

- (id)objectForKeyedSubscript:(id)key;

@end
