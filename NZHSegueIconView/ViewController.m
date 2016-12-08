//
//  ViewController.m
//  NZHSegueIconView
//
//  Created by iiyumewo on 2016/12/7.
//  Copyright © 2016年 iiyumewo. All rights reserved.
//

#import "ViewController.h"
#import "SegueView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SegueView *segueView = [self generateCustomSegueView];
    [self.view addSubview:segueView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (SegueView *)generateCustomSegueView {
    SegueView *segueView = [[SegueView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 180) edgeDistance:27];
    segueView.iconImageArray = @[[UIImage imageNamed:@"location"],
                                 [UIImage imageNamed:@"location"],
                                 [UIImage imageNamed:@"location"],
                                 [UIImage imageNamed:@"location"],
                                 [UIImage imageNamed:@"location"],
                                 [UIImage imageNamed:@"location"],
                                 [UIImage imageNamed:@"location"]];
    segueView.infoTextArray = @[@"全科", @"妇产科", @"儿科", @"口腔科", @"眼科", @"皮肤科", @"内分泌科"];
    return segueView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
