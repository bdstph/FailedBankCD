//
//  FBCDDetailViewController.m
//  FailedBankCD
//
//  Created by Developers on 5/15/15.
//  Copyright (c) 2015 BrylleSeraspeCollectionsCoreDataTutorial. All rights reserved.
//

#import "FBCDDetailViewController.h"

@interface FBCDDetailViewController ()
- (void)configureView;
@end

@implementation FBCDDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
