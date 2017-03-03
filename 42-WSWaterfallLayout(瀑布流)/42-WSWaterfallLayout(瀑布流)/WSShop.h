//
//  WSShop.h
//  42-WSWaterfallLayout(瀑布流)
//
//  Created by XSUNT45 on 16/4/26.
//  Copyright © 2016年 XSUNT45. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WSShop : NSObject
/** 图片的url */
@property (copy, nonatomic) NSString *img;
/** 商品的价格 */
@property (copy, nonatomic) NSString *price;
/** 商品(衣服)的宽 */
@property (assign, nonatomic) CGFloat w;
/** 商品(衣服)的宽 */
@property (assign, nonatomic) CGFloat h;

@end
