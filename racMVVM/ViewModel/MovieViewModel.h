//
//  MovieViewModel.h
//  racMVVM
//
//  Created by ljkj on 2018/5/9.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieViewModel : NSObject

@property (nonatomic, strong) RACCommand *requestCommand;

@end
