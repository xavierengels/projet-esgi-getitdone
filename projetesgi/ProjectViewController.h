//
//  ProjectViewController.h
//  TodoList
//
//  Created by xavier engels on 11/02/2015.
//
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "AppDelegate.h"
@interface ProjectViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITableView *tableProject;
@property (strong, nonatomic) NSMutableArray *projects;
@property (weak, nonatomic) IBOutlet UITextField *fieldProject;
@property (strong, nonatomic) NSDateFormatter *dateFormatterP;
@property (strong, nonatomic)  Todo *project;

@end
