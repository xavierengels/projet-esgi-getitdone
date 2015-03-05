//
//  TaskListViewController.h
//  projetesgi
//
//  Created by xavier engels on 04/03/2015.
//  Copyright (c) 2015 xavier engels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Todo.h"
@interface TaskListViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableTask;
@property (strong, nonatomic) NSMutableArray *tasks;
@property (weak, nonatomic) IBOutlet UITextField *fieldTask;
@property (strong, nonatomic) Todo *projet;
@end
