//
//  TableViewController.m
//

//
//  Created by QAING CHEN on 16/10/17.
//  Copyright © 2016年 QAING CHEN. All rights reserved.
//

#import "TableViewController.h"
#import "Header.h"
#import "ModelStatus.h"
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"
#import "TableHeaderView.h"

@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)NSMutableArray *categoryArray;
@property (nonatomic ,strong)NSMutableArray *foodData;
@property (nonatomic ,strong)UITableView *leftTableView;
@property (nonatomic ,strong)UITableView *rightTableView;

@end

@implementation TableViewController
{
    NSInteger _selectIndex;
    BOOL _isScrollerDown;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _selectIndex = 0;
    _isScrollerDown = YES;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"meituan" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *foods = dict[@"data"][@"food_spu_tags"];
    for (NSDictionary *dict in foods) {
        ModelStatus *model = [ModelStatus objectWithDictionary:dict];
        [self.categoryArray addObject:model];
        NSMutableArray *datas = [NSMutableArray array];
        for (FoodModel *f_model in model.spus) {
            [datas addObject:f_model];
        }
        
        [self.foodData addObject:datas];
    }
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
}

- (NSMutableArray *)foodData
{
    if (!_foodData) {
        _foodData = [NSMutableArray array];
    }
    
    return _foodData;
}


- (NSMutableArray *)categoryArray
{
    if (!_categoryArray) {
        _categoryArray = [NSMutableArray array];
    }
    return _categoryArray;
}

- (UITableView *)leftTableView
{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 80, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight = 55;
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.separatorColor = [UIColor clearColor];
        [_leftTableView registerNib:[UINib nibWithNibName:@"LeftTableViewCell" bundle:nil] forCellReuseIdentifier:kCellIdentifier_Left];
    }
    return _leftTableView;
}

-(UITableView *)rightTableView
{
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(80, 64, SCREEN_WIDTH - 80, SCREEN_HEIGHT - 64)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 80;
        _rightTableView.showsVerticalScrollIndicator = NO;
        [_rightTableView registerNib:[UINib nibWithNibName:@"RightTableViewCell" bundle:nil] forCellReuseIdentifier:kCellIdentifier_Right];
    }
    return _rightTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_leftTableView == tableView) {
        return 1;
    }else
    {
        return self.categoryArray.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_leftTableView == tableView) {
        return self.categoryArray.count;
        
    }else
    {
        return [self.foodData[section] count];
        
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_leftTableView == tableView) {
        LeftTableViewCell *Leftcell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left forIndexPath:indexPath];
        FoodModel *model = self.categoryArray[indexPath.row];
        Leftcell.nameLabel.text = model.name;
        NSLog(@"%@",model.name);
        return Leftcell;
    }else
    {
        RightTableViewCell *rightCell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Right forIndexPath:indexPath];
        FoodModel *model = self.foodData[indexPath.section][indexPath.row];
        rightCell.model = model;
        NSLog(@"%@",model);
        return rightCell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_rightTableView == tableView) {
        return 80 ;
    }
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_rightTableView == tableView) {
        TableHeaderView *header = [[TableHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        FoodModel *model = self.categoryArray[section];
        header.label.text = model.name;
        return header;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_rightTableView == tableView) {
      return 30;
    }
    return 0;
    
}
// TableView分区标题即将展示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ((_rightTableView == tableView) && !_isScrollerDown && _rightTableView.dragging) {
        [self selectRowAtIndexPath:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向下，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView) && _isScrollerDown && _rightTableView.dragging) {
        [self selectRowAtIndexPath:section + 1];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_leftTableView == tableView) {
        _selectIndex = indexPath.row;
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

//当拖动右边的tableview的时候,处理左边的tableview
-(void)selectRowAtIndexPath:(NSInteger)index
{
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffsetY = 0;
    UITableView *tableview = (UITableView *)scrollView;
    if (_rightTableView == tableview) {
        _isScrollerDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
