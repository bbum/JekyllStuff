//
//  HyPostManager.m
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import "HyPostsCollectionsManager.h"

@implementation HyPostsCollectionsManager
+ (HyPostsCollectionsManager *)sharedPostManager
{
    static HyPostsCollectionsManager *hyPostManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hyPostManager = [[HyPostsCollectionsManager alloc] init];
    });
    
    return hyPostManager;
}
@end
