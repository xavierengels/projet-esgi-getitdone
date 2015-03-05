

#import "TodoListViewController.h"
#import "TodoDetailViewController.h"
#import "ProjectViewController.h"
#import "Todo.h"

#define TODO_CELL_ID        @"TodoCellIdentifier"
#define SEGUE_TO_DETAIL_ID  @"ListToDetail"
#define SEGUE_TO_PROJECT_ID  @"ListToProject"

@interface TodoListViewController ()
@property (strong, nonatomic) Todo *selectedTodo;
@property (strong, nonatomic) Todo *editTodo;
//@property (strong, nonatomic) Project *ToProject;

@end

@implementation TodoListViewController



#pragma mark - Privates
- (void)setupModel{
    self.todos = [@[] mutableCopy];
}

- (void)configureOutlets{
    self.tableTodos.delegate = self;
    self.tableTodos.dataSource = self;
    
    self.dateFormatter = [NSDateFormatter new];
    self.dateFormatter.dateFormat = @"dd/MM/YYYY";
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupModel];
    [self configureOutlets];
    NSManagedObjectContext *moc = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Todo" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
   /*    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:sortDescriptors];*/
    // Fetch the records and handle an error
   NSError *error;
    self.todos = [[moc executeFetchRequest:request error:&error] mutableCopy];
    if (!self.todos) {
        // This is a serious error
        // Handle accordingly
        NSLog(@"Failed to load colors from disk");
    }
    
/*
    // retrieve the store URL
    NSURL * storeURL = [[moc persistentStoreCoordinator] URLForPersistentStore:[[[moc persistentStoreCoordinator] persistentStores] lastObject]];
    // lock the current context
    [moc lock];
    [moc reset];//to drop pending changes
    //delete the store from the current managedObjectContext
    if ([[moc persistentStoreCoordinator] removePersistentStore:[[[moc persistentStoreCoordinator] persistentStores] lastObject] error:&error])
    {
        // remove the file containing the data
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error];
        //recreate the store like in the  appDelegate method
        [[moc persistentStoreCoordinator] addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];//recreates the persistent store
    }
    [moc unlock];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableTodos reloadData];
}




#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SEGUE_TO_DETAIL_ID]){
      TodoDetailViewController *controller = segue.destinationViewController;
       controller.todo = self.selectedTodo;
    }
}

#pragma mark - Actions
- (IBAction)didTouchAddButton:(id)sender {
    if ([self.fieldTodo.text isEqualToString:@""])
        return;
    
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = ad.managedObjectContext;

    
    Todo *newTodo = [NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:moc];
   
    newTodo.name = self.fieldTodo.text;
    newTodo.dueDate = [self.dateFormatter stringFromDate:[NSDate date]];
    newTodo.done = false;
    NSError *error;
    if (![moc save:&error]) {
        // Something's gone seriously wrong
        NSLog(@"Error saving new color: %@", [error localizedDescription]);
    }
    [self.todos addObject:newTodo];
    [self.fieldTodo setText:@""];
    [moc save:nil];
    [self.tableTodos reloadData];
}
//find the parent cell
-(UITableViewCell *)parentCellForView:(id)theView
{
    id viewSuperView = [theView superview];
    while (viewSuperView != nil) {
        if ([viewSuperView isKindOfClass:[UITableViewCell class]]) {
            return (UITableViewCell *)viewSuperView;
        }
        else {
            viewSuperView = [viewSuperView superview];
        }
    }
    return nil;
}

- (IBAction)editButton:(id)sender {
    

    
    UIButton *butn = (UIButton *)sender;
    UITableViewCell *cell = [self parentCellForView:butn];
    if (cell != nil) {
        NSIndexPath *indexPath = [self.tableTodos indexPathForCell:cell];
       NSLog(@"show detail for item at row %ld", (long)indexPath.row);
        self.selectedTodo = self.todos[indexPath.row];
    }
}



#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.todos count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableTodos dequeueReusableCellWithIdentifier:TODO_CELL_ID];
    if (!cell) {
      //  cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TODO_CELL_ID];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
  
    Todo *currentTodo = self.todos[indexPath.row];
    cell.textLabel.text = currentTodo.name;
    cell.backgroundColor = (currentTodo.done)? [UIColor greenColor] : [UIColor lightGrayColor];
    cell.detailTextLabel.text = currentTodo.dueDate;
    return cell;
 
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}





- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //remove the deleted object from your data source.
        
        //If your data source is an NSMutableArray, do this
        
        [self.todos removeObjectAtIndex:indexPath.row];
        
        [tableView reloadData]; // tell table to refresh now
      
    }
}
#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     self.selectedTodo = self.todos[indexPath.row];
    [self performSegueWithIdentifier:SEGUE_TO_PROJECT_ID sender:self.selectedTodo];
    
  
    
}






@end
