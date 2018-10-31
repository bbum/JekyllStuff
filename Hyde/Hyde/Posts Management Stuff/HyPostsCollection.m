//
//  HyPostsCollection.m
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import "HyPostsCollection.h"
#import "HyPostsCollection+Internal.h"

NSErrorDomain const HyPostsCollectionErrorDomain = @"HyPostsCollectionErrorDomain";

@implementation HyPostsCollection
+ (instancetype)postsCollectionWithContentsOfURL:(NSURL*)postsDirectoryURL
{
	return [[HyPostsCollection alloc] initWithURL:postsDirectoryURL];
}

- initWithURL:(NSURL *)URL
{
	if (self = [super init]) {
		_URL = URL;
	}
	return self;
}

- (NSComparisonResult) compareURLs:(HyPostsCollection *)other
{
	return [self.URL.absoluteString compare:other.URL.absoluteString];
}

-(NSString *)stringValueForDisplay
{
	return _URL.absoluteString;
}

+ (HyPost * _Nullable ) createPostWithDate:(NSDate *)date title:(NSString *)title hasAttachments:(BOOL)attachments error:(NSError **)error
{
    if (error) {
        *error = [NSError errorWithDomain:HyPostsCollectionErrorDomain code:HyPostExistsError userInfo:@{}];
    }
    return nil;
}
@end
