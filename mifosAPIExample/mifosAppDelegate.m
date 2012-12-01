//
//  mifosAppDelegate.m
//  mifosAPIExample
//
//  Created by John Callaghan on 01/12/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "mifosAppDelegate.h"
#import "Reachability.h"
#import "mifosViewController.h"

@implementation mifosAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize navController = _navController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    if (![self CheckInternetConnection])
	{
        noInternet.hidden=FALSE;
        refresh.hidden=FALSE;
        
    } else  {
        
        [self startup];
    }
    
    return YES;
}

-(void) startup
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[mifosViewController alloc] initWithNibName:@"mifosViewController" bundle:nil];
     _navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    [self.window addSubview:_navController.view];
    [self.window makeKeyAndVisible];
}

-(IBAction)refresh:(id)sender;

{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.google.com"];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
    
	if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN))
	{
        
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Internet Connection detected" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [myAlert show];
        noInternet.hidden=FALSE;
        refresh.hidden=FALSE;
		
	} else {
        
        refresh.hidden=TRUE;
        noInternet.hidden=TRUE;
        [self startup];
        
    }
    
}

-(BOOL)CheckInternetConnection
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.google.com"];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
    
    if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN))
	{
        return NO;
    }
    else {
        return YES;
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
