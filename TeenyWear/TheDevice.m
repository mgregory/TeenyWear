//
//  TheDevice.m
//  TeenyWear
//
//  Created by Martin Gregory on 8/24/14.
//  Copyright (c) 2014 Martin Gregory. All rights reserved.
//

#import "TheDevice.h"

@implementation TheDevice
+ (TheDevice*)sharedInstance {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

@end
