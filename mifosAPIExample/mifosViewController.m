//
//  mifosViewController.m
//  mifosAPIExample
//
//  Created by John Callaghan on 01/12/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "mifosViewController.h"
#import "APIRequest.h"
#import "mifosAppDelegate.h"
#import "mifosCreateClient.h"
#import "mifosClientDetailViewViewController.h"

@interface mifosViewController ()

@end

@implementation mifosViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    clientData = [[NSMutableArray alloc] init];
    // Release any retained subviews of the main view.
   // NSLog(@"all %@", [[NSUserDefaults standardUserDefaults] boolForKey:@"authDone"]);
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"authDone"]) 
    {
        [authDoneLabel setHidden:FALSE];
        [userLabel setHidden:FALSE];
        [apiCallButton setHidden:TRUE];
        NSString *usersavedValue = [[NSUserDefaults standardUserDefaults]
                                    stringForKey:@"userName"];
        NSString *userAppend = [@"User is " stringByAppendingString:usersavedValue];
        userLabel.text=userAppend;
    } 
	// Do any additional setup after loading the view, typically from a nib.
}


-(IBAction)getClients:(id)sender;

{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Getting clients";
    
    APIRequest *api = nil;
    api = [APIRequest alloc];
    api.parent = self;
    api.getClients=TRUE;
    NSString *req = [NSString stringWithFormat:@"%@%@", APIPath, @"clients"];
    [api apiRequest:req meth:@"GET" string:nil];
    
}

- (void)gotClients:(NSDictionary*) clients;

{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    

    for(id key in clients) 
    {
        [clientData addObject:key];
    }
        
    [clientList reloadData];
    //clientData = [clients allValues];
   //
   
}

#pragma mark UITableViewDelegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    
    return [clientData count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    //UIColor *darkGreenColor = [UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:103.0f/255.0f alpha:1.0f];
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"FaveRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:AutoCompleteRowIdentifier] ;
    }
    
    NSDictionary *content = [clientData objectAtIndex:indexPath.row];
    //NSLog(@"content %@", content);
   
    cell.textLabel.text =[content valueForKey:@"displayName"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSDictionary *content = [clientData objectAtIndex:indexPath.row];
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    mifosClientDetailViewViewController *detailViewController = [[mifosClientDetailViewViewController alloc] initWithNibName:@"mifosClientDetailViewViewController" bundle:nil];
    detailViewController.userName =    [content objectForKey:@"displayName"];
    detailViewController.officeName =    [content objectForKey:@"officeName"];
    NSString *idString = [[content objectForKey:@"id"] stringValue];
    detailViewController.userid=   idString;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

-(IBAction)createClient:(id)sender;
{
    mifosCreateClient *detailViewController = [[mifosCreateClient alloc] initWithNibName:@"mifosCreateClient" bundle:nil];

    [self.navigationController pushViewController:detailViewController animated:YES];
}
    

-(IBAction)hitAPIAuth:(id)sender;

{
    [self authGo];
}

-(void) authGo
{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Authenticating";
    
    APIRequest *api = nil;
    api = [APIRequest alloc];
    api.parent = self;
    api.auth=TRUE;
    NSString *req = [NSString stringWithFormat:@"%@%@", APIPath, @"authentication?username=mifos&password=password"];
    [api apiRequest:req meth:@"POST" string:nil];
  
}

- (void)error:(NSString*) errorString;

{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


- (void)authDone:(NSString*) string authKey:(NSString *)keyReturned

{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [authDoneLabel setHidden:FALSE];
    [userLabel setHidden:FALSE];
    [apiCallButton setHidden:TRUE];
    
    NSString *userAppend = [@"User is " stringByAppendingString:string];
    userLabel.text=userAppend;
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"authDone"];
    [[NSUserDefaults standardUserDefaults] setObject:keyReturned forKey:@"authKey"];
 
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
