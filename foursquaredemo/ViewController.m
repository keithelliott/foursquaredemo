//
//  ViewController.m
//  foursquaredemo
//
//  Created by Keith Elliott on 4/18/13.
//  Copyright (c) 2013 gittielabs. All rights reserved.
//

#import "ViewController.h"
#import "FoursquareAuthentication.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
		//check for foursquare and authorize
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if(![defaults objectForKey:@"access_token"]){
		[self.connectToFoursquare setHidden:NO];
	}
	else{
		[self.connectToFoursquare setHidden:YES];
	}

}

- (IBAction)connect:(id)sender {
	FoursquareAuthentication *controller = [[FoursquareAuthentication alloc] init];
	[self presentViewController:controller animated:NO completion:nil];
	[self.connectToFoursquare setHidden:YES];
}
@end
