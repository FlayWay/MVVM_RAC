//
//  MovieViewModel.m
//  racMVVM
//
//  Created by ljkj on 2018/5/9.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "MovieViewModel.h"
#import <AVFoundation/AVFoundation.h>
#import "MovieModel.h"

#define url @"https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC&start=0&count=100&client=&udid="

@implementation MovieViewModel

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initViewModel];
    }
    return self;
}

- (void)initViewModel
{
    @weakify(self);
    _requestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        @strongify(self);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [self getDouBanList:^(NSArray *array) {
                
                [subscriber sendNext:array];
                [subscriber sendCompleted];
                
            }];
            return nil;
        }];
        
    }];
}


- (void)getDouBanList:(void(^)(NSArray *))succeedBlock
{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];

    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

       NSArray *arr = [MovieModel mj_objectArrayWithKeyValuesArray:responseObject[@"subjects"]];
        succeedBlock(arr);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    
}

@end
