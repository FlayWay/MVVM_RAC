//
//  ViewController.m
//  racMVVM
//
//  Created by ljkj on 2018/5/9.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "ViewController.h"
#import "MovieCell.h"
#import "MovieViewModel.h"


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *listArray;

@property (nonatomic, strong) MovieViewModel *viewModel;
@end

@implementation ViewController

- (MovieViewModel *)viewModel
{
    if (!_viewModel)
    {
        _viewModel = [[MovieViewModel alloc]init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //初始化UI
    [self initSubViewUI];
    
    [self bindMovieViewModel];
}

- (void)initSubViewUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor redColor];
    collectionView.showsVerticalScrollIndicator = YES;
    collectionView.showsHorizontalScrollIndicator = YES;
    collectionView.alwaysBounceVertical = YES;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        NSLog(@"%@",self.view);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    self.collectionView = collectionView;
    [self.collectionView registerClass:[MovieCell class] forCellWithReuseIdentifier:[MovieCell cellReuseIdentifier]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MovieCell cellReuseIdentifier] forIndexPath:indexPath];
    cell.movieModel = self.listArray[indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.listArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(scaledValue(100), scaledValue(120));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 0, 15);
}



- (void)bindMovieViewModel
{
    @weakify(self);
    RACSignal *singal = [self.viewModel.requestCommand execute:nil];
    [singal subscribeNext:^(id  _Nullable x) {
     
        @strongify(self);
        NSLog(@"%@",x);
        self.listArray = x;
        [self.collectionView reloadData];
        
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        [SVProgressHUD dismissWithDelay:1.5];

    }];
    
    [SVProgressHUD showWithStatus:@"加载中..."];

}

@end
