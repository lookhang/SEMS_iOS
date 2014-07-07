//
//  SEMS_Util.h
//  SEMS_iOS
//
//  Created by Fantasy on 14-6-25.
//  Copyright (c) 2014年 Fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SEMS_Util : NSObject

+(void)httpPOST:(NSString *)URLString
           withParameters:(NSDictionary *)parameters
                   result:(void(^)(NSDictionary * ressultDic))result;
@end
