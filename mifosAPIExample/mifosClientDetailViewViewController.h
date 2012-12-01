//
//  mifosClientDetailViewViewController.h
//  mifosAPIExample
//
//  Created by John Callaghan on 01/12/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mifosClientDetailViewViewController : UIViewController
{
     NSString *userName;
     NSString *officeName;
     NSString *userid;
     IBOutlet UILabel *name;
     IBOutlet UILabel *officeLabel;
     IBOutlet UILabel *activeLoanCount;
     IBOutlet UILabel *activeLoanCountHeading;
     MBProgressHUD *hud;
}

@property(nonatomic) NSString *officeName;
@property(nonatomic) NSString *userName;
@property(nonatomic) NSString *userid;

-(IBAction)getLoanSummary:(id)sender;
- (void)gotLoanSummary:(NSDictionary*) clients;

@end
