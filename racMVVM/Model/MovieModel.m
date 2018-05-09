//
//  MovieModel.m
//  racMVVM
//
//  Created by ljkj on 2018/5/9.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "MovieModel.h"

@implementation MovieModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"images":[ImagesModel class],
             @"rating":[RatingModel class]
             };
}

@end
