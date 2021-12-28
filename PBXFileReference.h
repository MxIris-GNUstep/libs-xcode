#import <Foundation/Foundation.h>

// Local includes
#import "PBXCoder.h"

@class PBXNativeTarget;

@interface PBXFileReference : NSObject
{
  NSString *sourceTree;
  NSString *lastKnownFileType;
  NSString *path;
  NSString *fileEncoding;
  NSString *explicitFileType;
  NSString *usesTabs;
  NSString *indentWidth;
  NSString *tabWidth;
  NSString *name;
  NSString *includeInIndex;
  NSString *comments;
  NSString *plistStructureDefinitionIdentifier;
  NSString *xcLanguageSpecificationIdentifier;
  NSString *lineEnding;
  NSString *wrapsLines;
  PBXNativeTarget *target;
}

// Methods....
- (NSString *) sourceTree; // getter
- (void) setSourceTree: (NSString *)object; // setter
- (NSString *) lastKnownFileType; // getter
- (void) setLastKnownFileType: (NSString *)object; // setter
- (NSString *) path; // getter
- (void) setPath: (NSString *)object; // setter
- (NSString *) fileEncoding; // getter
- (void) setFileEncoding: (NSString *)object; // setter
- (NSString *) explicitFileType;
- (void) setExplicitFileType: (NSString *)object;
- (NSString *) name;
- (void) setName: (NSString *)object;
- (void) setPlistStructureDefinitionIdentifier: (NSString *)object;
- (NSString *) xcLanguageSpecificationIdentifier;
- (void) setXcLanguageSpecificationIdentifier: (NSString *)object;
- (NSString *) lineEnding;
- (void) setLineEnding: (NSString *)object;
- (void) setTarget: (PBXNativeTarget *)t;
- (void) setWrapsLines: (NSString *)o;

- (NSString *) productName;

// Build methods...
- (NSString *) buildPath;
- (BOOL) build;
- (BOOL) generate;

@end
