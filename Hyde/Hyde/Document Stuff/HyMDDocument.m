//
//  Document.m
//  Hyde
//
//  Created by William Bumgarner on 10/14/18.
//  Copyright © 2018 Bill Bumgarner. All rights reserved.
//

#import "HyMDDocument.h"
#import "HyDocumentCreatorWindowController.h"

@interface HyMDDocument ()
@property(nonatomic, readwrite, assign) BOOL isNewDocument;
@property(nonatomic, readwrite, strong) HyDocumentCreatorWindowController *documentCreatorWindowController;
@end

@implementation HyMDDocument

- (instancetype)init {
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

- (nullable instancetype)initWithType:(NSString *)typeName error:(NSError **)outError
{
    if (self = [super initWithType:typeName error:outError]) {
        _isNewDocument = YES;
    }
    
    return self;
}

+ (BOOL)autosavesInPlace {
    return YES;
}

- (NSString *)windowNibName {
    return @"HyMDDocument";
}

- (void)windowDidBecomeKey:(NSNotification *)notification;
{
    if (_isNewDocument) {
        _documentCreatorWindowController = [HyDocumentCreatorWindowController documentCreatorWindowController];
        _isNewDocument = NO;
        [self.windowForSheet beginSheet:_documentCreatorWindowController.window completionHandler:^(NSModalResponse returnCode) {
            os_log_info(HyDefaultLog(), "%s %ld", __PRETTY_FUNCTION__, (long)returnCode);
            if (returnCode != NSModalResponseOK) {
                [self close];
            }
        }];
    }
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    return nil;
}


- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    return YES;
}


@end
