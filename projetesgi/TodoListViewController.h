

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Project.h"
#import "Todo.h"
@interface TodoListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    AppDelegate *app;
    NSManagedObjectContext *context;
}

@property (weak, nonatomic) IBOutlet UILabel *percent;



@property (weak, nonatomic) IBOutlet UITableView *tableTodos;
@property (weak, nonatomic) IBOutlet UITextField *fieldTodo;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@property (strong, nonatomic) NSMutableArray *todos;
@property (strong, nonatomic) Project *project;
@property (nonatomic) NSArray *selectedProject;
//@property (copy) void (^blockProperty)(void);
@end

