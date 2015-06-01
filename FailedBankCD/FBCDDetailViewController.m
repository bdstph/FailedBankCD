//
//  FBCDDetailViewController.m
//  FailedBankCD
//
//  Created by Developers on 5/19/15.
//  Copyright (c) 2015 BrylleSeraspeCollectionsCoreDataTutorial. All rights reserved.
//

#import "FBCDDetailViewController.h"

#import "FailedBankInfo.h"
#import "FailedBankDetails.h"
#import "FBCDTagListTableViewController.h"

@interface FBCDDetailViewController ()
- (void)hidePicker;
- (void)showPicker;
@end

@implementation FBCDDetailViewController

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
    // Do any additional setup after loading the view.
    
    // setting interaction on date label
    _closeDateLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *dateTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(dateTapped)];
    [_closeDateLabel addGestureRecognizer:dateTapRecognizer];
    // set date picker handler
    [_datePicker addTarget:self action:@selector(dateHasChanged:)
         forControlEvents:UIControlEventValueChanged];
    
    _tagsLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tagsTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(tagsTapped)];
    [_tagsLabel addGestureRecognizer:tagsTapRecognizer];
    
    _tagsLabel.backgroundColor = _closeDateLabel.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_bankInfo != nil) { // Update
        [_addUpdateButton setTitle:@"Update" forState:UIControlStateNormal];
        [self setScreenValues];
        
    }
    else { // Add
        self.navigationItem.rightBarButtonItem = nil;
        
    }
    
    NSSet *tags = _bankInfo.details.tags;
    NSMutableArray *tagNamesArray = [[NSMutableArray alloc] initWithCapacity:tags.count];
    for (Tag *tag in tags) {
        [tagNamesArray addObject:tag.name];
    }
    _tagsLabel.text = [tagNamesArray componentsJoinedByString:@","];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - private functions

- (void)setScreenValues
{
    FailedBankDetails *details = _bankInfo.details;
    
    [_nameTextField setText:_bankInfo.name];
    [_stateTextField setText:_bankInfo.state];
    [_cityTextField setText:_bankInfo.city];
    [_zipTextField setText:[details.zip stringValue]];
    [_closeDateLabel setText:[self stringFromDate:details.closeDate format:@"yyyy-MM-dd"]];
}

- (NSString *)stringFromDate:(NSDate*)date_ format:(NSString *)format_
{
    NSString *dateString = nil;
    
    NSDateFormatter *dateFormattter = [NSDateFormatter new];
    dateFormattter.dateFormat = format_;
    
    dateString = [dateFormattter stringFromDate:date_];
    
    return dateString;
}

- (NSDate *)dateFromString:(NSString*)dateString_ format:(NSString *)format_
{
    NSDate *date = nil;
    
    NSDateFormatter *dateFormattter = [NSDateFormatter new];
    dateFormattter.dateFormat = format_;
    
    date = [dateFormattter dateFromString:dateString_];
    
    return date;
}

- (void)dateTapped
{
    [self showPicker];
}

- (void)dateHasChanged:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    _closeDateLabel.text = [formatter stringFromDate:_datePicker.date];
    
}

- (void)showPicker
{
    [_nameTextField resignFirstResponder];
    [_stateTextField resignFirstResponder];
    [_cityTextField resignFirstResponder];
    [_zipTextField resignFirstResponder];
    
    [UIView beginAnimations:@"SlideInPicker" context:nil];
	[UIView setAnimationDuration:0.5];
	_datePicker.transform = CGAffineTransformMakeTranslation(0, -216);
	[UIView commitAnimations];
}

- (void)hidePicker
{
    [UIView beginAnimations:@"SlideOutPicker" context:nil];
	[UIView setAnimationDuration:0.5];
	_datePicker.transform = CGAffineTransformMakeTranslation(0, 216);
	[UIView commitAnimations];
}

- (void)tagsTapped
{
    FBCDTagListTableViewController *tagPicker = [[FBCDTagListTableViewController alloc] initWithBankDetails:_bankInfo.details];
    [self.navigationController pushViewController:tagPicker animated:YES];
}


#pragma mark - IBActions

- (IBAction)clickedAddUpdate:(id)sender
{
    NSError *error = nil;
    
    NSString *name = _nameTextField.text;
    if (name == nil || [name length] == 0) {
        name = _nameTextField.placeholder;
    }
    
    NSString *city = _cityTextField.text;
    if (city == nil || [city length] == 0) {
        city = _cityTextField.placeholder;
    }
    
    NSString *state = _stateTextField.text;
    if (state == nil || [state length] == 0) {
        state = _stateTextField.placeholder;
    }
    
    NSString *zip = _zipTextField.text;
    if (zip == nil || [zip length] == 0) {
        zip = _zipTextField.placeholder;
    }
    
    NSString *closeDateString = _closeDateLabel.text;
    if (closeDateString == nil || [closeDateString length] == 0) {
        closeDateString = @"2015-01-01";
    }
    NSDate *closeDate = [self dateFromString:closeDateString format:@"yyyy-MM-dd"];
    
    NSDate *updateDate = [NSDate date];
    
    _bankInfo.name = name;
    _bankInfo.city = city;
    _bankInfo.state = state;
    FailedBankDetails *failedBankDetails = _bankInfo.details;
    failedBankDetails.zip = [NSNumber numberWithInt:12345];
    failedBankDetails.closeDate = closeDate;
    failedBankDetails.updateDate = updateDate;
    failedBankDetails.info = _bankInfo;
    
    if (![_bankInfo.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickedDelete:(id)sender
{
    NSError *error = nil;
    
    [_bankInfo.managedObjectContext deleteObject:_bankInfo];
    
    if (![_bankInfo.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
