//
//  HyPreferencesWindowController.m
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import "HyPreferencesWindowController.h"

@interface HyPreferencesWindowController () <NSTableViewDataSource, NSTableViewDelegate>
@property (weak) IBOutlet NSTableView *postLocationsTableView;

@end

@implementation HyPreferencesWindowController
+ (HyPreferencesWindowController *) sharedHyPreferencesWindowController
{
    static HyPreferencesWindowController *hyPreferencesWindowController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hyPreferencesWindowController = [[HyPreferencesWindowController alloc] initWithWindowNibName:@"HyPreferences"];
    });
    return hyPreferencesWindowController;
}

- (void)windowDidLoad {
    [super windowDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postLocationsDidChangeNotification:) name:HyPostLocationsDidChangeNotificationName object:nil];
}

- (void)postLocationsDidChangeNotification:(NSNotification *)notification
{
    [self.postLocationsTableView reloadData];
}

- (IBAction)addPostLocationAction:(id)sender
{
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    openPanel.canChooseFiles = NO;
    openPanel.canChooseDirectories = YES;
    openPanel.allowsMultipleSelection = YES;
    openPanel.canCreateDirectories = YES;
    openPanel.prompt = NSLocalizedString(@"LOC_PREF_OPEN_PANEL_BUTTON_TITLE", @"open panel action button name.");
    [openPanel beginSheetModalForWindow:self.window completionHandler:^(NSModalResponse result) {
        if (result != NSModalResponseOK)
            return;
        [[HyConfigurationManager sharedConfigurationManager] addPostLocationsIfAbsent:openPanel.URLs];
    }];
}

- (IBAction)deletePostLocationAction:(id)sender
{
    [self _deleteSelectedPostLocations];
}

- (void)_deleteSelectedPostLocations
{
    NSIndexSet *selectedRowIndexes = self.postLocationsTableView.selectedRowIndexes;
    if (!selectedRowIndexes.count)
        return;
    
    NSMutableArray *newPostLocations = [[[HyConfigurationManager sharedConfigurationManager] postLocations] mutableCopy];
    [selectedRowIndexes enumerateIndexesWithOptions:NSEnumerationReverse usingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [newPostLocations removeObjectAtIndex:idx];
    }];
    
    [[HyConfigurationManager sharedConfigurationManager] setPostLocations:newPostLocations];
}

- (IBAction)delete:sender
{
    if ([sender isEqual:self.postLocationsTableView])
        [self _deleteSelectedPostLocations];
}

#pragma mark - NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [[[HyConfigurationManager sharedConfigurationManager] postLocations] count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSURL *value = [[[HyConfigurationManager sharedConfigurationManager] postLocations] objectAtIndex:row];
    return value.path;
}
@end
