//
//  ViewController.m
//  42-WSWaterfallLayout(瀑布流)
//
//  Created by XSUNT45 on 16/4/26.
//  Copyright © 2016年 XSUNT45. All rights reserved.
//

#import "ViewController.h"
#import "WSShopCell.h"
#import "MJExtension.h"
#import "WSShop.h"
#import "WSWaterfallLayout.h"
#import "MJRefresh.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WSWaterfallLayoutDelegate>

@property (weak, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *shopsArray;

@end

@implementation ViewController

static NSString *const ID = @"shops";

- (NSMutableArray *)shopsArray {
    if (!_shopsArray) {
        _shopsArray = [[NSMutableArray alloc] init];
        _shopsArray = [WSShop mj_objectArrayWithFilename:@"1.plist"];
    }
    return _shopsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WSWaterfallLayout *layout = [[WSWaterfallLayout alloc] init];
//    layout.columnsCount = 2;
//    layout.columnMargin = 20;
//    layout.rowMargin = 30;
//    layout.sectionInset = UIEdgeInsetsMake(100, 30, 40, 50);
    layout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [collectionView registerNib:[UINib nibWithNibName:@"WSShopCell" bundle:nil] forCellWithReuseIdentifier:ID];
    collectionView.backgroundColor = [UIColor clearColor];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView setMj_footer:[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadMoreShops)]];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.shopsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WSShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.shop = self.shopsArray[indexPath.item];
    return cell;
}

#pragma mark - WSWaterfallLayoutDelegate
- (CGFloat)waterfallLayout:(WSWaterfallLayout *)waterfallLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
    WSShop *shop = self.shopsArray[indexPath.item];
    CGFloat height = shop.h /shop.w * width;
    return height;
}

#pragma mark - 下拉刷新更多数据
- (void)reloadMoreShops {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.shopsArray addObjectsFromArray:[WSShop mj_objectArrayWithFilename:@"1.plist"]];
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
