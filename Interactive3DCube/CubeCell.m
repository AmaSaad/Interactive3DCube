//
//  CubeCell.m
//  Interactive3DCube
//
//  Created by Ahmed Saad on 12/15/14.
//  Copyright (c) 2014 Ahmed Saad. All rights reserved.
//

#import "CubeCell.h"
#import "CubeController.h"
@class CubeController;

@implementation CubeCell{
    CubeController * myCube;
    __weak IBOutlet UIView *myview;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCube:(CubeController*) cube{
    myCube=cube;
    [myview addSubview:cube.view];
//    NSLayoutConstraint* constraint= [NSLayoutConstraint constraintWithItem:cube.view
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:nil
//                                                                 attribute:0
//                                                                multiplier:1.0
//                                                                  constant:175.0f];
//    constraint.priority=UILayoutPriorityDefaultHigh;
//    [cube.view addConstraint:constraint];
    [cube.view layoutIfNeeded];
    
}
-(CubeController*) getCube{return myCube;}

@end
