//
//  ViewController.m
//  MySafari
//
//  Created by Alex on 10/22/14.
//  Copyright (c) 2014 Alexey Emelyanov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *urlTitle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView.scrollView.delegate = self;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    [UIView animateWithDuration:.5 animations:^{
        self.urlTextField.alpha = 1;
        self.urlTextField.frame = CGRectMake(self.urlTextField.frame.origin.x, -40, self.urlTextField.frame.size.width, self.urlTextField.frame.size.height);
    }];

//    if(scrollView.contentOffset.y <= 0) {
//        self.urlTextField.alpha = 1;
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDelegate:self];
//        [UIView setAnimationDuration:0.5];
//        [UIView setAnimationBeginsFromCurrentState:YES];
//        self.urlTextField.frame = CGRectMake(self.urlTextField.frame.origin.x, self.urlTextField.frame.origin.y, self.urlTextField.frame.size.width, self.urlTextField.frame.size.height);
//        [UIView commitAnimations];
//    } else {
//
//        self.urlTextField.alpha = 0.2;
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDelegate:self];
//        [UIView setAnimationDuration:0.5];
//        [UIView setAnimationBeginsFromCurrentState:YES];
//       self.urlTextField.frame = CGRectMake(self.urlTextField.frame.origin.x, -30, self.urlTextField.frame.size.width, self.urlTextField.frame.size.height);
//        [UIView commitAnimations];
//    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    if ([[self.urlTextField.text substringToIndex:7] isEqualToString:@"http://"])
    {
        

    } else {
        self.urlTextField.text = [NSString stringWithFormat:@"http://%@", self.urlTextField.text];
    }


    NSURL *url = [NSURL URLWithString:self.urlTextField.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];



    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];


}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
    self.urlTitle.text = ([self.webView stringByEvaluatingJavaScriptFromString:@"document.title"]);

}
- (IBAction)onBackButtonPressed:(id)sender {

    //something might be wrong with the back button
    if(self.webView.canGoBack)
    {
    [self.webView goBack];
    }
    else{}


}

- (IBAction)onComingSoonButtonPressed:(id)sender {
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Welcome" message:@"Coming Soon!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];

}

- (IBAction)onReloadButtonPressed:(id)sender {
    [self.webView reload];
}

- (IBAction)onClearButtonPressed:(id)sender {
    self.urlTextField.text = @"";
}


- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.activityIndicator stopAnimating];
    [self.webView stopLoading];
}


- (IBAction)onForwardButtonPressed:(id)sender {
    //something might be wrong with the forward button
    if(self.webView.canGoForward)
    {
        [self.webView goForward];
    }
    else{}

}

@end
