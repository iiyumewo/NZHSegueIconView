//
//  SegueView.m
//  C11N-Ump4Dr-iOS
//
//  Created by iiyumewo on 16/7/26.
//  Copyright © 2016年 iiyumewo. All rights reserved.
//

#import "SegueView.h"
#import "Masonry.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kColorWithRGB(r, g, b, a) [UIColor colorWithRed:(r) / 255.f green:(g) / 255.f blue:(b) / 255.f alpha:a]
#define iconViewWidth 45
#define iconViewHeight 67

@interface SegueView() <UIScrollViewDelegate>



@end

@implementation SegueView

- (NSMutableArray *)iconViewArray {
    if (_iconViewArray == nil) {
        _iconViewArray = [NSMutableArray array];
    }
    return _iconViewArray;
}

- (instancetype)initWithFrame:(CGRect)frame edgeDistance:(CGFloat)distance {
    self = [super initWithFrame:frame];
    if (self) {
        _edgeDistance = distance;
        [self configureIconScrollViewWith:frame];
    }
    return self;
}

- (void)configureIconScrollViewWith:(CGRect)frame {
    _iconScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _iconScrollView.contentSize = CGSizeZero;
    _iconScrollView.showsVerticalScrollIndicator = NO;
    _iconScrollView.showsHorizontalScrollIndicator = NO;
    _iconScrollView.pagingEnabled = YES;
    _iconScrollView.delegate = self;
    [self addSubview:_iconScrollView];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    self.userInteractionEnabled = NO;
//}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.userInteractionEnabled = YES;
}

- (void)setIconImageArray:(NSArray *)iconImageArray {
    _iconImageArray = iconImageArray;
//    self.iconImageArray = iconImageArray;
    [self configurePageTurningButton];
    [self configureIconScrollView];
    [self configureIcons];
}

- (void)configurePageTurningButton {
    UIView *pageTurningLeftView = [[UIView alloc]initWithFrame:CGRectZero];
    pageTurningLeftView.backgroundColor = [UIColor clearColor];
    [self addSubview:pageTurningLeftView];
    [pageTurningLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.mas_equalTo(25);
    }];
    UIView *pageTurningRightView = [[UIView alloc]initWithFrame:CGRectZero];
    pageTurningRightView.backgroundColor = [UIColor clearColor];
    [self addSubview:pageTurningRightView];
    [pageTurningRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.mas_equalTo(25);
    }];
    
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(turnLeftTap:)];
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(turnRightTap:)];
    [pageTurningLeftView addGestureRecognizer:leftTap];
    [pageTurningRightView addGestureRecognizer:rightTap];
    
    UIImageView *turnLeftImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    turnLeftImageView.image = [UIImage imageNamed:@"IconViewTurnLeft"];
    [pageTurningLeftView addSubview:turnLeftImageView];
    [turnLeftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(pageTurningLeftView);
        make.width.mas_equalTo(17.84/2.f);
        make.height.mas_equalTo(30.38/2.f);
    }];
    
    UIImageView *turnRightImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    turnRightImageView.image = [UIImage imageNamed:@"IconViewTurnRight"];
    [pageTurningRightView addSubview:turnRightImageView];
    [turnRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(pageTurningRightView);
        make.width.mas_equalTo(17.84/2.f);
        make.height.mas_equalTo(30.38/2.f);
    }];
    
    if (self.iconImageArray.count > 8) {
        pageTurningLeftView.hidden = NO;
        pageTurningRightView.hidden = NO;
    }else {
        pageTurningLeftView.hidden = YES;
        pageTurningRightView.hidden = YES;
    }
}

- (void)turnLeftTap:(UITapGestureRecognizer *)gesture {
    if (self.iconScrollView.contentOffset.x >= kWidth) {
        [self.iconScrollView setContentOffset:CGPointMake(self.iconScrollView.contentOffset.x-kWidth, 0) animated:YES];
    }
}
- (void)turnRightTap:(UITapGestureRecognizer *)gesture {
    NSInteger pageNumber = [self getNumberOfPageForIconViewWithIconNumber:self.iconImageArray.count];
    if (self.iconScrollView.contentOffset.x < kWidth*(pageNumber-1)) {
        [self.iconScrollView setContentOffset:CGPointMake(self.iconScrollView.contentOffset.x+kWidth, 0) animated:YES];
    }
}

- (NSInteger)getNumberOfPageForIconViewWithIconNumber:(NSInteger)iconNumber {
    NSInteger page = 0;
    if (iconNumber%8 == 0) {
        page = iconNumber/8;
    }else {
        page = iconNumber/8+1;
    }
    return page;
}

- (void)configureIconScrollView {
    if (self.iconImageArray.count > 8) {
        self.iconScrollView.contentSize = CGSizeMake(self.frame.size.width*[self getNumberOfPageForIconViewWithIconNumber:self.iconImageArray.count], 0);
    }
}

- (void)setInfoTextArray:(NSArray *)infoTextArray {
    _infoTextArray = infoTextArray;
    [self configureInfoTexts];
}

- (void)configureInfoTexts {
    [self.infoTextArray enumerateObjectsUsingBlock:^(NSString *infoText, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger relativeIndex = idx%8;
        NSInteger currentPage = idx/8;
        
        BOOL isIconDownward = relativeIndex/4;
        CGFloat yPosition = isIconDownward==YES ? self.frame.size.height/2+13.5/2 : 26/2;
        
        NSInteger horizontalRelativeIndex = relativeIndex%4;
        
        CGFloat iconCenterDistance = (kWidth-self.edgeDistance*2-iconViewWidth)/3;
        
        CGRect frame = CGRectMake(kWidth*currentPage+horizontalRelativeIndex*iconCenterDistance+self.edgeDistance, yPosition, iconViewWidth, iconViewHeight);
        UIView *iconView = [[UIView alloc]initWithFrame:frame];
        iconView.clipsToBounds = NO;
        /**
         *  第一次创建先加了图片数组
         */
        if (self.iconViewArray.count <= idx) {
//            iconView.backgroundColor = [UIColor redColor];
            [self.iconScrollView addSubview:iconView];
            [self.iconViewArray addObject:iconView];
        }else {
            iconView = self.iconViewArray[idx];
        }
        
        /**
         *  添加文字
         */
        UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [iconView addSubview:infoLabel];
        [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(iconView);
            make.centerX.equalTo(iconView);
            make.height.mas_equalTo(15);
        }];
        infoLabel.text = infoText;
        infoLabel.font = [UIFont systemFontOfSize:11];
        infoLabel.textAlignment = NSTextAlignmentCenter;
        infoLabel.textColor = kColorWithRGB(93, 93, 93, 1);
    }];
}

- (void)configureIcons {
    [self.iconImageArray enumerateObjectsUsingBlock:^(UIImage *iconImage, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger relativeIndex = idx%8;
        NSInteger currentPage = idx/8;
        
        BOOL isIconDownward = relativeIndex/4;
        CGFloat yPosition = isIconDownward==YES ? self.frame.size.height/2+13.5/2 : 26/2;
        
        NSInteger horizontalRelativeIndex = relativeIndex%4;
        
        CGFloat iconCenterDistance = (kWidth-self.edgeDistance*2-iconViewWidth)/3;
        
        CGRect frame = CGRectMake(kWidth*currentPage+horizontalRelativeIndex*iconCenterDistance+self.edgeDistance, yPosition, iconViewWidth, iconViewHeight);
//        NSLog(@"%f %f %f %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
        
        UIView *iconView = [[UIView alloc]initWithFrame:frame];
        /**
         *  第一次创建先加了图片数组
         */
        if (self.iconViewArray.count <= idx) {
//            iconView.backgroundColor = [UIColor redColor];
            [self.iconScrollView addSubview:iconView];
            [self.iconViewArray addObject:iconView];
        }else {
            iconView = self.iconViewArray[idx];
        }
        /**
         *  添加图片
         */
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [iconView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(iconView);
            make.height.mas_equalTo(45);
        }];
        imageView.image = iconImage;
    }];
}









/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
