//
//  FBCDMasterViewController.h
//  FailedBankCD
//
//  Created by Developers on 5/15/15.
//  Copyright (c) 2015 BrylleSeraspeCollectionsCoreDataTutorial. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface FBCDMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
