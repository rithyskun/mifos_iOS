//
//  mifosClientDetailViewViewController.m
//  mifosAPIExample
//
//  Created by John Callaghan on 01/12/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "mifosAppDelegate.h"
#import "APIRequest.h"
#import "mifosClientDetailViewViewController.h"

@interface mifosClientDetailViewViewController ()

@end

@implementation mifosClientDetailViewViewController

@synthesize userName, officeName, userid;

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
    
    name.text=userName;
    officeLabel.text  = officeName;
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)getLoanSummary:(id)sender;

{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Getting loan info";
    
    APIRequest *api = nil;
    api = [APIRequest alloc];
    api.parentDetail = self;
    api.getLoanSummary = TRUE;
  
    NSString *clientId  = [@"clients/" stringByAppendingString:userid];
    clientId = [clientId stringByAppendingString:@"/loans?tenantIdentifier=default&pretty=true"];
  
    NSString *req = [NSString stringWithFormat:@"%@%@", APIPath, clientId];
    [api apiRequest:req meth:@"GET" string:nil];
    NSLog(req);
}

- (void)gotLoanSummary:(NSDictionary*) clients;
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [activeLoanCountHeading setHidden:NO];
    activeLoanCount.text=[[clients objectForKey:@"activeLoanCount"] stringValue];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
