//
//  TheDevice.h
//  TeenyWear
//
//  Created by Martin Gregory on 8/24/14.
//  Copyright (c) 2014 Martin Gregory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MetaWear/MetaWear.h>

@interface TheDevice : NSObject
@property (nonatomic, strong) MBLMetaWear* device;

+ (TheDevice*)sharedInstance;
@end
