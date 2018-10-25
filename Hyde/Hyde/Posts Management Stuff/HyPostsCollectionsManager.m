//
//  HyPostManager.m
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import "HyPostsCollectionsManager.h"

#import "HyPostsCollection+Internal.h"

static NSString *HyPostLocationsUserDefault = @"PostLocations";

@interface HyPostsCollectionsManager()
@property(nonatomic, readonly, strong) NSMutableDictionary *postsCollectionsByURLDictionary;
@end

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

- (instancetype)init
{
	if (self = [super init]) {
		_postsCollectionsByURLDictionary = [NSMutableDictionary dictionary];
		NSDictionary *registrationDefaults = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"HyRegistrationDefaults"];
		if (registrationDefaults)
			[[NSUserDefaults standardUserDefaults] registerDefaults:registrationDefaults];
		[[NSUserDefaults standardUserDefaults] addObserver:self forKeyPath:HyPostLocationsUserDefault options:0 context:&HyPostLocationsUserDefault];
		[self _recomputePostsCollectionsFromDefaults];
	}
	return self;
}

#pragma mark - Posts Collections Management
- (NSArray<HyPostsCollection *> *)postsCollections
{
	NSArray *postsLocations = _postsCollectionsByURLDictionary.allValues;
	return [postsLocations sortedArrayUsingSelector:@selector(compareURLs:)];
}

- (void)_recomputePostsCollectionsDefault
{
	NSMutableArray *defaultsRepresentation = [NSMutableArray array];
	for(NSURL *url in _postsCollectionsByURLDictionary.allKeys) {
		[defaultsRepresentation addObject: [url absoluteString]];
	}
	[[NSUserDefaults standardUserDefaults] setObject:defaultsRepresentation forKey:HyPostLocationsUserDefault];
}

- (void)_recomputePostsCollectionsFromDefaults
{
	BOOL postsCollectionChanged = NO;
	NSArray *collectionsPaths = [[NSUserDefaults standardUserDefaults] arrayForKey:HyPostLocationsUserDefault];
	NSMutableArray *locationURLs = [NSMutableArray array];
	for(NSString *collectionPath in collectionsPaths)
		[locationURLs addObject: [NSURL URLWithString:collectionPath]];

	NSArray *currentCollectionURLs = _postsCollectionsByURLDictionary.allKeys;

	// remove collections that are no longer saved in defaults
	for(NSURL *currentCollectionURL in currentCollectionURLs) {
		if (![locationURLs containsObject:currentCollectionURL]) {
			[_postsCollectionsByURLDictionary removeObjectForKey:currentCollectionURL];
			postsCollectionChanged = YES;
		}
	}

	// add collections that are in defaults, but not cached
	for(NSURL *defaultURL in locationURLs) {
		if(!_postsCollectionsByURLDictionary[defaultURL]) {
			HyPostsCollection *newPostsCollection = [HyPostsCollection postsCollectionWithContentsOfURL:defaultURL];
			if (newPostsCollection) {
				_postsCollectionsByURLDictionary[defaultURL] = newPostsCollection;
				postsCollectionChanged = YES;
			}
		}
	}

	if (postsCollectionChanged) {
		[self willChangeValueForKey:@"postsCollections"];
		[self didChangeValueForKey:@"postsCollections"];
	}
}

- (void)addPostCollections:(NSArray<NSURL *>*)urls
{
	for(NSURL *url in urls) {
		if (!_postsCollectionsByURLDictionary[url]) {
			HyPostsCollection *postsCollection = [HyPostsCollection postsCollectionWithContentsOfURL:url];
			if (postsCollection) {
				[self willChangeValueForKey:@"postsCollections"];
				_postsCollectionsByURLDictionary[url] = postsCollection;
				[self didChangeValueForKey:@"postsCollections"];
			}
		}
	}

	[self _recomputePostsCollectionsDefault];
}

- (void)removePostsCollections:(NSArray<HyPostsCollection *>*)postsCollections
{
	[self willChangeValueForKey:@"postsCollections"];
	for(HyPostsCollection *postsCollection in postsCollections) {
		NSURL *postsCollectionURL = postsCollection.URL;
		[_postsCollectionsByURLDictionary removeObjectForKey:postsCollectionURL];
	}
	[self didChangeValueForKey:@"postsCollections"];
	[self _recomputePostsCollectionsDefault];
}


#pragma mark - KVO / Defaults changed handler(s)
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
	if (context == &HyPostLocationsUserDefault) {
		// for internal changes, this gets called ~3 times for every single change.  No change details provided.
		[self _recomputePostsCollectionsFromDefaults];
	} else {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}
@end
