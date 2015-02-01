//
//  FGPersonalGistsManager.m
//  OhMyGist
//
//  Created by wangzz on 15/1/31.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGPersonalGistsManager.h"

@interface FGPersonalGistsManager ()
{
    NSUInteger  _page;
    RACDisposable   *_firstPageDisposable;
    RACDisposable   *_nextPageDisposable;
}

@end

@implementation FGPersonalGistsManager

- (void)fetchPersonalGistsFirstPageWithCompletionBlock:(completionBlock)completionBlock
{
    _page = 1;
    _firstPageDisposable = [[[[[FGAccountManager defaultManager] client] fetchPersonalGistsWithPage:_page] collect] subscribeNext:^(id x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _firstPageDisposable = nil;
            completionBlock(x,nil);
        });
    } error:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _firstPageDisposable = nil;
            completionBlock(nil,[FGError errorWith:error]);
        });
    }];
}

- (void)fetchPersonalGistsNextPageWithCompletionBlock:(completionBlock)completionBlock
{
    _page++;
    _nextPageDisposable = [[[[[FGAccountManager defaultManager] client] fetchPersonalGistsWithPage:_page] collect] subscribeNext:^(id x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _nextPageDisposable = nil;
            completionBlock(x,nil);
        });
    } error:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _nextPageDisposable = nil;
            completionBlock(nil,[FGError errorWith:error]);
        });
    }];
}

- (void)cancelRequest
{
    [_firstPageDisposable dispose];
    [_nextPageDisposable dispose];
}

@end
