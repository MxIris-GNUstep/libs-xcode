#import <Foundation/Foundation.h>

// Local includes
#import "PBXCoder.h"
#import "PBXNativeTarget.h"

@interface PBXAbstractBuildPhase : NSObject
{
  NSMutableArray *files;
  NSString *buildActionMask;
  NSString *runOnlyForDeploymentPostprocessing;
  BOOL showEnvVarsInLog;
  PBXNativeTarget *target;
}

// Methods....
- (NSMutableArray *) files; // getter
- (void) setFiles: (NSMutableArray *)object; // setter
- (NSString *) buildActionMask; // getter
- (void) setBuildActionMask: (NSString *)object; // setter
- (NSString *) runOnlyForDeploymentPostprocessing; // getter
- (void) setRunOnlyForDeploymentPostprocessing: (NSString *)object; // setter
- (BOOL) showEnvVarsInLog; // setter
- (void) setEnvVarsInLog: (BOOL)flag;
- (void) setTarget: (PBXNativeTarget *)t;

// build
- (BOOL) build;
@end
