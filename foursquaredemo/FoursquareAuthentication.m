//
//  FoursquareAuthentication.m
//  foursquaredemo
//
//  Created by Keith Elliott on 4/18/13.
//  Copyright (c) 2013 gittielabs. All rights reserved.
//

#import "FoursquareAuthentication.h"

	// 5. setup some helpers so we don't have to hard-code everything
#define FOURSQUARE_AUTHENTICATE_URL @"https://foursquare.com/oauth2/authorize"
#define FOURSQUARE_CLIENT_ID @"YOUR CLIENT ID"
#define FOURSQUARE_CLIENT_SECRET @"YOUR CLIENT SECRET"
#define FOURSQUARE_REDIRECT_URI @"ios-app://redirect"

@interface FoursquareAuthentication ()
	// 1. create webview property
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation FoursquareAuthentication

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	
		// initialize the webview and add it to the view
	
		//2. init with the available window dimensions
	self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
		//3. set the delegate to self so that we can respond to web activity
	self.webView.delegate = self;
		//4. add the webview to the view
	[self.view addSubview:self.webView];
	
		//6. Create the authenticate string that we will use in our request to foursquare
		// we have to provide our client id and the same redirect uri that we used in setting up our app
		// The redirect uri can be any scheme we want it to be... it's not actually going anywhere as we plan to
		// intercept it and get the access token off of it
	NSString *authenticateURLString = [NSString stringWithFormat:@"%@?client_id=%@&response_type=token&redirect_uri=%@", FOURSQUARE_AUTHENTICATE_URL, FOURSQUARE_CLIENT_ID, FOURSQUARE_REDIRECT_URI];
		//7. Make the request and load it into the webview
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:authenticateURLString]];
	[self.webView loadRequest:request];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Web view delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

 if([request.URL.scheme isEqualToString:@"ios-app"]){
		 // 8. get the url and check for the access token in the callback url
		NSString *URLString = [[request URL] absoluteString];
		if ([URLString rangeOfString:@"access_token="].location != NSNotFound) {
				// 9. Store the access token in the user defaults
			NSString *accessToken = [[URLString componentsSeparatedByString:@"="] lastObject];
			NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
			[defaults setObject:accessToken forKey:@"access_token"];
			[defaults synchronize];
				// 10. dismiss the view controller 
			[self dismissViewControllerAnimated:YES completion:nil];
		}
	}
	return YES;
}

@end
