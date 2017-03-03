//
//  WSShopCell.m
//  42-WSWaterfallLayout(瀑布流)
//
//  Created by XSUNT45 on 16/4/26.
//  Copyright © 2016年 XSUNT45. All rights reserved.
//

#import "WSShopCell.h"
#import "UIImageView+WebCache.h"
#import "WSShop.h"

@interface WSShopCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@end

@implementation WSShopCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setShop:(WSShop *)shop {
    _shop = shop;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    //价格
    self.priceLable.text = shop.price;
}

@end
