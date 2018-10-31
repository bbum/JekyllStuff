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

- (NSArray<HyPostsCollection *>*) postsCollections; // observeable
- (void)addPostCollections:(NSArray<NSURL *>*)urls;
- (void)removePostsCollections:(NSArray<HyPostsCollection *>*)postsCollections;
@end
