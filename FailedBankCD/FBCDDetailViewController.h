//
//  FBCDDetailViewController.h
//  FailedBankCD
//
//  Created by Developers on 5/15/15.
//  Copyright (c) 2015 BrylleSeraspeCollectionsCoreDataTutorial. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBCDDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
