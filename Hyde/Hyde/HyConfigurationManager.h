//
//  HyConfigurationManager.h
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import <Foundation/Foundation.h>

// observers must be prepared to deal w/multiple notifications in regards to same change
extern NSString *HyPostLocationsDidChangeNotificationName;

@interface HyConfigurationManager : NSObject
+ (HyConfigurationManager *) sharedConfigurationManager;

@property(copy, atomic) NSArray<NSURL *>* postLocations;
- (void)addPostLocationsIfAbsent:(NSArray <NSURL *>*)locations;
@end
