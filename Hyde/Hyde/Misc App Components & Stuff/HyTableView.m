//
//  HyTableVidew.m
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import "HyTableView.h"

@implementation HyTableView
- (void)keyDown:(NSEvent *)theEvent {
    // http://www.corbinstreehouse.com/blog/2014/04/implementing-delete-in-an-nstableview/
    unichar key = [[theEvent charactersIgnoringModifiers] characterAtIndex:0];
    if (key == NSDeleteCharacter && self.selectedRow != -1) {
        [NSApp sendAction:@selector(delete:) to:nil from:self];
    } else {
        [super keyDown:theEvent];
    }
}
@end
