//
//  ViewController.m
//  UploadDownload
//
//  Created by deng on 2020/6/10.
//  Copyright © 2020 professordeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)startToMove:(id)sender {
    if([self.activityIndicatorView isAnimating]) {
        // 停止旋转（进入非活动状态）
        [self.activityIndicatorView stopAnimating];
    } else {
        // 开始旋转（进入活动状态）
        [self.activityIndicatorView startAnimating];
    }
}

- (IBAction)downloadProgress:(id)sender {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(download) userInfo:nil repeats:YES];
}

- (void)download
{
    self.progressView.progress += 0.1;
    if (self.progressView.progress > 0.95) {
        [self.timer invalidate];
        
        // 设置弹出下载完成的警告框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"download completed!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:okAction];
        
        // 显示警告框
        [self presentViewController:alertController animated:true completion:nil];
    }
}

@end
