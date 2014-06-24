//
//  SEMS_NodeCellViewTableViewCell.h
//  SEMS_iOS
//
//  Created by Fantasy on 14-6-23.
//  Copyright (c) 2014年 Fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RATreeView.h"
#import "SEMS_NodeObject.h"
#import "RATreeNodeInfo.h"

@interface SEMS_NodeCellViewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *nodeHeadIconButton;
@property (weak, nonatomic) IBOutlet UIButton *nodeLabelButton;


@property(nonatomic,strong) RATreeNodeInfo *treeNodeInfo;
@property (nonatomic,strong) id item;
@property (nonatomic,strong) RATreeView * treeView;

@end
