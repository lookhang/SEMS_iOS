//
//  SEMS_NodeObject.h
//  SEMS_iOS
//
//  Created by Fantasy on 14-6-23.
//  Copyright (c) 2014年 Fantasy. All rights reserved.
//

#import "RADataObject.h"

@interface SEMS_NodeObject : RADataObject

@property (nonatomic) NSUInteger id;

-(id)initWithName:(NSString *)name id:(NSUInteger)id children:(NSArray *)array;
+ (id)dataObjectWithName:(NSString *)name id:(NSUInteger)id children:(NSArray *)children;
@end
