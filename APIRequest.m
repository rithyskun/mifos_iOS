//
//  APIRequest.m
//  HERD_CMF
//
//  Created by John Callaghan on 22/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "APIRequest.h"


@implementation APIRequest 

@synthesize connection;
@synthesize date; 
@synthesize jsonSend;  
@synthesize jsonSend2;
@synthesize jsonSend3,getLoanSummary;
@synthesize responseData,auth;
@synthesize parent,getClients,parentDetail,createClient,parentCreate;


- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"init api");
        // Initialization code here.
    }
    
    return self;
}

-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *) data {
  
	[responseData appendData:data];
}

-(void) connection:(NSURLConnection *) connection didFailWithError:(NSError *) error {
	
    
    [parent error:@"Unexpected System Error"];
    
    
    //[delegate hudhide];
      
    [connection cancel];
 
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",[error localizedDescription],[[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
  
}



- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
   
    return nil;
}



-(void) apiRequest:(NSString*) target meth:(NSString*) method string:(NSString*) sendString

{
   
    NSURL *url = [NSURL URLWithString:target];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
    NSData *requestData = [NSData dataWithBytes:[sendString UTF8String] length:[sendString length]];
    //NSLog(@"sendString%@", sendString);
    [request setHTTPMethod:method];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:@"default" forHTTPHeaderField:@"X-Mifos-Platform-TenantId"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    if (getClients || getLoanSummary || createClient)
    {
     
        //NSString *authStringValue = [[NSUserDefaults standardUserDefaults]
                                    //stringForKey:@"authString"];
        NSString *authStringValue = @"bWlmb3M6cGFzc3dvcmQ=";
         
        NSString *authString = [@"Basic " stringByAppendingString:authStringValue];
        [request setValue:authString forHTTPHeaderField:@"Authorization"];
   
    }
    
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];

    NSURLConnection *tmpConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    if (tmpConnection) {
        responseData = [NSMutableData data];
    }
    
    self.connection = tmpConnection;
   
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection

{
    NSString *theJSON = [[NSString alloc] 
               initWithBytes: [responseData mutableBytes] 
               length:[responseData length] 
               encoding:NSUTF8StringEncoding];
    
    NSDictionary *deserializedData = [theJSON objectFromJSONString];
    NSLog(@"deserializedData  %@",  deserializedData );
    NSString *errorcheck = [deserializedData  valueForKey:@"errorcode"];
    
    if (auth)
    {
        
        //NSLog(@"username %@",  [deserializedData  valueForKey:@"username"]);
        //NSLog(@"base64EncodedAuthenticationKey %@",  [deserializedData  valueForKey:@"base64EncodedAuthenticationKey"]);
        
        [parent authDone:[deserializedData  valueForKey:@"username"] authKey:[deserializedData  valueForKey:@"base64EncodedAuthenticationKey"] ];
        
    } else if (getClients) {
        
              [parent gotClients:deserializedData];
        
    } else if(getLoanSummary){
             
              [parentDetail gotLoanSummary:deserializedData];  
    } else if (createClient) {
            [parentCreate doneCreate:deserializedData];  
    }
    
}

@end
