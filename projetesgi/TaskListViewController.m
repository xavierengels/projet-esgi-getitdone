//
//  ProjectViewController.m
//  TodoList
//
//  Created by xavier engels on 11/02/2015.
//
//

#import "TaskListViewController.h"
#import "TaskDetailViewController.h"
#define PROJECT_CELL_ID        @"TaskCellIdentifier"
#import "AppDelegate.h"
#import "Project.h"

#import "TodoListViewController.h"
#define SEGUE_TO_TASK_ID  @"ListToEditTask"
@interface TaskListViewController ()
@property (strong, nonatomic) Project *selectedProject;
@end

@implementation TaskListViewController

- (void)setupModel{
    self.tasks = [@[] mutableCopy];
}
- (void)configureOutlets{
    self.tableTask.delegate = self;
    self.tableTask.dataSource = self;
    
    
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupModel];
    [self configureOutlets];
    NSManagedObjectContext *moc = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Project" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
 
    NSError *error;
    self.tasks = [[moc executeFetchRequest:request error:&error] mutableCopy];
    if (!self.tasks) {
        // This is a serious error
        // Handle accordingly
        NSLog(@"Failed to load colors from disk");
    }
   

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableTask reloadData];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if([segue.identifier isEqualToString:SEGUE_TO_TASK_ID])
    {
        
        TaskDetailViewController *controller = (TaskDetailViewController*)segue.destinationViewController;
        controller.task = self.selectedProject;
        
        NSLog(controller.task.nameP);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTouchAddButton:(id)sender {
    
    if ([self.fieldTask.text isEqualToString:@""])
        return;
    
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = ad.managedObjectContext;
    
    
    Project *newProject = [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:moc];
    
    newProject.nameP = self.fieldTask.text;
    NSError *error;
    if (![moc save:&error]) {
        // Something's gone seriously wrong
        NSLog(@"Error saving new color: %@", [error localizedDescription]);
    }
    [self.tasks addObject:newProject];
    [self.fieldTask setText:@""];
    [moc save:nil];
    [self.tableTask reloadData];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tasks.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableTask dequeueReusableCellWithIdentifier:PROJECT_CELL_ID];
    
    
    Project *currentProject = self.tasks[indexPath.row];
    NSLog(@"%@",currentProject);
    cell.textLabel.text = currentProject.nameP;
    return cell;
    
}
#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedProject = self.tasks[indexPath.row];
    NSLog(@"show detail for item at row %ld", (long)indexPath.row);
  [self performSegueWithIdentifier:SEGUE_TO_TASK_ID sender:self];
    //TaskDetailViewController *controller = (TaskDetailViewController*)segue.destinationViewController;
    //controller.project = self.selectedProject;

    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //One column
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //remove the deleted object from your data source.
        
        //If your data source is an NSMutableArray, do this
        
        NSError * error = nil;
        [self.tasks removeObjectAtIndex:indexPath.row];
        NSManagedObjectContext *moc = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Project" inManagedObjectContext:moc];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"nameP" ascending:NO];
        
        [request setSortDescriptors:[NSArray arrayWithObject:sort]];
        
        [request setFetchBatchSize:20];
        NSManagedObject *matches = nil;
        NSArray *objects = [moc executeFetchRequest:request error:&error];
        matches=[objects objectAtIndex:([indexPath row])];
        NSLog(@"Value delete%@",matches);
        [moc deleteObject:matches];
        [moc save:&error];
        [tableView reloadData];
        
    }
}




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
