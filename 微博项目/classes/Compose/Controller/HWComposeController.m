//
//  HWComposeController.m
//  微博项目
//
//  Created by Youngfev on 15/12/11.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWComposeController.h"
#import "HWAccountTool.h"
#import "HWEmotionTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "HWComposeToolbar.h"
#import "HWComposeToolbar.h"
#import "HWComposePhotosView.h"
#import "HWEmotionKeyboard.h"
#import "HWEmotion.h"


@interface HWComposeController ()<UITextViewDelegate,HWComposeToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,weak) HWEmotionTextView *textView;
@property (nonatomic,weak) HWComposeToolbar *toolbar;
@property (nonatomic,weak) HWComposePhotosView *photosView;
@property (nonatomic,strong) HWEmotionKeyboard *emotionKeyboard;//strong
@property (nonatomic,assign) BOOL isSwitchingKeyboard;
@end

@implementation HWComposeController

-(HWEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[HWEmotionKeyboard alloc] init];
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 216;
        self.emotionKeyboard.backgroundColor = [UIColor whiteColor];
    }
    return _emotionKeyboard;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNav];
    
    [self setUpTextView];
    
    [self setupToolbar];
    
    [self setupPhotosView];

}

-(void)setupPhotosView
{
    HWComposePhotosView *photosView = [[HWComposePhotosView alloc] init];
    
    photosView.width = self.view.width;
    photosView.height = self.view.height;
    
//    CGSize textF = [self.textView.text sizeWithFont:self.textView.font];
    photosView.y = 100;
    
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

-(void)setupToolbar
{
    HWComposeToolbar *toolbar = [[HWComposeToolbar alloc] init];
    
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    toolbar.x = 0;
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
}

-(void)setUpTextView
{
    HWEmotionTextView *textView = [[HWEmotionTextView alloc] init];
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.frame = self.view.bounds;
    textView.placeholder = @"分享新鲜事...";
    
    [self.view addSubview:textView];
    self.textView = textView;
    
    self.textView.font = [UIFont systemFontOfSize:17];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect:) name:HWEmotionButtonNotificationName object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDelegate) name:@"delegateEmotionNotification" object:nil];
}

-(void)emotionDidDelegate
{
    [self.textView deleteBackward];
}

-(void)emotionDidSelect:(NSNotification *)notification
{
    HWEmotion *emotion = notification.userInfo[HWDidSelectEmotionButton];
    
    [self.textView insertEmotion:emotion];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.textView becomeFirstResponder];
}
-(void)keyboardWillChangeFrame:(NSNotification *)notification
{
    if (self.isSwitchingKeyboard) return;
    
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval interval = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:interval animations:^{
        CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
//        HWLog(@"%f",keyboardF.origin.y);
    }];
}

-(void)setUpNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
#warning enabled = NO;颜色改不了？？？
//    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    //    titleView.backgroundColor = [UIColor redColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.numberOfLines = 0;
    
    NSString *str = [NSString stringWithFormat:@"发微博\n%@",[HWAccountTool account].name];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, 3)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(4, [HWAccountTool account].name.length)];
    
    titleView.attributedText = attrStr;
    self.navigationItem.titleView = titleView;
}

-(void)send
{
    
    
    if (self.photosView.photos.count) {
        [self sendWithImage];
    }else{
        [self sendWithoutImage];
    }
    [self.textView endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)sendWithImage
{
    //请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    HWAccount *account = [HWAccountTool account];
    parameters[@"access_token"] = account.access_token;
    parameters[@"status"] = self.textView.text;
    
    //发送请求
    [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        HWLog(@"%@",error);
        [MBProgressHUD showSuccess:@"发送失败"];
    }];
}

-(void)sendWithoutImage
{
    //请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    HWAccount *account = [HWAccountTool account];
    parameters[@"access_token"] = account.access_token;
    parameters[@"status"] = self.textView.fullText;
    
    //发送请求
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        HWLog(@"success");
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        HWLog(@"%@",error);
        [MBProgressHUD showSuccess:@"发送失败"];
    }];
}

-(void)cancel
{
    [self.textView endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.textView endEditing:YES];
}
-(void)composeToolbar:(HWComposeToolbar *)toolbar didClickButton:(HWComposeToolbarType)type
{
    switch (type) {
        case HWComposeToolbarTypeCamera:
            [self openCamera];
            break;
        case HWComposeToolbarTypeEmotion:
            [self switchKeyboard];
            break;
        case HWComposeToolbarTypeTrend:
            HWLog(@"TypeTrend");
            break;
        case HWComposeToolbarTypeMention:
            HWLog(@"TypeTrend");
            break;
        case HWComposeToolbarTypePicture:
            [self openAlbum];
            break;
            
        default:
            break;
    }
}

-(void)switchKeyboard
{
    if (self.textView.inputView == nil) {
        self.textView.inputView = self.emotionKeyboard;
        self.toolbar.showKeyboardButton = YES;
    }else{
        self.textView.inputView = nil;
        self.toolbar.showKeyboardButton = NO;
    }
    self.isSwitchingKeyboard = YES;
    
    [self.textView endEditing:YES];
    
    self.isSwitchingKeyboard = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });
}
-(void)openCamera
{
    [self openImagePicker:UIImagePickerControllerSourceTypeCamera];
}
-(void)openAlbum
{
    [self openImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
}
-(void)openImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = sourceType;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.photosView addPhoto:image];
    
//    NSArray *arr = [self.photosView.photos];
}
@end
