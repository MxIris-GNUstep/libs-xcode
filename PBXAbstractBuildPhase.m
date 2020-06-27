#import "PBXCommon.h"
#import "PBXAbstractBuildPhase.h"

@implementation PBXAbstractBuildPhase

// Methods....
- (NSMutableArray *) files // getter
{
  return files;
}

- (void) setFiles: (NSMutableArray *)object; // setter
{
  ASSIGN(files,object);
}

- (NSString *) buildActionMask // getter
{
  return buildActionMask;
}

- (void) setBuildActionMask: (NSString *)object; // setter
{
  ASSIGN(buildActionMask,object);
}

- (NSString *) runOnlyForDeploymentPostprocessing // getter
{
  return runOnlyForDeploymentPostprocessing;
}

- (void) setRunOnlyForDeploymentPostprocessing: (NSString *)object; // setter
{
  ASSIGN(runOnlyForDeploymentPostprocessing,object);
}

- (BOOL) showEnvVarsInLog; // setter
{
  return showEnvVarsInLog;
}

- (void) setEnvVarsInLog: (BOOL)flag
{
  showEnvVarsInLog = flag;
}

- (void) setTarget: (PBXNativeTarget *)t
{
  ASSIGN(target, t);
}

- (BOOL) build
{
  NSDebugLog(@"Executing... %@",self);
  return YES;
}
@end
