

#import <UIKit/UIKit.h>
#import "Todo.h"
#import "Project.h"
#import "AppDelegate.h"






@interface TodoDetailViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) Todo *todo;
@property (strong, nonatomic) Project *project;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;


@property (nonatomic, strong) NSArray *usernames;

@end
