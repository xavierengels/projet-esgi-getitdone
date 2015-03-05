//
//  TaskDetailViewController.h
//  projetesgi
//
//  Created by xavier engels on 05/03/2015.
//  Copyright (c) 2015 xavier engels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Project.h"
#import "Todo.h"
@interface TaskDetailViewController : UIViewController
@property (nonatomic, strong) NSArray *usernames;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) Project *project;

@end
