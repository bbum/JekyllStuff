//
//  HyPostManager.h
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HyPostsCollection;
@interface HyPostsCollectionsManager : NSObject
+ (HyPostsCollectionsManager *)sharedPostManager;

@property(readonly, nonatomic) NSArray<HyPostsCollection *>* postsCollections;
@end
