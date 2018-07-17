//
//  ViewController.m
//  QCMMKV
//
//  Created by EricZhang on 2018/7/17.
//  Copyright © 2018年 BYX. All rights reserved.
//

#import "ViewController.h"
#import "almmkv.h"
#import "SecondViewController.h"
#import "CountModel.h"



@interface ViewController ()
@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UILabel *changeBtn;
@property(nonatomic,strong) ALMMKV *mmkv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    /*
     反向传值的时候数据的变化
     */
    
    self.mmkv  = [ALMMKV defaultMMKV];
    //正确的情况
    [self.mmkv setObject: @"hello1" forKey:@"string"];
    
    //没有设置mmkv属性,一旦本类中没有mmkv属性，反向传过来的结果得不到
    //[[ALMMKV  defaultMMKV] setObject: @"hello1" forKey:@"string"];
    
//    //但是只要有一个传过来的结果就没问题
//    NSLog(@"string:%@",[self.mmkv objectOfClass:[NSString class] forKey:@"string"]);
//    // 输出结果显示   2018-07-17 13:06:34.371413+0800 QCMMKV[7924:147126] string:hello1
//    CountModel *model = [CountModel new];
//    model.num = 1;
//    model.name = @"qiao";
//    [[ALMMKV defaultMMKV]setInteger:model.num forKey:@"num"];
//    [[ALMMKV defaultMMKV]setObject:model.name forKey:@"name"];
//
    
    
    
    UIButton *sendbtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 60, 150, 120, 45)];
    sendbtn.backgroundColor = [UIColor cyanColor];
    [sendbtn setTitle:@"跳转" forState:0];
    [sendbtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendbtn];
    

    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    ALMMKV *mmkv = [ALMMKV  defaultMMKV];
//    NSLog(@"string:%@",[self.mmkv objectOfClass:[NSString class] forKey:@"string"]);
    NSLog(@"string:%@",[self.mmkv  objectOfClass:[NSString class] forKey:@"string"]);
    
    
//    //如果数据发生变化了，我们进行一些其他操作
//    NSLog(@"num:%ld",[[ALMMKV defaultMMKV]  integerForKey:@"num"]);
//    NSLog(@"name:%@",[[ALMMKV defaultMMKV]objectOfClass:[NSString class] forKey:@"name"]);
    
}

//跳转
-(void)click{
    
    [self presentViewController:[SecondViewController new] animated:YES completion:nil];
    
    
}

-(void)dealloc{
    
    [self.mmkv removeObjectForKey:@"string"];

    
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
