//
//  HyConfigurationManager.m
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import "HyConfigurationManager.h"

static NSString *HyPostLocationsUserDefault = @"PostLocations";

NSString *HyPostLocationsDidChangeNotificationName = @"Post Locations Did Change";

@interface HyConfigurationManager()
@property(readwrite, nonatomic) NSArray<NSURL *>*postLocationsDefaultCache;
@end

@implementation HyConfigurationManager
+ (HyConfigurationManager *) sharedConfigurationManager
{
    static HyConfigurationManager *hyConfigurationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hyConfigurationManager = [[HyConfigurationManager alloc] init];
    });
    return hyConfigurationManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        NSDictionary *registrationDefaults = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"HyRegistrationDefaults"];
        if (registrationDefaults)
            [[NSUserDefaults standardUserDefaults] registerDefaults:registrationDefaults];
        [[NSUserDefaults standardUserDefaults] addObserver:self forKeyPath:HyPostLocationsUserDefault options:0 context:&HyPostLocationsUserDefault];
    }
    return self;
}

#pragma mark - @property(readwrite, atomic) NSArray<NSURL *>* postLocations
- (NSArray<NSURL *> *)postLocations
{
    if (!_postLocationsDefaultCache) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSArray *postLocations = [userDefaults arrayForKey:HyPostLocationsUserDefault];
        NSMutableArray<NSURL *> *cachedURLArray = [NSMutableArray array];
        for(NSString *postLocation in postLocations) {
            [cachedURLArray addObject: [NSURL URLWithString:postLocation]];
        }
        _postLocationsDefaultCache = [cachedURLArray copy];
    }
    return _postLocationsDefaultCache;
}

- (void)setPostLocations:(NSArray<NSURL *> *)postLocations
{
    _postLocationsDefaultCache = [postLocations copy];
    NSMutableArray<NSString *>*locationURLsAsStrings = [NSMutableArray array];
    for(NSURL *location in postLocations) {
        [locationURLsAsStrings addObject:location.absoluteString];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:locationURLsAsStrings forKey:HyPostLocationsUserDefault];

    [[NSNotificationCenter defaultCenter] postNotificationName:HyPostLocationsDidChangeNotificationName object:self];
}

- (void)addPostLocationsIfAbsent:(NSArray<NSURL *> *)locations
{
    NSMutableArray *newLocations = [NSMutableArray arrayWithArray:self.postLocations];
    for(NSURL *location in locations)
        if(![newLocations containsObject:location])
            [newLocations addObject:location];
    
    if (newLocations.count != self.postLocations.count)
        self.postLocations = newLocations;
}

#pragma mark - KVO / Defaults changed handler(s)
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == &HyPostLocationsUserDefault) {
        // for internal changes, this gets called ~3 times for every single change.  No change details provided.
        [[NSNotificationCenter defaultCenter] postNotificationName:HyPostLocationsDidChangeNotificationName object:self];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
@end
