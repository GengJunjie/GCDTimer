//
//  ViewController.m
//  GCDTimer
//
//  Created by 耿俊杰 on 2021/8/24.
//

#import "ViewController.h"
#import "AViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    AViewController *ctrl = [[AViewController alloc] init];
    ctrl.modalPresentationStyle = 0;
    [self presentViewController:ctrl animated:YES completion:nil];
}




@end
