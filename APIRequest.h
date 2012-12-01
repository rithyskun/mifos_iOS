//
//  APIRequest.h
//  HERD_CMF
//
//  Created by John Callaghan on 22/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>
#import "mifosViewController.h"
#import "mifosClientDetailViewViewController.h"
#import "mifosCreateClient.h"

@interface APIRequest : NSObject 

{   NSOperationQueue *queue;
    NSCache *cache;
    
    mifosViewController *parent;
    mifosClientDetailViewViewController *parentDetail;
    mifosCreateClient *parentCreate;
    
    BOOL auth;
    BOOL getClients;
    BOOL getLoanSummary;
     BOOL createClient;
    
    NSMutableDictionary *jsonSend;      
    NSMutableDictionary *jsonSend2;
    NSMutableDictionary *jsonSend3;
    
    NSURLConnection *connection;
    NSMutableData *responseData;
    NSURLConnection *conn;
    
    NSDate *date;
}
@property(nonatomic) BOOL createClient;
@property(nonatomic) BOOL auth;
@property(nonatomic) BOOL getClients;
@property(nonatomic) BOOL getLoanSummary;

@property (nonatomic) NSURLConnection *connection;
@property (nonatomic) NSDate *date; 
@property (nonatomic) NSMutableDictionary *jsonSend;  
@property (nonatomic) NSMutableDictionary *jsonSend2;
@property (nonatomic) NSMutableDictionary *jsonSend3;
@property (nonatomic) NSMutableData *responseData;

@property(nonatomic) mifosClientDetailViewViewController *parentDetail;
@property(nonatomic) mifosViewController *parent;
@property(nonatomic)  mifosCreateClient *parentCreate;

-(void) apiRequest:(NSString*) target meth:(NSString*) method string:(NSString*) sendString;

@end
