//
//  PopMenuCell.m
//  wenshuapp
//
//  Created by lawyee on 16/7/15.
//  Copyright © 2016年 LAWYEE. All rights reserved.
//

#import "PopMenuCell.h"

@implementation PopMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
