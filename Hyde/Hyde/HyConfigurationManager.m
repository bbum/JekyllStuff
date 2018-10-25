//
//  HyConfigurationManager.m
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import "HyConfigurationManager.h"

@interface HyConfigurationManager()
@end

@implementation HyConfigurationManager
+ (HyConfigurationManager *) sharedConfigurationManager
{
    static HyConfigurationManager *hyConfigurationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hyConfigurationManager = [[HyConfigurationManager alloc] init];
    });
    return hyConfigurationManager;
}

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

@end
