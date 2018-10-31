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
+ (HyPostsCollectionsManager * _Nonnull)sharedPostManager;

- (NSArray<HyPostsCollection *>*_Nonnull) postsCollections; // observeable
- (void)addPostCollections:(NSArray<NSURL *>*_Nonnull)urls;
- (void)removePostsCollections:(NSArray<HyPostsCollection *>*_Nonnull)postsCollections;
@end
