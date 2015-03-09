//
//  NSJSONTestTests.m
//  NSJSONTestTests
//
//  Created by Jerry Lee on 15/3/9.
//  Copyright (c) 2015年 oldratlee.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MyClass.h"

@interface NSJSONTestTests : XCTestCase

@end

@implementation NSJSONTestTests

- (void)testNSDictionaryValueClassStable {
    NSDictionary *dictionary = @{@"k1" : @"13"};
    id o = dictionary[@"k1"];
    XCTAssertTrue([o isKindOfClass:[NSString class]]);
}

- (void)testNSJSONValueClassStable {
    NSString *json = @"{ "
            "\"k0\" : 42, "
            "\"k1\" : \"43\", "
            "\"k2\" : {\"k2k0\" : 44, \"k2k1\" : \"45\"}, "
            "\"k3\" : [46, \"47\"]"
            " }";
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

    // Use dynamic type
    id k0 = dictionary[@"k0"];
    XCTAssertTrue([k0 isKindOfClass:[NSNumber class]]);
    XCTAssertEqual(42, [k0 intValue]);

    // Use dynamic type and objectForKey: method
    id k1 = [dictionary objectForKey:@"k1"];
    XCTAssertTrue([k1 isKindOfClass:[NSString class]]);
    XCTAssertEqual(43, [k1 intValue]);

    NSNumber *k2k0 = dictionary[@"k2"][@"k2k0"];
    XCTAssertTrue([k2k0 isKindOfClass:[NSNumber class]]);
    XCTAssertEqual(44, k2k0.intValue);

    NSString *k2k1 = dictionary[@"k2"][@"k2k1"];
    XCTAssertTrue([k2k1 isKindOfClass:[NSString class]]);
    XCTAssertEqual(45, k2k1.intValue);

    NSNumber *k3k0 = dictionary[@"k3"][0];
    XCTAssertTrue([k3k0 isKindOfClass:[NSNumber class]]);
    XCTAssertEqual(46, k3k0.intValue);

    // Use objectAtIndex: method
    NSString *k3k1 = [dictionary[@"k3"] objectAtIndex:1];
    XCTAssertTrue([k3k1 isKindOfClass:[NSString class]]);
    XCTAssertEqual(47, k3k1.intValue);
}

- (void)testSubscriptOperatorInMyClass {
    MyClass *myClass = [[MyClass alloc] init];

    id o1 = myClass[0];
    XCTAssertEqualObjects(@"objectAtIndexedSubscript: Called", o1);
    id o2 = myClass[@"Key"];
    XCTAssertEqualObjects(@"objectForKeyedSubscript: Called", o2);
}

@end
