//
//  FBCDSearchViewController.m
//  FailedBankCD
//
//  Created by Developers on 6/5/15.
//  Copyright (c) 2015 BrylleSeraspeCollectionsCoreDataTutorial. All rights reserved.
//

#import "FBCDSearchViewController.h"

@interface FBCDSearchViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation FBCDSearchViewController

@synthesize managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize searchBar,tView;
@synthesize noResultsLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
    self.tView.delegate = self;
    self.tView.dataSource = self;
    
    noResultsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 200, 30)];
    [self.view addSubview:noResultsLabel];
    noResultsLabel.text = @"No Results";
    [noResultsLabel setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Error in search %@, %@", error, [error userInfo]);
        
	} else {
        [self.tView reloadData];
        [self.searchBar resignFirstResponder];
        [noResultsLabel setHidden:_fetchedResultsController.fetchedObjects.count > 0];
        
    }
}


#pragma mark - private functions

- (IBAction)closeSearch
{
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    // Create fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FailedBankInfo"
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"details.closeDate" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setFetchBatchSize:20];
    
    // Create predicate
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@", self.searchBar.text];
    //NSPredicate *pred = [NSPredicate predicateWithFormat:@"name == %@", self.searchBar.text];
    //NSPredicate *pred = [NSPredicate predicateWithFormat: @"details.zip ENDSWITH %@", self.searchBar.text];
    
    /*
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:self.searchBar.text];
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"details.closeDate > %@", date];
     */
    
    //NSPredicate *pred = [NSPredicate predicateWithFormat: @"details.tags.@count > 0"];
    
    /*
    NSArray *queryArray = nil;
    if ([self.searchBar.text rangeOfString:@":"].location != NSNotFound) {
        queryArray = [self.searchBar.text componentsSeparatedByString:@":"];
    }
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name CONTAINS[c] %@) AND (city CONTAINS[c] %@)", [queryArray objectAtIndex:0], [queryArray objectAtIndex:1]];
    */
    
    [fetchRequest setPredicate:pred];
     
    // Create fetched results controller
    NSFetchedResultsController *frController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                   managedObjectContext:managedObjectContext
                                                                                     sectionNameKeyPath:nil
                                                                                              cacheName:nil]; // better to not use cache
    self.fetchedResultsController = frController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id  sectionInfo =
    [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
    
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    FailedBankInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = info.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",
                                 info.city, info.state];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

@end
