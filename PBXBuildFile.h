#import <Foundation/Foundation.h>

// Local includes
#import "PBXCoder.h"
#import "PBXFileReference.h"

@interface PBXBuildFile : NSObject
{
  PBXFileReference *fileRef;
  NSMutableDictionary *settings;
}

// Methods....
- (PBXFileReference *) fileRef; // getter
- (void) setFileRef: (PBXFileReference *)object; // setter
- (NSMutableDictionary *) settings; // getter
- (void) setSettings: (NSMutableDictionary *)object; // setter

- (NSString *) path;
- (NSString *) buildPath;
- (BOOL) build;

@end
