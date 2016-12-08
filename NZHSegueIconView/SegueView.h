//
//  SegueView.h
//  C11N-Ump4Dr-iOS
//
//  Created by iiyumewo on 16/7/26.
//  Copyright © 2016年 iiyumewo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SegueView : UIView

@property (nonatomic, strong) NSArray *iconImageArray;
@property (nonatomic, strong) NSArray *iconUrlArray;
@property (nonatomic, strong) NSArray *infoTextArray;
@property (nonatomic, assign) CGFloat edgeDistance;
@property (nonatomic, strong) UIScrollView *iconScrollView;
@property (nonatomic, strong) NSMutableArray *iconViewArray;

- (instancetype)initWithFrame:(CGRect)frame edgeDistance:(CGFloat)distance;

- (void)setIconImageArray:(NSArray *)iconImageArray;
- (void)setIconUrlArray:(NSArray *)iconUrlArray;
- (void)setInfoTextArray:(NSArray *)infoTextArray;

@end
