//
//  FBCDTagListTableViewController.h
//  FailedBankCD
//
//  Created by Developers on 6/1/15.
//  Copyright (c) 2015 BrylleSeraspeCollectionsCoreDataTutorial. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FailedBankDetails.h"
#import "Tag.h"

@interface FBCDTagListTableViewController : UITableViewController<UIAlertViewDelegate>

@property (nonatomic, strong) FailedBankDetails *bankDetails;
@property (nonatomic, strong) NSMutableSet *pickedTags;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

- (id)initWithBankDetails:(FailedBankDetails *)details;

@end
