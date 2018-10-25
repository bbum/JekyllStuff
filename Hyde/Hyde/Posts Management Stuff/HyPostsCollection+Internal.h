//
//  HyPostsCollection+Internal.h
//  Hyde
//
//  Created by Bill Bumgarner on 10/16/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#ifndef HyPostsCollection_Internal_h
#define HyPostsCollection_Internal_h

#import "HyPostsCollection.h"

@interface HyPostsCollection()
+ (instancetype)postsCollectionWithContentsOfURL:(NSURL*)postsDirectoryURL;
@end

#endif /* HyPostsCollection_Internal_h */
