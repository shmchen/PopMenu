//
//  ViewController.m
//  PopMenu
//
//  Created by lawyee on 16/7/28.
//  Copyright © 2016年 163. All rights reserved.
//

#import "ViewController.h"
#import "PopMenuView.h"

@interface ViewController () <PopMenuViewDelegate>

@property (nonatomic, strong) PopMenuView *popMenu;

@end


@implementation ViewController

//延迟加载
- (PopMenuView *)popMenu
{
    if (nil == _popMenu) {
        NSArray *images = @[@"store_normal", @"saoyisao"];
        NSArray *titles = @[@"我的收藏", @"扫一扫"];
        _popMenu = [PopMenuView popMenuWithImageName:images Title:titles];
        _popMenu.delegate = self;
    }
    
    return _popMenu;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    UIView *redView = [self.view viewWithTag:110];
    if (nil == redView) {
        redView = [UIView new];
        redView.backgroundColor = [UIColor redColor];
        redView.tag = 110;
        [self.view addSubview:redView];
    }
    
    redView.frame = CGRectMake(point.x - 50, point.y - 20, 100, 40);
    
    
    [self.popMenu showInView:redView];
}

- (void)popMenuView:(PopMenuView *)popMenu didSelectRowAtIndex:(NSUInteger)row
{
    NSLog(@"%zd", row);
}

@end
