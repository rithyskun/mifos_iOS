//
//  mifosCreateClient.m
//  mifosAPIExample
//
//  Created by John Callaghan on 01/12/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "APIRequest.h"
#import "mifosCreateClient.h"
#import "mifosAppDelegate.h"

@interface mifosCreateClient ()

@end

@implementation mifosCreateClient

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
    
    
    NSDate *today = [NSDate date];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    theDate = [dateFormatter  stringFromDate:today];
  
    // Do any additional setup after loading the view from its nib.
}


-(IBAction)dateDone:(id)sender;

{
    theDate =  [dateFormatter stringFromDate:[timePickerControl date]];
}

-(IBAction)go:(id)sender;
{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Creating Client";
    
    NSMutableDictionary *jsonSend = [[NSMutableDictionary alloc] init];  
    [jsonSend  setValue:firstName.text  forKey:@"firstname"];
    [jsonSend  setValue:secondName.text  forKey:@"lastname"];
    [jsonSend  setValue:theDate  forKey:@"joiningDate"];
    [jsonSend  setValue:@"en"  forKey:@"locale"];
    [jsonSend  setValue:@"dd MMM yyyy"  forKey:@"dateFormat"];
    //ned to get this office list at the start and show it, for now hardcoding
    [jsonSend  setValue:@"1"  forKey:@"officeId"];
    
    NSError *error=nil;
    NSString *addJSON = [jsonSend JSONStringWithOptions:JKSerializeOptionEscapeUnicode error:&error];
    
    NSString *req = [NSString stringWithFormat:@"%@%@", APIPath, @"clients"];
    
  //  NSLog(@"alertAddJSON  %@", addJSON );
    
    APIRequest *api = nil;
    api = [APIRequest alloc];
    api.parentCreate = self;
    api.createClient = TRUE;
    [api apiRequest:req meth:@"POST" string:addJSON];
    
    //NSLog(req);
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
   [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneCreate:(NSDictionary*) data;
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Done" message:@"Client Created!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
    [alert show];
    
   // NSLog(@"%@", data);
}

-(void)SaveDistance:(NSInteger)rowIndex
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

// Close keyboard when Enter or Done is pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField {    
	
    if (textField==firstName)
    {
        [firstName resignFirstResponder];
        [secondName becomeFirstResponder];
    } else {
        [secondName resignFirstResponder];
    }
    
    return YES;
} 


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
