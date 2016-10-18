//
//  ViewController.m
//  SSClickButton
//
//  Created by haohao on 16/10/18.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ViewController.h"
#import "SSClickButton.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet SSClickButton *clickBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.9373 green:0.9373 blue:0.9569 alpha:1];
    // Do any additional setup after loading the view, typically from a nib.
    SSClickButton *btn = [SSClickButton sharedClickButtonWithFrame:CGRectMake(100, 100, 120, 30)];
    btn.bordColor = [UIColor blueColor];
    btn.transferNumberblock = ^(NSString *numberText) {
        NSLog(@"btn%@", numberText);
    };
    [self.view addSubview:btn];
    
    self.clickBtn.bordColor = [UIColor orangeColor];
    self.clickBtn.transferNumberblock = ^(NSString *numberText) {
        NSLog(@"clickBtn%@", numberText);
    };
    
    SSClickButton *btn2 = [SSClickButton sharedClickButtonWithFrame:CGRectMake(100, 300, 120, 30)];
    [btn2 setSubtractClickButtonWithForeImage:[UIImage imageNamed:@"subtract"] withAddButtonForeImage:[UIImage imageNamed:@"add"]];
    [self.view addSubview:btn2];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
