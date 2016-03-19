//
//  ViewController.m
//  LDHWorkingAF
//
//  Created by Daredos on 16/3/20.
//  Copyright © 2016年 LiangDaHong. All rights reserved.
//

#import "ViewController.h"
#import "LDHHTTPSessionManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#define url @"http://litchiapi.jstv.com/api/GetFeeds?column=0&PageSize=1000&pageIndex=1&val=100511D3BE5301280E0992C73A9DEC41"

- (IBAction)startHttp:(id)sender {
    
    
    [[LDHHTTPSessionManager shareedHTTPSessionManager] get:url parameters:nil netIdentifier:@"BMCustomerPickupInputPickupCodeViewController" progress:^(NSProgress *downloadProgress) {
        NSLog(@"进度 - %@",downloadProgress);
    } success:^(id responseObject) {
        NSLog(@"responseObject = 下载成功");
    } failure:^(NSError *error) {
        if (error.code == -999) {
            NSLog(@"请求取消");
        }else{
            NSLog(@"请求失败");
        }
    }];
}

- (IBAction)cancelHttp:(id)sender {
    
    [[LDHHTTPSessionManager shareedHTTPSessionManager] cancelNetworkingWithNetIdentifier:@"BMCustomerPickupInputPickupCodeViewController"];
}

- (IBAction)suspendAllNetworking:(id)sender {
    
    [[LDHHTTPSessionManager shareedHTTPSessionManager] suspendAllNetworking];
}

- (IBAction)resumeAllNetworking:(id)sender {
    
    [[LDHHTTPSessionManager shareedHTTPSessionManager] resumeAllNetworking];
}

@end
