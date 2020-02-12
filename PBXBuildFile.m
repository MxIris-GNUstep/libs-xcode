#import "PBXCommon.h"
#import "PBXBuildFile.h"

@implementation PBXBuildFile

// Methods....
- (PBXFileReference *) fileRef // getter
{
  return fileRef;
}

- (void) setFileRef: (PBXFileReference *)object; // setter
{
  ASSIGN(fileRef,object);
}

- (NSMutableDictionary *) settings // getter
{
  return settings;
}

- (void) setSettings: (NSMutableDictionary *)object; // setter
{
  ASSIGN(settings,object);
}

- (void) applySettings
{
  // NSLog(@"%@",settings);
}

- (NSString *) buildPath
{
  return [fileRef buildPath];
}

- (BOOL) build
{
  [self applySettings];
  NSLog(@"\t* Building %@",[fileRef path]);
  return [fileRef build];
}

- (NSString *) description
{
  NSString *s = [super description];
  return [s stringByAppendingFormat: @" <%@>", fileRef]; 
}

@end
