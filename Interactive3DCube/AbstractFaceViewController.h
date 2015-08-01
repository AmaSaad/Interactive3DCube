//
//  AbstractFaceViewController.h
//  Interactive3DCube
//
//  Created by Ahmed Saad on 12/12/14.
//  Copyright (c) 2014 Ahmed Saad. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CubeController;
@interface AbstractFaceViewController : UIViewController
- (IBAction)addImage:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *faceImage;
@property(strong,nonatomic) CubeController* cubeController;
@end
