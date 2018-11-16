
//
//  SecondViewController.m
//  QCMMKV
//
//  Created by EricZhang on 2018/7/17.
//  Copyright © 2018年 BYX. All rights reserved.
//

#import "SecondViewController.h"
#import "almmkv.h"


@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //跳转按钮
    UIButton *sendbtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 60, 150, 120, 45)];
    sendbtn.backgroundColor = [UIColor cyanColor];
    [sendbtn setTitle:@"返回" forState:0];
    [sendbtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendbtn];
    
    
    
}

//在这里进行数据的变更，并返回
-(void)backClick{
    

    [[ALMMKV  defaultMMKV] setObject:@"hello3" forKey:@"string"];
    [[ALMMKV defaultMMKV]setInteger:3 forKey:@"num"];
    [[ALMMKV defaultMMKV]setObject:@"zhang" forKey:@"name"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
