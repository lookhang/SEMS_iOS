//
//  SEMS_NodeObject.m
//  SEMS_iOS
//
//  Created by Fantasy on 14-6-23.
//  Copyright (c) 2014年 Fantasy. All rights reserved.
//

#import "SEMS_NodeObject.h"

@implementation SEMS_NodeObject
-(id)initWithName:(NSString *)name id:(NSUInteger)id children:(NSArray *)array{
    self = [super initWithName:name children:array];
    if (self) {
        self.id = id;
    }
    return self;
}


+ (id)dataObjectWithName:(NSString *)name id:(NSUInteger)id children:(NSArray *)children{
    return [[self alloc] initWithName:name id:id children:children];
}
@end
