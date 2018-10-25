//
//  HyPreferencesWindowController.m
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import "HyPreferencesWindowController.h"

static void *_HyPrefsPostsLocationObservationContext = &_HyPrefsPostsLocationObservationContext;

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

    HyPostsCollectionsManager *postsCollectionManager = [HyPostsCollectionsManager sharedPostManager];
	[postsCollectionManager addObserver:self forKeyPath:HyValidatedKeyPath(postsCollectionManager, postsCollections) options:0 context:_HyPrefsPostsLocationObservationContext];
}

- (void)dealloc
{
    HyPostsCollectionsManager *postsCollectionManager = [HyPostsCollectionsManager sharedPostManager];
    [postsCollectionManager removeObserver:self forKeyPath:HyValidatedKeyPath(postsCollectionManager, postsCollections) context:_HyPrefsPostsLocationObservationContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
	if (context == &_HyPrefsPostsLocationObservationContext)
		[self.postLocationsTableView reloadData];
	else
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
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
        [[HyPostsCollectionsManager sharedPostManager] addPostCollections:openPanel.URLs];
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

	NSArray<HyPostsCollection *>* postsCollections = [[HyPostsCollectionsManager sharedPostManager] postsCollections];
	NSArray<HyPostsCollection *>* collectionsToRemove = [postsCollections objectsAtIndexes:selectedRowIndexes];
	[[HyPostsCollectionsManager sharedPostManager] removePostsCollections:collectionsToRemove];
}

- (IBAction)delete:sender
{
    if ([sender isEqual:self.postLocationsTableView])
        [self _deleteSelectedPostLocations];
}

#pragma mark - NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [[[HyPostsCollectionsManager sharedPostManager] postsCollections] count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    HyPostsCollection *postCollection = [[[HyPostsCollectionsManager sharedPostManager] postsCollections] objectAtIndex:row];
    return postCollection.stringValueForDisplay;
}
@end

