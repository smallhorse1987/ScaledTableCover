//
//  ViewController.m
//  ScaledTableCoverExample
//
//  Created by chen xiaosong on 16/4/25.
//  Copyright © 2016年 chen xiaosong. All rights reserved.
//

#import "ViewController.h"

#import "STCImageView.h"

#define kHeightOfCover 120.0

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *stcTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.stcTableView.backgroundColor = [UIColor clearColor];
    self.stcTableView.rowHeight = kHeightOfCover;
    
    STCImageView *coverImageV = [[STCImageView alloc] initWithScrollView:self.stcTableView height:kHeightOfCover];
    coverImageV.image = [UIImage imageNamed:@"cover01.png"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kPlainCell"];
    cell.backgroundColor  = [UIColor clearColor];

    cell.textLabel.text = [NSString stringWithFormat:@"我是单元格 %2ld", indexPath.row];
    
    return cell;
}

@end
