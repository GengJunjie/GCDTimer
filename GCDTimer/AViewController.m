//
//  AViewController.m
//  GCDTimer
//
//  Created by 耿俊杰 on 2021/8/24.
//

#import "AViewController.h"
#import "GJJTimer.h"

@interface AViewController ()

@property (nonatomic, copy) NSString *timerName;

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.yellowColor;
    NSLog(@"begin");
    self.timerName = [GJJTimer timerWithTarget:self select:@selector(timerTask) start:2 interval:1 repeats:YES async:YES];
    
}

- (void)timerTask {
    NSLog(@"task-%@", [NSThread currentThread]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    [GJJTimer stopTimer:self.timerName];
}


@end
