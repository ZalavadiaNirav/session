//
//  SessionViewController.m
//  SessionExample
//
//  Created by C N Soft Net on 26/08/16.
//  Copyright © 2016 C N Soft Net. All rights reserved.
//

#import "SessionViewController.h"


@interface SessionViewController ()

@end
 
@implementation SessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.progressVw setProgress:0.0];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data Fetch using Get methods

-(IBAction)getMethod:(id)sender
{
    [self httpGetMethod];

}

-(void)httpGetMethod
{
    //define app security transport setting in plist
    
    NSURLSessionConfiguration *sessionConfigue=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:sessionConfigue delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url=[[NSURL alloc] initWithString:@"http://www.hayageek.com"];
    NSURLRequest *urlReq=[[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:urlReq completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error==nil)
        {
            NSString *responseStr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Respnoce Data using GET %@",responseStr);
        
        }
        
    }
     ];
    [dataTask resume];

}

#pragma mark - Data Fetch using POST methods


-(IBAction)postMethod:(id)sender
{
    NSURLSessionConfiguration *sessionConfigure=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:sessionConfigure delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url=[[NSURL alloc] initWithString:@"http://hayageek.com/examples/jquery/ajax-post/ajax-post.php"];
    NSMutableURLRequest *urlReq=[[NSMutableURLRequest alloc] initWithURL:url];
    
    NSString *parameters=@"name=nirav&loc=india&age=20&submit=True";
    
    
    [urlReq setHTTPMethod:@"POST"];
    [urlReq setHTTPBody:[parameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:urlReq completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSLog(@"Responce = %@  Error =%@",[response description],[error description]);
        if(error==nil)
        {
            NSString *responseStr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Respnoce Data using POST %@",responseStr);
            
        }
        
    }
    ];
    [dataTask resume];

}

#pragma mark - Download Files


-(IBAction)fileDownload:(id)sender
{

    NSURL *url = [NSURL URLWithString:@"http://manuals.info.apple.com/MANUALS/1000/MA1565/en_US/iphone_user_guide.pdf"];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURLSessionDownloadTask * downloadTask =[ defaultSession downloadTaskWithURL:url];
    [downloadTask resume];
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    float progress=totalBytesWritten*1.0/totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progressVw setProgress:progress animated:YES];

    });
    
    NSLog(@"Progress =%f",progress);
    NSLog(@"Received: %lld bytes (Downloaded: %lld bytes)  Expected: %lld bytes.\n",
          bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);

}

#pragma mark - Background Call

-(IBAction)backgroundCall:(id)sender
{
    NSURL *url=[NSURL URLWithString:@"http://www.apple.com/education/docs/Apple_ID_Parent_Guide.pdf"];

    
    NSURLSessionConfiguration *backgroundConfig=[NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"BackgroundTask1"];
    NSURLSession *backgroundSession=[NSURLSession sessionWithConfiguration:backgroundConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *dataTask=[backgroundSession downloadTaskWithURL:url];
    [dataTask resume];
    
}
/*
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    NSLog(@"### handler 1");
    
    completionHandler(NSURLSessionResponseAllow);
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Received String %@",str);
}
 */

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
        NSLog(@"Download is Succesfull");
    }
    else
        NSLog(@"Error %@",[error userInfo]);
}



- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    NSLog(@"Temporary File :%@\n", location);
    NSError *err = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    
    NSURL *docsDirURL = [NSURL fileURLWithPath:[docsDir stringByAppendingPathComponent:@"out1.zip"]];
    if ([fileManager moveItemAtURL:location
                             toURL:docsDirURL
                             error: &err])
    {
        NSLog(@"File is saved to =%@",docsDir);
    }
    else
    {
        NSLog(@"failed to move: %@",[err userInfo]);
    }

}

/*
 -(void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
 {
 AppDelegate *obj_app=[[UIApplication sharedApplication] delegate];
 if(obj_app.completionHANDLER)
 {
 void(^handler)()=obj_app.completionHANDLER;
 {
 handler();
 }
 }
 }
 */

@end
