//
//  mifosAppDelegate.h
//  mifosAPIExample
//
//  Created by John Callaghan on 01/12/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class mifosViewController;

#define APIPath @"https://demo.openmf.org/mifosng-provider/api/v1/"

@interface mifosAppDelegate : UIResponder <UIApplicationDelegate>

{
    IBOutlet UILabel *noInternet;
    IBOutlet UIButton *refresh;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navController;
@property (strong, nonatomic) mifosViewController *viewController;

@end
