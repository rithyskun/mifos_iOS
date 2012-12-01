//
//  mifosCreateClient.h
//  mifosAPIExample
//
//  Created by John Callaghan on 01/12/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>

@interface mifosCreateClient : UIViewController  <UITextFieldDelegate, UIGestureRecognizerDelegate,UIPickerViewDataSource, UIPickerViewDelegate> 
{
     IBOutlet UIDatePicker *timePickerControl;
    IBOutlet UITextField *firstName;
    IBOutlet UITextField *secondName;
    MBProgressHUD *hud;
    NSString * theDate;
    NSDateFormatter* dateFormatter;
}

-(IBAction)go:(id)sender;
-(IBAction)dateDone:(id)sender;
- (void)doneCreate:(NSDictionary*) data;

@end
