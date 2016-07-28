//
//  PopMenuView.h
//  wenshuapp
//
//  Created by lawyee on 16/7/15.
//  Copyright © 2016年 LAWYEE. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PopMenuView;

@protocol PopMenuViewDelegate <NSObject>

- (void)popMenuView:(PopMenuView *)popMenu didSelectRowAtIndex:(NSUInteger)row;

@end

@interface PopMenuView : UIView

/**
 *  创建实例
 *
 *  @param imageNames 图片数组
 *  @param titles     标题数组
 */
+ (instancetype)popMenuWithImageName:(NSArray<NSString *>*)imageNames Title:(NSArray<NSString *>*)titles;

/**
 *  创建实例
 *
 *  @param imageNames 图片数组
 *  @param titles     标题数组
 */
- (instancetype)initWithImageName:(NSArray<NSString *>*)imageNames Title:(NSArray<NSString *>*)titles;

/**
 *  显示箭头指向哪个控件上
 */
- (void)showInView:(UIView *)view;

/**
 *  移除
 */
- (void)dismiss;

@property (nonatomic, weak) id<PopMenuViewDelegate> delegate;

@end
