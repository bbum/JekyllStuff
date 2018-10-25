//
//  HyPostsCollection.h
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HyPostsCollection : NSObject
@property(readonly) NSURL *URL;

- (NSComparisonResult) compareURLs:(HyPostsCollection *)other;

@property(readonly, copy) NSString *stringValueForDisplay;
@end
