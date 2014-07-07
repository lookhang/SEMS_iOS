//
//  SEMS_Util.m
//  SEMS_iOS
//
//  Created by Fantasy on 14-6-25.
//  Copyright (c) 2014年 Fantasy. All rights reserved.
//

#import "SEMS_Util.h"
#import "AFNetworking.h"
#import "DDLog.h"

@implementation SEMS_Util
//收发JSON数据
+(void)httpPOST:(NSString *)URLString withParameters:(NSDictionary *)parameters result:(void(^)(NSDictionary * ressultDic))result{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:URLString parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              DDLogInfo(@"JSON: %@", operation.responseString);
              //NSLog(@"JSON: %@", responseObject);
              if (operation.responseString) {

                  NSString *requestTmp = [NSString stringWithString:operation.responseString];
                  NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
                  //系统自带JSON解析
                  result([NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil]);
              }else{
                  result(nil);
              }
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              //NSLog(@"Error: %@", operation.responseString);
              if (operation) {
                  DDLogInfo(@"Error: %@", error);
                  result(@{@"result":@"0",@"msg":error.description});
              }else{
                  result(nil);
              }
              
          }];
    
}
@end
