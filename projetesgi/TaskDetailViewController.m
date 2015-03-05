//
//  TaskDetailViewController.m
//  projetesgi
//
//  Created by xavier engels on 05/03/2015.
//  Copyright (c) 2015 xavier engels. All rights reserved.
//

#import "TaskDetailViewController.h"
#import "UITextField+Geometry.h"

@interface TaskDetailViewController ()
{
        NSString *selectRow;
        NSUInteger intRow;
}
@property (weak, nonatomic) IBOutlet UITextField *fieldName;

- (void)setupFromModel;
- (void)updateModelFromOutlets;
@end

@implementation TaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Connect data
    
        [self setupFromModel];
    NSManagedObjectContext *moc = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSFetchRequest *request2 = [NSFetchRequest fetchRequestWithEntityName:@"Todo"];
    
    NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Todo" inManagedObjectContext:moc];
    request2.resultType = NSDictionaryResultType;
    // alimentation du picker par les nom des projets
    request2.propertiesToFetch = [NSArray arrayWithObject:[[entity2 propertiesByName] objectForKey:@"name"]];
    request2.returnsDistinctResults = YES;
    
    _usernames = [moc executeFetchRequest:request2 error:nil];
    NSError *error;
    if (![moc save:&error]) {
        // Something's gone seriously wrong
        NSLog(@"Error saving new color: %@", [error localizedDescription]);
    }
    // NSLog (@"names: %@",_usernames);
    

    self.picker.dataSource = self;
    self.picker.delegate = self;
    //[_picker selectRow:intRow inComponent:0 animated:NO];
    if(selectRow==nil)
        selectRow=_usernames[0][@"name"];;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setProject:(Project *)project{
    _project = project;
    
    [self setupFromModel];
}
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
- (void)viewWillAppear:(BOOL)animated{
    [self.fieldName setPaddingLeftTo:5];
}
- (void)setupFromModel{
    
    self.fieldName.text  = self.project.nameP;
    //self.picker = self.project.identifierP;
  
}

- (void)updateModelFromOutlets{
    self.project.nameP = self.fieldName.text;
  self.project.identifierP = selectRow;
      NSLog(self.project.identifierP);
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
   
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
    return _usernames[row][@"name"];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    
//     NSLog(@"Selected Row %@", [self.usernames objectAtIndex:row]);
    selectRow= _usernames[row][@"name"];
  //  intRow = row;
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
