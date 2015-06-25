//
//  ImageViewController.m
//  imginarium
//
//  Created by liuminyong on 15/3/10.
//  Copyright (c) 2015年 liuminyong. All rights reserved.
//

#import "ImageViewController.h"
#import "URLUpdateViewController.h"

@interface ImageViewController()<UIScrollViewDelegate>
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end
@implementation ImageViewController

-(void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView=scrollView;
    self.scrollView.minimumZoomScale=0.2;
    self.scrollView.maximumZoomScale=2.0;
    self.scrollView.delegate=self;
    self.scrollView.contentSize=self.image?self.image.size:CGSizeZero;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
-(void)setImageURL:(NSURL *)imageURL
{
    _imageURL=imageURL;
    //self.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
    [self downloadImage:imageURL];
}

-(void) downloadImage:(NSURL *)imageURL
{
    self.image=nil;
    if (self.imageURL) {
        [self.spinner startAnimating];
        NSURLRequest *request=[[NSURLRequest alloc]initWithURL:imageURL];
        NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task=[session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            if (!error) {
                if ([request.URL isEqual:self.imageURL]) {
                    UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.image=image;
                    });
                }
            }
        } ];
        [task resume];
    }
}

-(UIImageView *) imageView
{
    if (!_imageView) {
        _imageView=[[UIImageView alloc]init];
    }
    return _imageView;
}

-(UIImage*)image
{
    return self.imageView.image;
}

-(void)setImage:(UIImage *)image
{
    self.imageView.image=image;
    [self.imageView sizeToFit];
    self.scrollView.contentSize=self.image?self.image.size:CGSizeZero;
    [self.spinner stopAnimating];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[URLUpdateViewController class]]) {
        URLUpdateViewController *urlhttp=(URLUpdateViewController *)segue.destinationViewController;
        urlhttp.url=self.imageURL;
    }
}
@end
