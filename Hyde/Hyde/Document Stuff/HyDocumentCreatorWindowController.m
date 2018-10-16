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

@implementation HyDocumentCreatorWindowController
+ (instancetype)documentCreatorWindowController
{
    return [[HyDocumentCreatorWindowController alloc] initWithWindowNibName:@"HyDocumentCreator"];
}

- (void)windowDidLoad;
{
    _postDatePicker.dateValue = [NSDate date];
    _createButton.enabled = NO;
    
    [self _reloadCollectionPopup];
}

- (void)_reloadCollectionPopup
{
    [_collectionPopup removeAllItems];
    NSArray<NSURL *>* collectionURLs = [[HyConfigurationManager sharedConfigurationManager] postLocations];
    for(NSURL *postLocationURL in collectionURLs) {
        NSURL *trimmedURL;
        NSString *lastPathComponent = postLocationURL.lastPathComponent;
        trimmedURL = postLocationURL.URLByDeletingLastPathComponent;
        NSString *secondToLastPathComponent = trimmedURL.lastPathComponent;
        
        NSString *pathFragment = [secondToLastPathComponent stringByAppendingPathComponent:lastPathComponent];
        [_collectionPopup addItemWithTitle:pathFragment];
    }
    [_collectionPopup selectItemAtIndex:0];
}

- (IBAction)cancel:(id)sender
{
    [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseCancel];
}

- (IBAction)create:(id)sender {
    
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
@end
