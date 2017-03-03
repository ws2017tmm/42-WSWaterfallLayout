//
//  WSWaterfallLayout.h
//  42-WSWaterfallLayout(瀑布流)
//
//  Created by XSUNT45 on 16/4/26.
//  Copyright © 2016年 XSUNT45. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSWaterfallLayout;

@protocol WSWaterfallLayoutDelegate <NSObject>

/** 告诉这个indexPath下cell的宽度,返回高度 */
- (CGFloat)waterfallLayout:(WSWaterfallLayout *)waterfallLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface WSWaterfallLayout : UICollectionViewLayout

/** 每一列的间距 */
@property (assign, nonatomic) CGFloat columnMargin;
/** 每一行的间距 */
@property (assign, nonatomic) CGFloat rowMargin;
/** 显示多少列 */
@property (nonatomic, assign) int columnCount;
/** item 距离上下左右的距离 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;

/** 代理属性 */
@property (weak, nonatomic) id<WSWaterfallLayoutDelegate> delegate;

@end
