//
//  LoginViewController.m
//  SEMS_iOS
//
//  Created by Fantasy on 14-6-20.
//  Copyright (c) 2014年 Fantasy. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;

@end

@implementation LoginViewController
- (IBAction)clickLogin:(UIButton *)sender {
    
    NSString *operationString=@"login";
    NSString * URLString=@"http://192.168.1.23:8080/SEMS/login";
    //NSString * URLString=@"http://192.168.1.23:8080/SEMS/login.do";

    NSDictionary *parameters = @{@"userName": self.userNameLabel.text,@"password": self.passwordLabel.text,@"operation":operationString};
    
    //NSLog(@"parameters: %@",parameters);

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:URLString parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
             //NSLog(@"JSON: %@", operation.responseString);
             //NSLog(@"JSON: %@", responseObject);
              NSString *requestTmp = [NSString stringWithString:operation.responseString];
              NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
              //系统自带JSON解析
              NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
              if ([@"1" isEqualToString:[resultDic objectForKey:@"result"]] && [operationString isEqualToString:[resultDic objectForKey:@"operation"]]) {
                  [self performSegueWithIdentifier:@"goLogin" sender:self];
              }else{
                  [self showMsg:[resultDic objectForKey:@"msg"]];
              }
              NSLog(@"result: %@：%@", [resultDic objectForKey:@"result"],[resultDic objectForKey:@"msg"]);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", operation.responseString);
        NSLog(@"Error: %@", error);
    }];
    
    
}
- (IBAction)backgroundTap:(UIControl *)sender {
    [self.userNameLabel resignFirstResponder];
    [self.passwordLabel resignFirstResponder];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)showMsg:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"关闭"
                                          otherButtonTitles:nil,nil];
    [alert show];
}

@end
