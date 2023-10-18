/* AppDelegate.m
 *
 * Copyright (C) 2023 Free Software Foundation, Inc.
 *
 * Author:	Gregory John Casamento <greg.casamento@gmail.com>
 * Date:	2023
 *
 * This file is part of GNUstep.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02111
 * USA.
 */

#import <Foundation/Foundation.h>

#import <XCode/PBXCoder.h>
#import <XCode/PBXContainer.h>
#import <XCode/NSString+PBXAdditions.h>
#import <XCode/XCWorkspaceParser.h>
#import <XCode/XCWorkspace.h>

#import "ToolDelegate.h"
#import "ArgPair.h"

NSString *findProjectFilename(NSArray *projectDirEntries)
{
  NSEnumerator *e = [projectDirEntries objectEnumerator];
  NSString     *fileName;

  while ((fileName = [e nextObject]))
    {
      NSRange range = [fileName rangeOfString:@"._"];
      if ([[fileName pathExtension] isEqual: @"xcodeproj"] && range.location == NSNotFound)
	{
	  return [fileName stringByAppendingPathComponent: @"project.pbxproj"];
	}
    }

  return nil;
}

NSString *findWorkspaceFilename(NSArray *projectDirEntries)
{
  NSEnumerator *e = [projectDirEntries objectEnumerator];
  NSString     *fileName;

  while ((fileName = [e nextObject]))
    {
      NSRange range = [fileName rangeOfString:@"._"];
      if ([[fileName pathExtension] isEqual: @"xcworkspace"] && range.location == NSNotFound)
	{
	  return [fileName stringByAppendingPathComponent: @"contents.xcworkspacedata"];
	}
    }

  return nil;
}

NSString *resolveProjectName(BOOL *isProject)
{
  NSString      *fileName = nil;
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSString      *projectDir = [fileManager currentDirectoryPath];
  NSArray       *projectDirEntries = [fileManager directoryContentsAtPath: projectDir];

  fileName = findWorkspaceFilename(projectDirEntries);
  if (fileName != nil)
    {
      *isProject = NO;
    }
  else
    {
      *isProject = YES;
      fileName = findProjectFilename(projectDirEntries);
    }

  return fileName;
}

// AppDelegate...
@implementation ToolDelegate

- (NSDictionary *) parseArguments
{
  NSMutableDictionary *result = [NSMutableDictionary dictionary];
  NSProcessInfo *pi = [NSProcessInfo processInfo];
  NSMutableArray *args = [NSMutableArray arrayWithArray: [pi arguments]];
  // BOOL filenameIsLastObject = NO;
  // NSString *file = nil;  
  NSEnumerator *en = [args objectEnumerator];
  id obj = nil;
  BOOL parse_val = NO;
  ArgPair *pair = AUTORELEASE([[ArgPair alloc] init]);
  
  while ((obj = [en nextObject]) != nil)
    {
      if (parse_val)
	{
	  [pair setValue: obj];
	  [result setObject: pair forKey: [pair argument]];
	  parse_val = NO;
	  continue;
	}
      else
	{
	  pair = AUTORELEASE([[ArgPair alloc] init]);

	  if ([obj isEqualToString: @"--read"])
	    {
	      [pair setArgument: obj];
	      parse_val = YES;	      
	    }

	  if ([obj isEqualToString: @"build"])
	    {
	      [pair setArgument: obj];
	      parse_val = NO;
	    }

	  if ([obj isEqualToString: @"install"])
	    {
	      [pair setArgument: obj];
	      parse_val = NO;
	    }

	  if ([obj isEqualToString: @"clean"])
	    {
	      [pair setArgument: obj];
	      parse_val = NO;
	    }

	  if ([obj isEqualToString: @"generate"])
	    {
	      [pair setArgument: obj];
	      parse_val = NO;
	    }

	  if ([obj isEqualToString: @"link"])
	    {
	      [pair setArgument: obj];
	      parse_val = NO;
	    }

	  // If there is no parameter for the argument, set it anyway...
	  if (parse_val == NO)
	    {
	      [result setObject: pair forKey: obj];
	    }
	}
    }

  return result;
}

- (void) process
{
  NSString *file = nil;
  NSString *fileName = nil;
  NSDictionary *args = [self parseArguments];
  ArgPair *opt = nil;
  BOOL isProject = NO;
  NSString *parameter = @"Makefile";
  
  NSDebugLog(@"args = %@", args);
  NSDebugLog(@"file = %@", file);
  
  // Get the file to write out to...
  NSString *outputFile = nil;
  
  opt = [args objectForKey: @"--read"];
  if (opt != nil)
    {
      file = [opt value];
    }

  if (file != nil)
    {
      NSString *ext = [file pathExtension];
      
      if ([ext isEqualToString: @"xcworkspace"])
	{
	  isProject = NO;
	  fileName = file;
	} 
      else if ([ext isEqualToString: @"xcodeproj"])
	{
	  isProject = YES;
	  fileName = file;
	}
      
      if (fileName != nil)
	{
	  fileName = [fileName stringByAppendingPathComponent: 
				 @"project.pbxproj"];
	}
      else
	{
	  fileName = resolveProjectName(&isProject);
	}	  
    }
  else
    {
      fileName = resolveProjectName(&isProject);
    }

  opt = [args objectForKey: @"--write"];
  if (opt != nil)
    {
      outputFile = [opt value];
    }
  
  NSString *function = nil;
  
  // Get the current function...
  opt = [args objectForKey: @"build"];
  if (opt != nil)
    {
      function = @"build";
    }
  
  opt = [args objectForKey: @"install"];
  if (opt != nil)
    {
      function = @"install";
    }
  
  opt = [args objectForKey: @"clean"];
  if (opt != nil)
    {
      function = @"clean";
    }
  
  opt = [args objectForKey: @"generate"];
  if (opt != nil)
    {
      function = @"generate";
    }
  
  opt = [args objectForKey: @"link"];
  if (opt != nil)
    {
      function = @"link";
    }
  
  // if no function is specified, build is the default...
  if (function == nil)
    {
      function = @"build";
    }
  
  // Execute..
  if (function != nil)
    {
      PBXCoder *coder = nil;
      PBXContainer *container = nil;	  
      
      NS_DURING
	{
	  NSString *display = [function stringByCapitalizingFirstCharacter];
	  SEL operation = NSSelectorFromString(function);
	  
	  if (fileName == nil)
	    {
	      fileName = resolveProjectName(&isProject);
	    }
	  
	  if (isProject)
	    {
	      // Unarchive...
	      coder = [[PBXCoder alloc] initWithContentsOfFile: fileName];
	      container = [coder unarchive];
	      [container setParameter: parameter];
	      
	      // Build...
	      if ([container respondsToSelector: operation])
		{        
		  // build...
		  puts([[NSString stringWithFormat: @"\033[1;32m**\033[0m Start operation %@", display] cString]); 
		  if ([container performSelector: operation])
		    {
		      puts([[NSString stringWithFormat: @"\033[1;32m**\033[0m %@ Succeeded", display] cString]);
		    }
		  else
		    {
		      puts([[NSString stringWithFormat: @"\033[1;31m**\033[0m %@ Failed", display] cString]);
		    }
		}
	      else
		{
		  puts([[NSString stringWithFormat: @"Unknown build operation \"%@\" for %@", display, container] cString]);
		}
	    }
	  else
	    {
	      XCWorkspaceParser *p = [XCWorkspaceParser parseWorkspaceFile: fileName];
	      XCWorkspace *w = [p workspace];
	      
	      if ([w respondsToSelector: operation])
		{
		  [w performSelector: operation];
		}
	    }
	}
      NS_HANDLER
	{
	  NSLog(@"%@", localException);
	}
      NS_ENDHANDLER;
    }      
}

@end