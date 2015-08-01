//
//  CubeCell.h
//  Interactive3DCube
//
//  Created by Ahmed Saad on 12/15/14.
//  Copyright (c) 2014 Ahmed Saad. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CubeController;
@interface CubeCell : UITableViewCell
-(void)setCube:(CubeController*) cube;
-(CubeController*) getCube;
@end
