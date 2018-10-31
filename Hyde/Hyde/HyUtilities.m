//
//  HyUtilities.m
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import "HyUtilities.h"

os_log_t HyDefaultLog(void)
{
    static os_log_t _HyDefaultLog;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _HyDefaultLog = os_log_create("com.friday.Hyde", "default");
    });
    
    return _HyDefaultLog;
}
