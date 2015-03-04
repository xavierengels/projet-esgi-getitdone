
#import "TodoDetailViewController.h"
#import "UITextField+Geometry.h"
#import "Project.h"
@interface TodoDetailViewController ()
{
    NSArray *_pickerData;
    NSMutableArray *array1;
    NSUInteger *selectRow;
}
@property (weak, nonatomic) IBOutlet UISwitch *switchDone;
@property (weak, nonatomic) IBOutlet UITextField *fieldName;
@property (weak, nonatomic) IBOutlet UITextView *txtDetails;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *dpDueDate;
@property (weak, nonatomic) IBOutlet UITextField *textSelect;

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
    self.textSelect.delegate = self;
    
    // Connect data
  
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = ad.managedObjectContext;
    
  
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Project"];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Project" inManagedObjectContext:moc];
    request.resultType = NSDictionaryResultType;
    request.propertiesToFetch = [NSArray arrayWithObject:[[entity propertiesByName] objectForKey:@"nameP"]];
    request.returnsDistinctResults = YES;
    
    _usernames = [moc executeFetchRequest:request error:nil];
    
  //  NSLog (@"names: %@",_usernames);
 
 
    self.picker.dataSource = self;
    self.picker.delegate = self;
  
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
    NSUInteger num = [[self.pickerView dataSource] numberOfComponentsInPickerView:self.pickerView];
    NSMutableString *text = [NSMutableString string];
    for(NSUInteger i =0;i<num;++i)
    {
        NSUInteger selectRow = [self.pickerView selectedRowInComponent:i];
        NSString *ww = [[self.pickerView delegate] pickerView:self.pickerView titleForRow:selectRow forComponent:i];
        [text appendFormat:@"%@",ww];
        NSLog(@"%@",text);
        //self.todo.relationship = [NSSet setWithObject:ww];
    }
    NSMutableSet *items = [self.todo.relationship mutableSetValueForKey:text];
    [items addObject:self.todo.relationship];
}

#pragma mark - Privates
- (void)setupFromModel{

    self.switchDone.on   = self.todo.done;
    self.fieldName.text  = self.todo.name;
    self.txtDetails.Text = self.todo.details;
    self.dpDueDate.date = [self.dateFormatter dateFromString:self.todo.dueDate];
   // self.pickerView.textInputContextIdentifier=self.todo.rela
}

- (void)updateModelFromOutlets{
   // self.todo.done = self.switchDone.isOn;

    self.todo.name = self.fieldName.text;
    self.todo.details = self.txtDetails.text;
    self.todo.dueDate = [self.dateFormatter stringFromDate:self.dpDueDate.date];
    
  
   
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //One column
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //set number of rows
    return _usernames.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //set item per row
   return _usernames[row][@"nameP"];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{

   // NSLog(@"Selected Row %@", [self.usernames objectAtIndex:row]);
    selectRow= row;

}

@end
