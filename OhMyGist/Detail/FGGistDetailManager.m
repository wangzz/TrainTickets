//
//  FGGistDetailManager.m
//  OhMyGist
//
//  Created by wangzz on 15/2/1.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGGistDetailManager.h"

@interface FGGistDetailManager ()
{
    RACDisposable   *_detailDisposable;
    RACDisposable   *_commentDisposable;
}

@end

@implementation FGGistDetailManager

- (void)fetchDetailWithGist:(OCTGist *)gist completionBlock:(completionBlock)completionBlock
{
    _detailDisposable = [[[[[FGAccountManager defaultManager] client] fetchDetailWithGist:gist] deliverOn:RACScheduler.mainThreadScheduler]subscribeNext:^(id x) {
        _detailDisposable = nil;
        completionBlock(x,nil);
    } error:^(NSError *error) {
        _detailDisposable = nil;
        completionBlock(nil,[FGError errorWith:error]);
    }];
}

- (void)fetchCommentsWithGist:(OCTGist *)gist completionBlock:(completionBlock)completionBlock
{
    _commentDisposable = [[[[[[FGAccountManager defaultManager] client] fetchCommentsWithGist:gist] collect] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(id x) {
        _commentDisposable = nil;
        completionBlock(x,nil);
    } error:^(NSError *error) {
        _commentDisposable = nil;
        completionBlock(nil,[FGError errorWith:error]);
    }];
}

- (void)cancelRequest
{
    [_detailDisposable dispose];
    [_commentDisposable dispose];
}

@end
