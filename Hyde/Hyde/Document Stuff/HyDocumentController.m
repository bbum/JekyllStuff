//
//  HyDocumentController.m
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import "HyDocumentController.h"
#import "HyUtilities.h"

@implementation HyDocumentController
- (IBAction)newFilePost:(nullable id)sender
{
    os_log_info(HyDefaultLog(), "%s", __PRETTY_FUNCTION__);
}

- (IBAction)newDirectoryPost:(nullable id)sender
{
    os_log_info(HyDefaultLog(), "%s", __PRETTY_FUNCTION__);
}

@end
