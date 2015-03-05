
#import "TodoDetailViewController.h"
#import "UITextField+Geometry.h"
#import "Project.h"
@interface TodoDetailViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *switchDone;
@property (weak, nonatomic) IBOutlet UITextField *fieldName;
@property (weak, nonatomic) IBOutlet UITextView *txtDetails;
@property (weak, nonatomic) IBOutlet UIDatePicker *dpDueDate;


@property (strong, nonatomic) Project *selectedProject;
- (void)setupFromModel;
- (void)updateModelFromOutlets;
@end

@implementation TodoDetailViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateFormatter = [NSDateFormatter new];
    self.dateFormatter.dateFormat = @"dd/MM/YYYY";
 
  
    [self setupFromModel];
  
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.fieldName setPaddingLeftTo:5];
}

#pragma mark - Overrides
- (void)setTodo:(Todo *)todo{
    _todo = todo;
    
    [self setupFromModel];
}

#pragma mark - Actions
- (IBAction)updateAction:(id)sender {
    [self updateModelFromOutlets];
    [self.navigationController popViewControllerAnimated:YES];
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = ad.managedObjectContext;
    NSError *error;
    if (![moc save:&error]) {
        // Something's gone seriously wrong
        NSLog(@"Error saving new color: %@", [error localizedDescription]);
    }

}

#pragma mark - Privates
- (void)setupFromModel{

    self.switchDone.on   = self.todo.done;
    self.fieldName.text  = self.todo.name;
    self.txtDetails.Text = self.todo.details;
    
    
    //self.dpDueDate.date  = (self.todo.dueDate)? self.todo.dueDate : [NSDate date];
    //self.switchDone.on   = [self.todo.done boolValue];

    //NSLog(@"Le bool recuperer %i",self.switchDone.on);
}

- (void)updateModelFromOutlets{
   // self.todo.done = self.switchDone.isOn;

    self.todo.name = self.fieldName.text;
    self.todo.details = self.txtDetails.text;
    self.todo.dueDate = [self.dateFormatter stringFromDate:self.dpDueDate.date];

    
    
    NSLog(@"La valeur nouvelle %@",self.dpDueDate.date);
    NSLog(@"La valeur actuelle %@",self.todo.dueDate);

    
 

  
   
}


@end
