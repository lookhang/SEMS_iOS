//
//  SEMS_Common.h
//  SEMS_iOS
//
//  Created by Fantasy on 14-6-26.
//  Copyright (c) 2014年 Fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDLog.h"

#define DEBUGMODE

#ifdef DEBUGMODE
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_OFF;
#endif
@interface SEMS_Common : NSObject

@end
