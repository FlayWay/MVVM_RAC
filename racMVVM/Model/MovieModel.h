//
//  MovieModel.h
//  racMVVM
//
//  Created by ljkj on 2018/5/9.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RatingModel.h"
#import "ImagesModel.h"

@interface MovieModel : NSObject

//电影名
@property (nonatomic,copy) NSString *title;
//剧照
@property (nonatomic,strong) ImagesModel *images;
//排名信息
@property (nonatomic,strong) RatingModel *rating;

@end
