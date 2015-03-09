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

- (void)testNSJSONValueClassStable {
    NSString *json = @"{ "
            "\"k0\" : 42, "
            "\"k1\" : \"43\", "
            "\"kb\" : false, "
            "\"k2\" : {\"k2k0\" : 44, \"k2k1\" : \"45\", \"k2kb\" : true}, "
            "\"k3\" : [46, \"47\", false], "
            " }";
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

    // ==================================
    // Test NSNumber value
    // ==================================

    // Use dynamic type
    id k0 = dictionary[@"k0"];
    XCTAssertTrue([k0 isKindOfClass:[NSNumber class]]);
    XCTAssertEqual(42, [k0 intValue]);

    // ==================================
    // Test NSString value
    // ==================================

    // Use dynamic type and objectForKey: method
    id k1 = [dictionary objectForKey:@"k1"];
    XCTAssertTrue([k1 isKindOfClass:[NSString class]]);
    XCTAssertEqual(43, [k1 intValue]);

    // ==================================
    // Test Boolean value
    // ==================================

    NSNumber *kb = dictionary[@"kb"];
    XCTAssertTrue([kb isKindOfClass:[NSNumber class]]);
    XCTAssertTrue([kb isKindOfClass:[@YES class]]);
    XCTAssertEqualObjects(@NO, kb);

    // ==================================
    // Test value in json object
    // ==================================

    NSNumber *k2k0 = dictionary[@"k2"][@"k2k0"];
    XCTAssertTrue([k2k0 isKindOfClass:[NSNumber class]]);
    XCTAssertEqual(44, k2k0.intValue);

    NSString *k2k1 = dictionary[@"k2"][@"k2k1"];
    XCTAssertTrue([k2k1 isKindOfClass:[NSString class]]);
    XCTAssertEqual(45, k2k1.intValue);

    // Use unmatched type(declare NSNumber object to NSString), it's ok because of dynamic runtime of objective c
    NSString *k2kb = dictionary[@"k2"][@"k2kb"];
    XCTAssertTrue([k2kb isKindOfClass:[NSNumber class]]);
    XCTAssertTrue([k2kb isKindOfClass:[@YES class]]);
    XCTAssertEqualObjects(@YES, k2kb);

    // ==================================
    // Test value in json list
    // ==================================

    NSNumber *k3k0 = dictionary[@"k3"][0];
    XCTAssertTrue([k3k0 isKindOfClass:[NSNumber class]]);
    XCTAssertEqual(46, k3k0.intValue);

    // Use objectAtIndex: method
    NSString *k3k1 = [dictionary[@"k3"] objectAtIndex:1];
    XCTAssertTrue([k3k1 isKindOfClass:[NSString class]]);
    XCTAssertEqual(47, k3k1.intValue);

    NSNumber *k3kb = dictionary[@"k3"][2];
    XCTAssertTrue([k3kb isKindOfClass:[NSNumber class]]);
    XCTAssertTrue([k3kb isKindOfClass:[@YES class]]);
    XCTAssertEqualObjects(@NO, k3kb);
}

- (void)testNSNumberAndNSBooleanEquality {
    NSLog(@"[@YES class] = %@", [@YES class]); // [@YES class] = __NSCFBoolean
    NSLog(@"[@1 class] = %@", [@1 class]); // [@1 class] = __NSCFNumber
    XCTAssertNotEqualObjects([@YES class], [@1 class]);

    XCTAssertEqualObjects(@NO, @0);
    XCTAssertEqualObjects(@0, @NO);

    XCTAssertEqualObjects(@YES, @1);
    XCTAssertEqualObjects(@1, @YES);

    XCTAssertNotEqualObjects(@YES, @2);
    XCTAssertNotEqualObjects(@2, @YES);
}

- (void)testNSDictionaryValueClassStable {
    NSDictionary *dictionary = @{@"k1" : @"13"};
    id o = dictionary[@"k1"];
    XCTAssertTrue([o isKindOfClass:[NSString class]]);
    XCTAssertEqual(13, [o intValue]);
}

- (void)testSubscriptOperatorInMyClass {
    MyClass *myClass = [[MyClass alloc] init];

    id o1 = myClass[0];
    XCTAssertEqualObjects(@"objectAtIndexedSubscript: Called", o1);
    id o2 = myClass[@"Key"];
    XCTAssertEqualObjects(@"objectForKeyedSubscript: Called", o2);
}

@end
