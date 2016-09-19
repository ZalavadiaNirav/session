//
//  SessionViewController.h
//  SessionExample
//
//  Created by C N Soft Net on 26/08/16.
//  Copyright © 2016 C N Soft Net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class AppDelegate;
@interface SessionViewController : UIViewController <NSURLSessionDelegate,NSURLSessionDownloadDelegate,NSURLSessionDataDelegate>
{

}

@property (weak, nonatomic) IBOutlet UIProgressView *progressVw;

-(IBAction)getMethod:(id)sender;

-(IBAction)postMethod:(id)sender;

-(IBAction)fileDownload:(id)sender;

-(IBAction)backgroundCall:(id)sender;

@end
