//
//  LDHHTTPSessionManager.m
//  LDHMoonAngel
//
//  Created by Daredos on 16/3/20.
//  Copyright © 2016年 LiangDaHong. All rights reserved.
//

#import "LDHHTTPSessionManager.h"
#import "AFNetworking.h"

#define fUNC_NIL_BLOCK(block,blocks)  \
            if (block) {              \
                blocks;               \
            }                         \

@interface LDHHTTPSessionManager ()

@property (strong, nonatomic) NSMutableArray <NSDictionary<NSString *,NSURLSessionDataTask *> *> *networkingManagerArray;

@property (strong, nonatomic) AFHTTPSessionManager *mager;

@end

@implementation LDHHTTPSessionManager

#pragma mark -

#pragma mark -

- (instancetype)init {
    
    if (self = [super init]) {
        _networkingManagerArray = [NSMutableArray array];
        
        self.mager = (kBASE_URL.length > 0) ?  [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBASE_URL]] : [[AFHTTPSessionManager alloc] init];
        
        AFHTTPRequestSerializer *requestSerializerNotCache = [AFHTTPRequestSerializer serializer];
        requestSerializerNotCache.timeoutInterval = kTimeoutInterval;
        self.mager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

+ (instancetype)shareedHTTPSessionManager {
    
    static  LDHHTTPSessionManager *sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sessionManager == nil) {
            sessionManager  = [[[self class] alloc] init];
        }
    });
    return sessionManager;
}

#pragma mark - get

- (void)get:(NSString *)urlString parameters:(id)parameters netIdentifier:(NSString *)netIdentifier success:(LDHSuccessBlock)successBlock failure:(LDHFailureBlock)failureBlock {
    
    AFHTTPSessionManager *sessionManager = [self getManagerWithWithPath:urlString parameters:parameters netIdentifier:netIdentifier progress:nil success:successBlock failure:failureBlock ];
    
    if (!sessionManager) {
        
        return;
    }
    
    NSURLSessionDataTask *task = [sessionManager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
    if (netIdentifier) {
        [self.networkingManagerArray addObject:@{netIdentifier:task}];
    }
}

- (void)get:(NSString *)urlString parameters:(id)parameter netIdentifier:(NSString *)netIdentifier progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock success:(void (^)(id responseObject))successBlock failure:(void (^)(NSError   *error))failureBlock {
    
    AFHTTPSessionManager *sessionManager = [self getManagerWithWithPath:urlString parameters:parameter netIdentifier:netIdentifier progress:nil success:successBlock failure:failureBlock ];
    
    if (!sessionManager) {
        return;
    }
    
    NSURLSessionDataTask *task = [sessionManager GET:urlString parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (downloadProgressBlock) {
            downloadProgressBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    if (netIdentifier) {
        [self.networkingManagerArray addObject:@{netIdentifier:task}];
    }
}

#pragma mark - post

- (void)post:(NSString *)urlString parameters:(id)parameters netIdentifier:(NSString *)netIdentifier success:(LDHSuccessBlock)successBlock failure:(LDHFailureBlock)failureBlock {
    
    AFHTTPSessionManager *sessionManager = [self getManagerWithWithPath:urlString parameters:parameters netIdentifier:netIdentifier progress:nil success:successBlock failure:failureBlock ];
    
    if (!sessionManager) {
        
        return;
    }
    NSURLSessionDataTask *task = [sessionManager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
    if (netIdentifier) {
        [self.networkingManagerArray addObject:@{netIdentifier:task}];
    }
}

- (void)post:(NSString *)urlString parameters:(id)parameters netIdentifier:(NSString *)netIdentifier progress:(LDHDownloadProgressBlock)downloadProgressBlock success:(LDHSuccessBlock)successBlock failure:(LDHFailureBlock)failureBlock {
    
    AFHTTPSessionManager *sessionManager = [self getManagerWithWithPath:urlString parameters:parameters netIdentifier:netIdentifier progress:downloadProgressBlock success:successBlock failure:failureBlock ];
    
    if (!sessionManager) {
        
        return;
    }
    
    NSURLSessionDataTask *task = [sessionManager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (downloadProgressBlock) {
            downloadProgressBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    if (netIdentifier) {
        [self.networkingManagerArray addObject:@{netIdentifier:task}];
    }
}

#pragma mark - cancel

- (void)cancelAllNetworking {
    
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString  *key = [[dict allKeys] firstObject];
        NSURLSessionDataTask *task = dict[key];
        [task cancel];
    }
    [self.networkingManagerArray removeAllObjects];
}

- (void)cancelNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifierArray {
    
    for (NSString *netIdentifier in netIdentifierArray) {
        [self cancelNetworkingWithNetIdentifier:netIdentifier];
    }
}

- (void)cancelNetworkingWithNetIdentifier:(NSString *)netIdentifier {
    if (!netIdentifier) {
        return;
    }
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        if ([key isEqualToString:netIdentifier]) {
            NSURLSessionDataTask *task = dict[key];
            [task cancel];
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
            return;
        }
    }
}

- (NSArray <NSString *>*)getUnderwayNetIdentifierArray {
    
    NSMutableArray *muarr = [NSMutableArray array];
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        [muarr addObject:key];
    }
    return muarr;
}

#pragma mark - suspend

- (void)suspendAllNetworking {
    
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString  *key = [[dict allKeys] firstObject];
        NSURLSessionDataTask *task = dict[key];
        if (task.state == NSURLSessionTaskStateRunning) {
            [task suspend];
        }
    }
}

- (void)suspendNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifierArray {
    
    for (NSString *netIdentifier in netIdentifierArray) {
        [self suspendNetworkingWithNetIdentifier:netIdentifier];
    }
    
}

- (void)suspendNetworkingWithNetIdentifier:(NSString *)netIdentifier {
    
    if (!netIdentifier) {
        return;
    }
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        if ([key isEqualToString:netIdentifier]) {
            NSURLSessionDataTask *task = dict[key];
            [task suspend];
        }
    }
}

- (NSArray<NSString *> *)getSuspendNetIdentifierArray {
    
    NSMutableArray *muarr = [NSMutableArray array];
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        NSURLSessionDataTask *task = dict[key];
        
        if (task.state == NSURLSessionTaskStateSuspended) {
            [muarr addObject:key];
        }
    }
    return muarr;
}

#pragma  mark - resume

- (void)resumeAllNetworking {
    
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString  *key = [[dict allKeys] firstObject];
        NSURLSessionDataTask *task = dict[key];
        if (task.state == NSURLSessionTaskStateSuspended) {
            [task resume];
        }
    }
}

- (void)resumeNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifierArray {
    
    for (NSString *netIdentifier in netIdentifierArray) {
        
        [self resumeNetworkingWithNetIdentifier:netIdentifier];
    }
}

- (void)resumeNetworkingWithNetIdentifier:(NSString *)netIdentifier {
    
    if (!netIdentifier) {
        return;
    }
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        if ([key isEqualToString:netIdentifier]) {
            NSURLSessionDataTask *task = dict[key];
            if (task.state == NSURLSessionTaskStateSuspended) {
                [task resume];
            }
        }
    }
}

#pragma  mark - 私有方法

- (AFHTTPSessionManager *)getManagerWithWithPath:(const NSString *)path
                                      parameters:(id)parameters
                                   netIdentifier:(NSString *)netIdentifier
                                        progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                         success:(void (^)(id responseObject))successBlock
                                         failure:(void (^)(NSError   *error))failureBlock {
    
    // 1.当前的请求是否正在进行
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        if ([key isEqualToString:netIdentifier]) {
            NSLog(@"当前的请求正在进行,拦截请求");
            if (failureBlock) {
                NSError *cancelError = [NSError errorWithDomain:@"请求正在进行!" code:(-12001) userInfo:nil];
                fUNC_NIL_BLOCK(failureBlock , failureBlock(cancelError));
            }
            return nil;
        }
    }
    
    // 2.检测是否有网络
    AFNetworkReachabilityStatus net = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    if ( net == AFNetworkReachabilityStatusNotReachable) {
        NSError *cancelError = [NSError errorWithDomain:@"没有网络,请检测网络!" code:(-12002) userInfo:nil];
        fUNC_NIL_BLOCK(failureBlock , failureBlock(cancelError));
        NSLog(@"没有网络");
        return nil;
    }
    
    return  self.mager;
}

@end
