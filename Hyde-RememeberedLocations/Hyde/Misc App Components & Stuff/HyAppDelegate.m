//
//  AppDelegate.m
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import "HyAppDelegate.h"
#import "HyDocumentController.h"
#import "HyPreferencesWindowController.h"

@interface HyAppDelegate ()

@end

@implementation HyAppDelegate

- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
    [HyDocumentController sharedDocumentController];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    if ([[[HyPostsCollectionsManager sharedPostManager] postsCollections] count] == 0) {
        [self showPreferences:nil];
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
}

- (IBAction)showPreferences:(nullable id)sender;
{
    [[HyPreferencesWindowController sharedHyPreferencesWindowController] showWindow:nil];
}
@end
