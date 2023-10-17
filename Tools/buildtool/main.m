/* main.m
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

/*
   Project: buildtool

   Author: Gregory John Casamento,,,

   Created: 2011-08-20 11:42:51 -0400 by heron
*/

#import <Foundation/Foundation.h>

#import "ToolDelegate.h"

int main(int argc, const char *argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  extern char **environ;
  
  // Do our stuff...
  ToolDelegate *delegate = AUTORELEASE([[ToolDelegate alloc] init]);

  // Initialize process...
  [NSProcessInfo initializeWithArguments: (char **)argv
				   count: argc
			     environment: environ];

  // Process the arguments...
  [delegate process];
  RELEASE(pool);

  return 0;
}
