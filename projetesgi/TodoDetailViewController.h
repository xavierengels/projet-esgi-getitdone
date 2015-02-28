

#import <UIKit/UIKit.h>
#import "Todo.h"
#import "Project.h"
#import "AppDelegate.h"
@protocol RolePickerTVCellDelegate
- (void)roleWasSelectedOnPicker:(Project
*)role;
@end





@interface TodoDetailViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) Todo *todo;
@property (strong, nonatomic) Project *project;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (nonatomic, strong) Project *selectedRole;
@property (nonatomic, strong) NSArray *usernames;

@end
