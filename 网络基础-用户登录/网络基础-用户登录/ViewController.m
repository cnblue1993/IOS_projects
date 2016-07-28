//
//  ViewController.m
//  网络基础-用户登录
//
//  Created by anne on 16/7/22.
//  Copyright © 2016年 anne. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>

@property (weak, nonatomic) UITextField *nameTextField;
@property (weak, nonatomic) UITextField *passwordTextField;

@property (weak, nonatomic) NSMutableData *serverData;

@end

@implementation ViewController

#pragma mark - 私有方法
#pragma mark 初始化
- (void)setupUI{
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:4];
    
    for(NSInteger i = 0; i < 2; i++){
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 20 + i * 40, 80, 40)];
        [self.view addSubview:label];
        [arrayM addObject:label];
    }
    
    for(NSInteger i = 0; i < 2; i++){
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(100, 24 + i * 40, 200, 32)];
        [textField setBorderStyle:UITextBorderStyleRoundedRect];
        [textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self.view addSubview:textField];
        [arrayM addObject:textField];
    }
    
    [(UILabel *)arrayM[0]setText:@"用户名："];
    [(UILabel *)arrayM[1]setText:@"密码："];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(100, 106, 200, 40)];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)login{
    NSString *userName = self.nameTextField.text;
    NSString *pwd = self.passwordTextField.text;
    
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.3.252/~apple/itcast/login.php?username=%@&password=%@",userName, pwd];
    
    urlString = [urlString  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //NSURLSession
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    [conn start];
}

- (void)

#pragma mark - 网络代理方法
#pragma mark 1.接收到服务器的响应，服务器要传数据，客户端做接收准备
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.serverData = [NSMutableData data];
}

#pragma mark 2.接收服务器传输的数据，可能执行多次
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.serverData appendData:data];
}

#pragma mark 3.接收数据完成，做后续处理
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *str = [[NSString alloc]initWithData:self.serverData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",str);
    NSRange range = [str rangeOfString:@"用户名"];
    NSString *msg = nil;
    if(range.length > 0){
        NSString *name = [str substringFromIndex:(range.location + range.length)];
        msg = [NSString stringWithFormat:@"欢迎：%@", name];
    }else{
        msg = @"用户名或密码错误，请重试！";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    self.serverData = nil;
    
}
#pragma mark 4.服务器请求失败，原因很多（网络环境等）
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
}
#pragma mark 5.项服务器发送数据，此方法仅适用于POST,尤其是上传文件

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}





@end
