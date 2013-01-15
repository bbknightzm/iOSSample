//
//  AppDelegate.h
//  NotificationTest
//
//  Created by bb on 1/7/13.
//  Copyright (c) 2013 bb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)createLocalNotification: (TimeValue *)time message:(NSString *)message title:(NSString *)title;

//- (void)scheduleNotificationWithItem:(ToDoItem *)item interval:(int)minutesBefore;

@end
