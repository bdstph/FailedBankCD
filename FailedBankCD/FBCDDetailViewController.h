//
//  FBCDDetailViewController.h
//  FailedBankCD
//
//  Created by Developers on 5/19/15.
//  Copyright (c) 2015 BrylleSeraspeCollectionsCoreDataTutorial. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FailedBankInfo;

@interface FBCDDetailViewController : UIViewController

@property(nonatomic, weak) IBOutlet UITextField * nameTextField;
@property(nonatomic, weak) IBOutlet UITextField * stateTextField;
@property(nonatomic, weak) IBOutlet UITextField * cityTextField;
@property(nonatomic, weak) IBOutlet UITextField * zipTextField;
@property(nonatomic, weak) IBOutlet UILabel * closeDateLabel;
@property(nonatomic, weak) IBOutlet UILabel *tagsLabel;

@property(nonatomic, weak) IBOutlet UIButton * addUpdateButton;
@property(nonatomic, weak) IBOutlet UIBarButtonItem * deleteButton;

@property (nonatomic, weak) IBOutlet UIDatePicker * datePicker;

@property (nonatomic, strong) FailedBankInfo * bankInfo;

@end
