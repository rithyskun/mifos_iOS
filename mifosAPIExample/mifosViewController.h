//
//  mifosViewController.h
//  mifosAPIExample
//
//  Created by John Callaghan on 01/12/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>

@interface mifosViewController : UIViewController  <UITableViewDelegate>
{
        IBOutlet UIButton *apiCallButton;
        IBOutlet UILabel *authDoneLabel;
        IBOutlet UILabel *userLabel;
        MBProgressHUD *hud;
        NSMutableArray *clientData;
        IBOutlet  UITableView *clientList;
}

- (void)gotClients:(NSDictionary*) clients;
- (void)authDone:(NSString*) string authKey:(NSString *)keyReturned;
- (void)error:(NSString*) errorString;

-(IBAction)hitAPIAuth:(id)sender;
-(IBAction)getClients:(id)sender;
-(IBAction)createClient:(id)sender;

@end
