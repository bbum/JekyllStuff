//
//  HyPostsCollection.h
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSErrorDomain _Nonnull const HyPostsCollectionErrorDomain;

NS_ERROR_ENUM(HyPostsCollectionErrorDomain) {
    HyPostExistsError = 40, // attempt to create new post, but post with that name/date already exists
};

@class HyPost;
@interface HyPostsCollection : NSObject
@property(readonly) NSURL * _Nonnull URL;

- (NSComparisonResult) compareURLs:(HyPostsCollection *_Nullable)other;

@property(readonly, copy) NSString * _Nonnull stringValueForDisplay;

+ (HyPost * _Nullable) createPostWithDate:(NSDate * _Nonnull)date title:(NSString * _Nonnull)title hasAttachments:(BOOL)attachments error:(NSError * _Nullable* _Nullable)error;
@end
