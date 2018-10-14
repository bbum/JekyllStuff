//
//  HyDocumentController.h
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HyDocumentController : NSDocumentController
- (IBAction)newFilePost:(nullable id)sender;
- (IBAction)newDirectoryPost:(nullable id)sender;
@end
