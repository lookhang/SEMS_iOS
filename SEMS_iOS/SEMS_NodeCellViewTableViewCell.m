//
//  SEMS_NodeCellViewTableViewCell.m
//  SEMS_iOS
//
//  Created by Fantasy on 14-6-23.
//  Copyright (c) 2014年 Fantasy. All rights reserved.
//

#import "SEMS_NodeCellViewTableViewCell.h"

@interface SEMS_NodeCellViewTableViewCell()
@end
@implementation SEMS_NodeCellViewTableViewCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    [self.nodeHeadIconButton setBackgroundImage:[UIImage imageNamed:@"NodeTreeHeadIcon_unexp"]
                                       forState:UIControlStateNormal];
    self.nodeLabelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//设置按钮文字左对齐
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end
