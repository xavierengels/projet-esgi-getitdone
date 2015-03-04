//
//  TaskListViewController.h
//  projetesgi
//
//  Created by xavier engels on 04/03/2015.
//  Copyright (c) 2015 xavier engels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableTask;
@property (strong, nonatomic) NSMutableArray *tasks;
@property (weak, nonatomic) IBOutlet UITextField *fieldTask;

@end
