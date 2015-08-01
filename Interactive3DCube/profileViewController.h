//
//  ViewController.h
//  Interactive3DCube
//
//  Created by Ahmed Saad on 12/10/14.
//  Copyright (c) 2014 Ahmed Saad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileData.h"
@interface profileViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
- (IBAction)addCubeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *profileNameField;

@property (weak, nonatomic) IBOutlet UIButton *addCubeAction;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property ProfileData * data;
@property (nonatomic)BOOL viewMode;
@end

