//
//  HyUtilities.h
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <os/log.h>

extern os_log_t _Nonnull HyDefaultLog(void);

#define HyValidatedKeyPath(object, keyPathAsBareString) ((1) ? @#keyPathAsBareString : ((object).keyPathAsBareString, @"mmm... compiler trickery"))

