//
//  SEMS_DeviceCtrlViewController.m
//  SEMS_iOS
//
//  Created by Fantasy on 14-6-20.
//  Copyright (c) 2014年 Fantasy. All rights reserved.
//

#import "SEMS_DeviceCtrlViewController.h"
#import "RATreeView.h"
#import "SEMS_NodeObject.h"
#import "SEMS_NodeCellViewTableViewCell.h"
#import "SEMS_DeviceStatusViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface SEMS_DeviceCtrlViewController ()<RATreeViewDelegate, RATreeViewDataSource>
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) id expanded;
@property (weak, nonatomic) RATreeView *treeView;
@end

@implementation SEMS_DeviceCtrlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SEMS_NodeObject *commonArea = [SEMS_NodeObject dataObjectWithName:@"公共办公区" id:3 children:nil];
    SEMS_NodeObject *tooneArea = [SEMS_NodeObject dataObjectWithName:@"同望办公区" id:4 children:nil];
    
    
    SEMS_NodeObject *awitArea_light = [SEMS_NodeObject dataObjectWithName:@"灯" id:5 children:nil];
    SEMS_NodeObject *awitArea = [SEMS_NodeObject dataObjectWithName:@"爱维特办公区" id:6 children:[NSArray arrayWithObjects:awitArea_light,nil]];
    
    SEMS_NodeObject *storgeArea = [SEMS_NodeObject dataObjectWithName:@"仓库" id:7 children:nil];
    SEMS_NodeObject *labArea = [SEMS_NodeObject dataObjectWithName:@"实验室" id:8 children:nil];
    SEMS_NodeObject *meettingArea = [SEMS_NodeObject dataObjectWithName:@"会议室" id:9 children:nil];
    SEMS_NodeObject *frontArea = [SEMS_NodeObject dataObjectWithName:@"前台" id:10 children:nil];
    
    
    
    SEMS_NodeObject *awit = [SEMS_NodeObject dataObjectWithName:@"武汉爱维特"
                                                             id:2
                                                       children:[NSArray arrayWithObjects:commonArea,tooneArea,awitArea,storgeArea,labArea,meettingArea,frontArea,nil]];
    SEMS_NodeObject *toone = [SEMS_NodeObject dataObjectWithName:@"上海同望"
                                                              id:1
                                                        children:nil];
    
    SEMS_NodeObject *sems = [SEMS_NodeObject dataObjectWithName:@"SEMS节能管理系统"
                                                             id:0
                                                       children:[NSArray arrayWithObjects:awit,toone,nil]];
    

    
    self.data = [NSArray arrayWithObjects:sems, nil];
    
    RATreeView *treeView = [[RATreeView alloc] initWithFrame:self.view.frame];
    
    treeView.delegate = self;
    treeView.dataSource = self;
    treeView.separatorStyle = RATreeViewCellSeparatorStyleNone;
    
    [treeView reloadData];
    [treeView expandRowForItem:sems withRowAnimation:RATreeViewRowAnimationTop]; //expands Row
    [treeView setBackgroundColor:UIColorFromRGB(0xF7F7F7)];
    
    self.treeView = treeView;
    [self.view addSubview:treeView];
    
    //设置导航控制器的返回按钮
    UIBarButtonItem *myBackBarButtonItem = [[UIBarButtonItem alloc] init];
    myBackBarButtonItem.title =@"返回";
    self.navigationItem.backBarButtonItem = myBackBarButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if([[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."][0] intValue] >= 7) {
        CGRect statusBarViewRect = [[UIApplication sharedApplication] statusBarFrame];
        float heightPadding = statusBarViewRect.size.height+self.navigationController.navigationBar.frame.size.height;
        self.treeView.contentInset = UIEdgeInsetsMake(heightPadding, 0.0, 0.0, 0.0);
        self.treeView.contentOffset = CGPointMake(0.0, -heightPadding);
    }
    
    self.treeView.frame = self.view.bounds;
}

#pragma mark TreeView Delegate methods
- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    return 47;
}

- (NSInteger)treeView:(RATreeView *)treeView indentationLevelForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    return 3 * treeNodeInfo.treeDepthLevel;
}

- (BOOL)treeView:(RATreeView *)treeView shouldExpandItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    return YES;
}

- (BOOL)treeView:(RATreeView *)treeView shouldItemBeExpandedAfterDataReload:(id)item treeDepthLevel:(NSInteger)treeDepthLevel
{
    if ([item isEqual:self.expanded]) {
        return YES;
    }
    
    return NO;
}

- (void)treeView:(RATreeView *)treeView willDisplayCell:(UITableViewCell *)cell forItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    if (treeNodeInfo.treeDepthLevel == 0) {
        cell.backgroundColor = UIColorFromRGB(0xF7F7F7);
    } else if (treeNodeInfo.treeDepthLevel == 1) {
        cell.backgroundColor = UIColorFromRGB(0xD1EEFC);
    } else if (treeNodeInfo.treeDepthLevel == 2) {
        cell.backgroundColor = UIColorFromRGB(0xE0F8D8);
    }else if (treeNodeInfo.treeDepthLevel == 3) {
        cell.backgroundColor = UIColorFromRGB(0xffF8D8);
    }
}

- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    RADataObject *selectObj=(RADataObject *)item;
    NSLog(@"select:%@",selectObj.name);
}

#pragma mark TreeView Data Source

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{

    //NSInteger numberOfChildren = [treeNodeInfo.children count];
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"子节点 %@", [@(numberOfChildren) stringValue]];
    //if (treeNodeInfo.isExpanded) {
    //    [cell.imageView setImage:[UIImage imageNamed:@"NodeTreeHeadIcon_exp"]];
    //}else{
    //    [cell.imageView setImage:[UIImage imageNamed:@"NodeTreeHeadIcon_unexp"]];
    //}
    //cell.textLabel.text = ((RADataObject *)item).name;
    //custom cell
    
    static NSString *CellIdentifier = @"CustomNodeCellId";
    
    
    SEMS_NodeCellViewTableViewCell *cell = (SEMS_NodeCellViewTableViewCell*)[treeView dequeueReusableCellWithIdentifier:CellIdentifier];
    //判断是否获取到复用cell,没有则从xib中初始化一个cell
    if (!cell) {
        //将Custom.xib中的所有对象载入
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SEMS_NodeCellViewTableViewCell" owner:nil options:nil];
        //第一个对象就是CustomCell了
        cell = [nib objectAtIndex:0];
    }
    cell.treeNodeInfo=treeNodeInfo;
    cell.treeView=treeView;
    cell.item=item;
    [cell.nodeLabelButton setTitle:((SEMS_NodeObject *)item).name forState:UIControlStateNormal];
    
    [cell.nodeHeadIconButton addTarget:self action:@selector(clickNodeHeadIcon:) forControlEvents:UIControlEventTouchUpInside];
    cell.nodeHeadIconButton.tag=((SEMS_NodeObject *)item).id;
    
    
    [cell.nodeLabelButton addTarget:self action:@selector(clickLabelButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.nodeLabelButton.tag=((SEMS_NodeObject *)item).id;
    
    //refresh the head icon
    if (treeNodeInfo.isExpanded) {
        [cell.nodeHeadIconButton setBackgroundImage:[UIImage imageNamed:@"NodeTreeHeadIcon_exp"]
                                           forState:UIControlStateNormal];
    }else{
        [cell.nodeHeadIconButton setBackgroundImage:[UIImage imageNamed:@"NodeTreeHeadIcon_unexp"]
                                           forState:UIControlStateNormal];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (treeNodeInfo.treeDepthLevel == 0) {
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}

- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item
{
    if (item == nil) {
        return [self.data count];
    }
    
    RADataObject *data = item;
    return [data.children count];
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item
{
    RADataObject *data = item;
    if (item == nil) {
        return [self.data objectAtIndex:index];
    }
    
    return [data.children objectAtIndex:index];
}

//tree cell click event
- (IBAction)clickNodeHeadIcon:(UIButton *)sender {

    for (SEMS_NodeCellViewTableViewCell *cell in [self.treeView visibleCells]){
        
        if (cell.nodeHeadIconButton.tag==sender.tag) {
            //NSLog(@"click head button %@",((SEMS_NodeObject *)cell.item).name);
            if (cell.treeNodeInfo.isExpanded) {
                
                [cell.treeView collapseRowForItem:cell.item withRowAnimation:RATreeViewRowAnimationTop];
                [cell.nodeHeadIconButton setBackgroundImage:[UIImage imageNamed:@"NodeTreeHeadIcon_unexp"]
                                                   forState:UIControlStateNormal];
            }else {
                
                [cell.treeView expandRowForItem:cell.item withRowAnimation:RATreeViewRowAnimationTop];
                [cell.nodeHeadIconButton setBackgroundImage:[UIImage imageNamed:@"NodeTreeHeadIcon_exp"]
                                                   forState:UIControlStateNormal];
                
            }
        }

    }
}


- (IBAction)clickLabelButton:(UIButton *)sender {
    for (SEMS_NodeCellViewTableViewCell *cell in [self.treeView visibleCells]){
        
        if (cell.nodeLabelButton.tag==sender.tag) {
            //SEMS_NodeObject* node=(SEMS_NodeObject *)cell.item;
            //NSLog(@"Click: %d-%@",node.id,node.name);
            [self performSegueWithIdentifier:@"goDeviceStatusView" sender:sender];

        }
    }

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"goDeviceStatusView"]) {
        if ([segue.destinationViewController isKindOfClass:[SEMS_DeviceStatusViewController class]]) {
            SEMS_DeviceStatusViewController *deviceStatusVC=(SEMS_DeviceStatusViewController *)segue.destinationViewController;
            deviceStatusVC.navigationItem.title=((UIButton *)sender).currentTitle;
        }
    }
}
@end
