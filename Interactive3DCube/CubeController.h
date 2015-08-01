//
//  CubeController.h
//  Interactive3DCube
//
//  Created by Ahmed Saad on 12/10/14.
//  Copyright (c) 2014 Ahmed Saad. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AbstractFaceViewController;
@interface CubeController : UIViewController

-(void) redrawCube;
/**
 *  Angular motion or not.
 */
@property (nonatomic)BOOL dynamicAngularDisplacment;

- (void)buildCube:(float)h ;
/**
 *  Add subview controller to the cube face 1.
 *
 *  @param viewController The subview controller.
 */
-(void)addSubViewControllerToFace1:(AbstractFaceViewController *)viewController;
/**
 *  Add subview controller to the cube face 2.
 *
 *  @param viewController The subview controller.
 */
-(void)addSubViewControllerToFace2:(AbstractFaceViewController *)viewController;
/**
 *  Add subview controller to the cube face 3.
 *
 *  @param viewController The subview controller.
 */
@property (weak, nonatomic) IBOutlet UIView *cubeContainer;
-(void)addSubViewControllerToFace3:(AbstractFaceViewController *)viewController;
/**
 *  Add subview controller to the cube face 4
 *
 *  @param viewController The subview controller.
 */
-(void)addSubViewControllerToFace4:(AbstractFaceViewController *)viewController;
-(void)addSubViewControllerToFace5:(AbstractFaceViewController *)viewController;
-(void)addSubViewControllerToFace6:(AbstractFaceViewController *)viewController;

-(NSArray*)getFaceViewController1;
-(NSArray *)getFaceViewController2;
-(NSArray *)getFaceViewController3;
-(NSArray *)getFaceViewController4;
-(void)switchToNonFreeAnimationMode;
-(void)switchToFreeAnimationMode;
//
-(void)setFace1ImageFromImage:(UIImage*)image;
-(void)setFace2ImageFromImage:(UIImage*)image;
-(void)setFace3ImageFromImage:(UIImage*)image;
-(void)setFace4ImageFromImage:(UIImage*)image;
-(void)setFace5ImageFromImage:(UIImage*)image;
//

-(void)setFace1ImageFromDir:(NSString*)imageDir;
-(void)setFace2ImageFromDir:(NSString*)imageDir;
-(void)setFace3ImageFromDir:(NSString*)imageDir;
-(void)setFace4ImageFromDir:(NSString*)imageDir;
-(void)setFace5ImageFromDir:(NSString*)imageDir;
//

-(void)setFace1ImageFromURL:(NSString*)imageURL;
-(void)setFace2ImageFromURL:(NSString*)imageURL;
-(void)setFace3ImageFromURL:(NSString*)imageURL;
-(void)setFace4ImageFromURL:(NSString*)imageURL;
-(void)setFace5ImageFromURL:(NSString*)imageURL;
//
@property BOOL isCubeAnimatnigByUser;
@property BOOL  isCubeAnimatnigAutomaticly;
@end
