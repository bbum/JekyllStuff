//
//  HyDocumentCreatorWindowController.m
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import "HyDocumentCreatorWindowController.h"

@interface HyDocumentCreatorWindowController () <NSTextFieldDelegate>
@property (weak) IBOutlet NSButton *createButton;
@property (weak) IBOutlet NSTextField *postTitleField;
@property (weak) IBOutlet NSDatePicker *postDatePicker;
@property (weak) IBOutlet NSButton *containsAttachmentCheckbox;

@property (weak) IBOutlet NSPopUpButton *collectionPopup;
@end

static void *HyPostsCollectionObservationToken = &HyPostsCollectionObservationToken;

@implementation HyDocumentCreatorWindowController
+ (instancetype)documentCreatorWindowController
{
    return [[HyDocumentCreatorWindowController alloc] initWithWindowNibName:@"HyDocumentCreator"];
}

- (void)windowDidLoad;
{
    _postDatePicker.dateValue = [NSDate date];
    _createButton.enabled = NO;

    HyPostsCollectionsManager *postsCollectionManager = [HyPostsCollectionsManager sharedPostManager];
	[postsCollectionManager addObserver:self forKeyPath:HyValidatedKeyPath(postsCollectionManager, postsCollections) options:0 context:HyPostsCollectionObservationToken];
    
    [self _reloadCollectionPopup];
}

- (void)dealloc
{
    HyPostsCollectionsManager *postsCollectionManager = [HyPostsCollectionsManager sharedPostManager];
	[postsCollectionManager removeObserver:self forKeyPath:HyValidatedKeyPath(postsCollectionManager, postsCollections) context:HyPostsCollectionObservationToken];
}

- (void)_reloadCollectionPopup
{
    [_collectionPopup removeAllItems];
	NSArray<HyPostsCollection *>* postsCollections = [[HyPostsCollectionsManager sharedPostManager] postsCollections];
	for(HyPostsCollection *postsCollection in postsCollections) {
		NSURL *postsLocationURL = postsCollection.URL;
		NSURL *trimmedURL;
        NSString *lastPathComponent = postsLocationURL.lastPathComponent;
        trimmedURL = postsLocationURL.URLByDeletingLastPathComponent;
        NSString *secondToLastPathComponent = trimmedURL.lastPathComponent;
        
        NSString *pathFragment = [secondToLastPathComponent stringByAppendingPathComponent:lastPathComponent];
        [_collectionPopup addItemWithTitle:pathFragment];
    }
    [_collectionPopup selectItemAtIndex:0];
    [_collectionPopup setNeedsDisplay];
}

- (IBAction)cancel:(id)sender
{
    [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseCancel];
}

- (IBAction)create:(id)sender
{
    
}

#pragma mark - NSTextFieldDelegate
- (void)controlTextDidChange:(NSNotification *)obj
{
    id control = obj.object;
    if ([_postTitleField isEqual: control]) {
        NSString *postTitle = [_postTitleField stringValue];
        _createButton.enabled = [postTitle length] > 0;
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == HyPostsCollectionObservationToken) {
        [self _reloadCollectionPopup];
	} else {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}
@end
