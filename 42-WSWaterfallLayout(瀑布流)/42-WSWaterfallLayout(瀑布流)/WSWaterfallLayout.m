//
//  WSWaterfallLayout.m
//  42-WSWaterfallLayout(瀑布流)
//
//  Created by XSUNT45 on 16/4/26.
//  Copyright © 2016年 XSUNT45. All rights reserved.
//

#import "WSWaterfallLayout.h"

@interface WSWaterfallLayout ()

/** 记录每一列最大的y值 */
@property (strong, nonatomic) NSMutableDictionary *maxYDict;
/** 记录每一列最大的y值 */
@property (strong, nonatomic) NSMutableArray *attributesArray;

@end

@implementation WSWaterfallLayout

//懒加载最大y值的字典
- (NSMutableDictionary *)maxYDict {
    if (!_maxYDict) {
        _maxYDict = [[NSMutableDictionary alloc] init];
    }
    return _maxYDict;
}

- (NSMutableArray *)attributesArray {
    if (!_attributesArray) {
        _attributesArray = [[NSMutableArray alloc] init];
    }
    return _attributesArray;
}

//初始化默认值
- (instancetype)init {
    self = [super init];
    if (self) {
        _columnMargin = 5;
        _rowMargin = 5;
        _sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _columnCount = 3;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

//布局前的准备工作
- (void)prepareLayout {
    [super prepareLayout];
    
    //初始化(清空)最大的y值
    for (int i = 0; i < _columnCount; i++) {
        NSString *column = [NSString stringWithFormat:@"%d",i];
        self.maxYDict[column] = @(self.sectionInset.top);
    }
    
    //清空数组
    [self.attributesArray removeAllObjects];
    //添加属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attributesArray addObject:attributes];
    }
}

//全部item的attributes
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}

//每一个item的attributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //找出最小Y值对应的那一列
    //假设第0列最小
    __block NSString *minColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL * _Nonnull stop) {
        if ([self.maxYDict[minColumn] floatValue] > [maxY floatValue]) {
            minColumn = column;
        }
    }];
    
    //每一个item的宽高
    CGFloat itemW = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (_columnCount - 1) * _columnMargin) / _columnCount;
    CGFloat itemH = [self.delegate waterfallLayout:self heightForWidth:itemW atIndexPath:indexPath];
    //每一个item的xy
    CGFloat itemX = self.sectionInset.left + (_columnMargin + itemW) * [minColumn intValue];
    CGFloat itemY = _rowMargin + [self.maxYDict[minColumn] floatValue];
    
    //更新这一列最大的y值
    self.maxYDict[minColumn] = @(itemY + itemH);
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectMake(itemX, itemY, itemW, itemH);
    return attributes;
}

//滚动范围
- (CGSize)collectionViewContentSize {
    __block NSString *maxColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.maxYDict[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue]);
}


@end
