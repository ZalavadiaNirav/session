//
//  AppDelegate.h
//  SessionExample
//
//  Created by C N Soft Net on 26/08/16.
//  Copyright © 2016 C N Soft Net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionViewController.h"

@class SessionViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic)  UIWindow *window;

@property (nonatomic,retain) UINavigationController *navController;

@property(nonatomic,retain) SessionViewController *obj;

@property id completionHANDLER;


@end

