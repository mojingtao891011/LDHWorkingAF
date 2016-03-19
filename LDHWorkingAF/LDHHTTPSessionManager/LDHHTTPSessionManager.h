//
//  LDHHTTPSessionManager.h
//  LDHMoonAngel
//
//  Created by Daredos on 16/3/20.
//  Copyright © 2016年 LiangDaHong. All rights reserved.
//

/**
 *  本类是基与 AFN3.0 的(简单)封装 （直观的增加了 取消网络请求，暂停，恢复网络请求）
 *  
 *  感谢你的使用或者查看， 如果有任何问题可 在 Github /QQ 2244784466 联系
 *
 *  会持续更新...
 */

#import <Foundation/Foundation.h>

#define kBASE_URL           @""
#define kTimeoutInterval    10.0f

@interface LDHHTTPSessionManager : NSObject

typedef void(^LDHDownloadProgressBlock)(NSProgress *downloadProgress);
typedef void(^LDHSuccessBlock)         (id responseObject);
typedef void(^LDHFailureBlock)         (NSError   *error);

#pragma mark -

#pragma mark - shareedHTTPSessionManager

+ (instancetype)shareedHTTPSessionManager;

#pragma mark - get

/**
 *  没有进度条的get请求
 *
 *  @param urlString             url
 *  @param parameter             参数
 *  @param netIdentifier         请求标志
 *  @param successBlock          成功
 *  @param failureBlock          失败
 */
- (void)get:(NSString *)urlString parameters:(id)parameters netIdentifier:(NSString *)netIdentifier success:(LDHSuccessBlock)successBlock failure:(LDHFailureBlock)failureBlock;

/**
 *  有进度条的get请求
 *
 *  @param urlString             url
 *  @param parameter             参数
 *  @param netIdentifier         请求标志
 *  @param downloadProgressBlock 进度
 *  @param successBlock          成功
 *  @param failureBlock          失败
 */
- (void)get:(NSString *)urlString parameters:(id)parameter netIdentifier:(NSString *)netIdentifier progress:(LDHDownloadProgressBlock)downloadProgress success:(LDHSuccessBlock)successBlock failure:(LDHFailureBlock)failureBlock;


#pragma mark - post

/**
 *  没有进度条的post请求
 *
 *  @param urlString             url
 *  @param parameter             参数
 *  @param netIdentifier         请求标志
 *  @param successBlock          成功
 *  @param failureBlock          失败
 */
- (void)post:(NSString *)urlString parameters:(id)parameters netIdentifier:(NSString *)netIdentifier success:(LDHSuccessBlock)successBlock failure:(LDHFailureBlock)failureBlock;

/**
 *  有进度条的post请求
 *
 *  @param urlString             url
 *  @param parameter             参数
 *  @param netIdentifier         请求标志
 *  @param downloadProgressBlock 进度
 *  @param successBlock          成功
 *  @param failureBlock          失败
 */
- (void)post:(NSString *)urlString parameters:(id)parameters netIdentifier:(NSString *)netIdentifier progress:(LDHDownloadProgressBlock)downloadProgress success:(LDHSuccessBlock)successBlock failure:(LDHFailureBlock)failureBlock;

#pragma mark - other

#pragma mark - 取消相关

/**
 *  取消所有网络请求
 */
- (void)cancelAllNetworking;
/**
 *  取消一组网络请求
 */
- (void)cancelNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifier;

/**
 *  取消对应的网络请求
 */
- (void)cancelNetworkingWithNetIdentifier:(NSString *)netIdentifier;

/**
 *  获取正在进行的网络请求
 */
- (NSArray <NSString *>*)getUnderwayNetIdentifierArray;

#pragma mark - 暂停相关

/**
 *  暂停所有网络请求
 */
- (void)suspendAllNetworking;

/**
 *  暂停一组网络请求
 */
- (void)suspendNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifierArray;

/**
 *  暂停对应的网络请求
 */
- (void)suspendNetworkingWithNetIdentifier:(NSString *)netIdentifier;

/**
 *  获取正暂停的网络请求
 */
- (NSArray <NSString *>*)getSuspendNetIdentifierArray;


#pragma mark - 恢复相关

/**
 *  恢复所有暂停的网络请求
 */
- (void)resumeAllNetworking;

/**
 *  恢复一组暂停的网络请求
 */
- (void)resumeNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifierArray;

/**
 *  暂停暂停的的网络请求
 */
- (void)resumeNetworkingWithNetIdentifier:(NSString *)netIdentifier;
@end
