//
//  ViewController.m
//  MySafari
//
//  Created by Alex on 10/22/14.
//  Copyright (c) 2014 Alexey Emelyanov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
}
- (IBAction)onBackButtonPressed:(id)sender {

    //something might be wrong with the back button
    if(self.webView.canGoBack)
    {
    [self.webView goBack];
    }
    else{}


}
- (IBAction)onReloadButtonPressed:(id)sender {
    [self.webView reload];
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
