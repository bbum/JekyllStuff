//
//  HyPostsCollection.h
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSErrorDomain const HyPostsCollectionErrorDomain;

NS_ERROR_ENUM(HyPostsCollectionErrorDomain) {
    HyPostExistsError = 40, // attempt to create new post, but post with that name/date already exists
};

@class HyPost;
@interface HyPostsCollection : NSObject
@property(readonly) NSURL *URL;

- (NSComparisonResult) compareURLs:(HyPostsCollection *)other;

@property(readonly, copy) NSString *stringValueForDisplay;

+ (HyPost * _Nullable ) createPostWithDate:(NSDate *)date title:(NSString *)title hasAttachments:(BOOL)attachments error:(NSError **)error;
@end
