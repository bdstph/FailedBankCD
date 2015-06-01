//
//  FBCDMasterViewControllerTableViewController.h
//  FailedBankCD
//
//  Created by Developers on 5/15/15.
//  Copyright (c) 2015 BrylleSeraspeCollectionsCoreDataTutorial. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBCDMasterViewController : UITableViewController<NSFetchedResultsControllerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
