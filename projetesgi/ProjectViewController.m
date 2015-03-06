//
//  ProjectViewController.m
//  TodoList
//
//  Created by xavier engels on 11/02/2015.
//
//

#import "ProjectViewController.h"
#define PROJECT_CELL_ID        @"ProjectCellIdentifier"
#define SEGUE_TO_TASK_ID     @"editToTaskTwo"
#import "AppDelegate.h"
#import "Project.h"
#import "Todo.h"
#import "TodoListViewController.h"
#import "TaskDetailViewController.h"
@interface ProjectViewController ()
@property (strong, nonatomic) Project *selectedProject;
@end

@implementation ProjectViewController

- (void)setupModel{
    self.projects = [@[] mutableCopy];
}
- (void)configureOutlets{
    self.tableProject.delegate = self;
    self.tableProject.dataSource = self;
    
    
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
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"identifierP == %@", _project.name];
    [request setPredicate:predicate];
    self.projects = [[moc executeFetchRequest:request error:&error] mutableCopy];
    
    NSLog(@"%@",_project.name);

  //  NSLog(@"%@",[[self.projects objectAtIndex:0]valueForKey:@"_project.name"]);
    if (!self.projects) {
        // This is a serious error
        // Handle accordingly
        NSLog(@"Failed to load colors from disk");
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableProject reloadData];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:SEGUE_TO_TASK_ID])
    { NSLog(@"test");
        TaskDetailViewController *controller=(TaskDetailViewController *)segue.destinationViewController;
     
        //Or rather just save the indexPath in a property in your currentViewController when you get the accessoryButtonTappedForRowAtIndexPath callback, and use it here
        controller.task = self.selectedProject;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTouchAddButton:(id)sender {
    
    if ([self.fieldProject.text isEqualToString:@""])
        return;
    
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = ad.managedObjectContext;
    
  //
    Project *newProject = [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:moc];
    newProject.identifierP=self.project.name;
    newProject.nameP = self.fieldProject.text;
    NSError *error;
    if (![moc save:&error]) {
        // Something's gone seriously wrong
        NSLog(@"Error saving new color: %@", [error localizedDescription]);
    }
    [self.projects addObject:newProject];
    [self.fieldProject setText:@""];
    [moc save:nil];
    [self.tableProject reloadData];

  

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.projects.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableProject dequeueReusableCellWithIdentifier:PROJECT_CELL_ID];
    
        
        Project *currentProject = self.projects[indexPath.row];
        cell.textLabel.text = currentProject.nameP;
        return cell;

}
#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
    self.selectedProject = self.projects[indexPath.row];
      [self performSegueWithIdentifier:SEGUE_TO_TASK_ID sender:self];
 
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //remove the deleted object from your data source.
        
        //If your data source is an NSMutableArray, do this
        
        NSError * error = nil;
        [self.projects removeObjectAtIndex:indexPath.row];
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
