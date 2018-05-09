//
//  MovieCell.m
//  racMVVM
//
//  Created by ljkj on 2018/5/9.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "MovieCell.h"

@interface MovieCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UILabel *labPoint;

@end

@implementation MovieCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initSubViewUI];
    }
    return self;
}

- (void)initSubViewUI
{
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.left.top.equalTo(imageView.superview);
        make.height.equalTo(imageView.mas_width);
    }];
    self.imageView = imageView;
    
    
    UILabel *labTitle = [[UILabel alloc]init];
    labTitle.textAlignment = NSTextAlignmentCenter;
    labTitle.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:labTitle];
    self.labTitle = labTitle;
    [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(imageView);
        make.top.equalTo(imageView.mas_bottom);
        make.bottom.equalTo(self.contentView);
    }];
    
    UILabel *labPoint = [[UILabel alloc]init];
    labPoint.textAlignment = NSTextAlignmentCenter;
    labPoint.backgroundColor = [UIColor whiteColor];
    [imageView addSubview:labPoint];
    self.labPoint = labPoint;
    [labPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(imageView);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    
    
    
}

//划入屏幕内会调用
- (void)prepareForReuse
{
    self.imageView.image = nil;
    self.labPoint.text = @"";
    self.labPoint.text = @"";
}

- (void)setMovieModel:(MovieModel *)movieModel
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:movieModel.images.large]];
    self.labTitle.text = movieModel.title;
    self.labPoint.text = movieModel.rating.average;
}

+ (NSString *)cellReuseIdentifier
{
    return NSStringFromClass(self);
}

@end
