//
//  PopMenuView.m
//  wenshuapp
//
//  Created by lawyee on 16/7/15.
//  Copyright © 2016年 LAWYEE. All rights reserved.
//

#import "PopMenuView.h"
#import "PopMenuCell.h"
#import <Masonry.h>

#define DEFAULT_ROWHEIGHT 47
#define DEFAULT_ROWWight 110
#define POPMENU_CELLID @"popMenuCellID"


@interface PopMenuView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation PopMenuView

#pragma mark - 构造方法
+ (instancetype)popMenuWithImageName:(NSArray<NSString *> *)imageNames Title:(NSArray<NSString *> *)titles
{
    return [[self alloc] initWithImageName:imageNames Title:titles];
}

- (instancetype)initWithImageName:(NSArray<NSString *> *)imageNames Title:(NSArray<NSString *> *)titles
{
    
    NSAssert(imageNames.count == titles.count, @"异常：图片个数和文字描述个数不一致！");
    
    if (self = [super init]) {
        self.imageNames = imageNames;
        self.titles = titles;
        [self layoutUI];
    }
    
    [self initDefaultFrame];

    return self;
}

#pragma mark - UI布局
- (void)layoutUI
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popover_bg"]];
    [self addSubview:imageView];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(-3, 0, -4, 0);
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(edgeInsets);
    }];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = DEFAULT_ROWHEIGHT;
    tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PopMenuCell class]) bundle:nil] forCellReuseIdentifier:POPMENU_CELLID];
}

// 内部根据内容决定初始高度
- (void)initDefaultFrame
{
    NSUInteger count = self.titles.count;
    CGFloat height = count * DEFAULT_ROWHEIGHT;
    self.frame = CGRectMake(0, 0, DEFAULT_ROWWight, height);
}

#pragma mark - TableView方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    PopMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:POPMENU_CELLID];
    NSString *imageName = self.imageNames[indexPath.row];
    NSString *titleName = self.titles[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.label.text = titleName;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(popMenuView:didSelectRowAtIndex:)]) {
        [self.delegate popMenuView:self didSelectRowAtIndex:indexPath.row];
    }
}

#pragma mark - 显示和隐藏
- (void)showInView:(UIView *)view
{
    CGRect showRect = view.frame;
    CGRect rect = self.frame;
    rect.origin.x = CGRectGetMaxX(showRect) - DEFAULT_ROWWight;
    rect.origin.y = CGRectGetMaxY(showRect) + 5;
    
    // 菜单view直接添加到keyWindow上
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    [keyWindow bringSubviewToFront:self];

    self.frame = rect;
}

- (void)dismiss
{
    [self removeFromSuperview];
}


// 拦截所有点击
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}
@end
