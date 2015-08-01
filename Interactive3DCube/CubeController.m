//
//  CubeController.m
//  Interactive3DCube
//
//  Created by Ahmed Saad on 12/10/14.
//  Copyright (c) 2014 Ahmed Saad. All rights reserved.
//
#import "Tools.h"
#import "CubeController.h"
#import "Face1.h"
#import "Face2.h"
#import "Face3.h"
#import "Face4.h"
#import "Face5.h"
#import "Face6.h"

#import "AbstractFaceViewController.h"
#define M34 -1.0/2000.0
#define ALPHA 0.90f
#define CORNER_RADUIS 25.0f
float calculateRemainder(float ang){
    float n=(ang/(2*M_PI));
    int c =((int)n);
    float rem=n-c;
    return rem*M_PI*2;
}

@interface CubeController ()<UIGestureRecognizerDelegate>
{
    AbstractFaceViewController *face1,*face2,*face3,*face4,*face5,*face6;
    int animationCounter;
    /**
     *  Whether animation thread running or not.
     */
    BOOL inirtiaThreadrunning,animationThreadRunning;
    /**
     *  Attributes of the current cube pose.
     */
    float currentThetaY,currentThetaX;
    float initialOmegaX;
    float initialOmegaY;

    /**
     *  The cube height.
     */
    float cubeHeight;

    /**
     *  The faces of the cube.
     */
    NSMutableArray * faces;
    /**
     *  The previous panning offset.
     */
    float prevOffsetX;
    
    float prevOffsetY;
    /**
     *  The pan gesture recognizer.
     */
    UIPanGestureRecognizer *panGesture;


   
    /**
     *  The subviews controller of the cube faces.
     */
    NSMutableArray * facesSubviewControllers;
    //Deceleration Parameters
    NSThread * inirtiaThread;
    NSThread * animationThread;
    float virtualMagnitudeX,virtualMagnitudeY,virtualTime;
    
}
@end

@implementation CubeController

- (void)InitializeCubeheight:(float)cubeheight initialYDisplacment:(float)initialYDisplacment initialXDisplacment:(float)initialXDisplacment {
    animationCounter=0;
    
    cubeHeight=cubeheight;
    currentThetaY=0,currentThetaX=0;
    //initialize the facesSubviews array.
    

    //initialize the facesSubviewControllers array.
    facesSubviewControllers=[[NSMutableArray alloc] init];
    [facesSubviewControllers addObject:[[NSMutableArray alloc] init]];
    [facesSubviewControllers addObject:[[NSMutableArray alloc] init]];
    [facesSubviewControllers addObject:[[NSMutableArray alloc] init]];
    [facesSubviewControllers addObject:[[NSMutableArray alloc] init]];
    [facesSubviewControllers addObject:[[NSMutableArray alloc] init]];
    [facesSubviewControllers addObject:[[NSMutableArray alloc] init]];
    //[self startAnimationThread];

}


-(void) redrawCube{
    animationCounter=0;
    for(UIView * view in faces){
        view.layer.transform=CATransform3DIdentity;
        
        [view.layer layoutIfNeeded];
        
    }    [self rotateAroundXYAxisOmegaX:0 omegaY:0];
  // [self startAnimationThread];
//    NSArray *viewsToRemove = [self.view subviews];
//    for (UIView *v in viewsToRemove) {
//        [v removeFromSuperview];
//    }
//    faces=[[NSMutableArray alloc] init];
//    
//    [self addFace:0];
//    [self addFace:1];
//    [self addFace:2];
//    [self addFace:3];
//    [self addFace:4];
//    [self addFace:5];
//    [self rotateAroundXYAxisOmegaX:0 omegaY:0];
//    for(int i=0;i<6;i++){
//        NSMutableArray * subconts=facesSubviewControllers[i];
//        for(AbstractFaceViewController * face in subconts)
//        [faces[i] addSubview:face.view ];
//    }

}
- (void)buildCube:(float)h {
    [self InitializeCubeheight:h
           initialYDisplacment:self.view.frame.size.height/2.0f-h/2.0 initialXDisplacment:self.view.frame.size.width/2.0f-h/2.0];
    self.dynamicAngularDisplacment=YES;
    
    
    //add faces.
    faces=[[NSMutableArray alloc] init];
    
    [self addFace:0];
    [self addFace:1];
    [self addFace:2];
    [self addFace:3];
    [self addFace:4];
    [self addFace:5];
    
    //move to initial position.
    [self rotateAroundXYAxisOmegaX:0 omegaY:0];
    //add gesture to the container view.
    [self addGestures];
    [self addFaces];
}
-(void) addFaces{
    face1=[[Face1 alloc] initWithNibName:@"Face1" bundle:nil];
    face2=[[Face2 alloc] initWithNibName:@"Face2" bundle:nil];
    face3=[[Face3 alloc] initWithNibName:@"Face3" bundle:nil];
    face4=[[Face4 alloc] initWithNibName:@"Face4" bundle:nil];
    face5=[[Face5 alloc] initWithNibName:@"Face5" bundle:nil];
    face6=[[Face6 alloc] initWithNibName:@"Face6" bundle:nil];
    [self addSubViewControllerToFace1:face1];
    [self addSubViewControllerToFace2:face2];
    [self addSubViewControllerToFace3:face3];
    [self addSubViewControllerToFace4:face4];
    [self addSubViewControllerToFace5:face5];
    [self addSubViewControllerToFace6:face6];

}

-(void)viewDidLoad{
    [super viewDidLoad];
    

//    }
    
}
/**
 *  Add gesture to the main container view.
 */
-(void) addGestures{
    panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    panGesture.delegate=self;
    [self.view addGestureRecognizer:panGesture];
}

/**
 *  Add one of the faces that build cube.
 *
 *  @param faceIndex The index of that face.
 */
-(void)addFace:(int)faceIndex{
    //not added before
    if(faces.count==faceIndex&&faceIndex<6){
        CGRect frame;
        float x=self.view.frame.size.width/2.0-cubeHeight/2.0;
        float y=self.view.frame.size.height/2.0-cubeHeight/2.0;
        
        frame=  CGRectMake(x,y, cubeHeight,cubeHeight);
        //initialize the face view attributes.
        UIView * face=[[UIImageView alloc] initWithFrame:frame];
        face.userInteractionEnabled=YES;
        face.layer.contentsScale=[[UIScreen mainScreen] scale];
        face.layer.doubleSided=YES;
        face.layer.anchorPoint=CGPointMake(0.5, 0.5);
        face.backgroundColor=[UIColor clearColor];
        face.alpha=ALPHA;
        face.layer.cornerRadius=CORNER_RADUIS;
        face.layer.masksToBounds=YES;
        face.layer.borderColor=[UIColor blueColor].CGColor;
        face.layer.borderWidth=1;
        //faceIndex==0?[UIColor yellowColor]:(faceIndex==1?[UIColor redColor]:(faceIndex==2?[UIColor blackColor]:[UIColor greenColor]));
        [faces addObject:face];
        [self.cubeContainer addSubview:face];
    }
}

-(void)rotateAroundXYAxisOmegaX:(float)omegaX omegaY:(float)omegaY{

  
 
    
    //update cube pose.
    currentThetaY +=omegaY;
    currentThetaX +=omegaX;
  
    // initialize motion prameters,
    float degForPlane = M_PI/2.0f;
    float degY = currentThetaY;//angle of face 1 of the cube
    
    //detect which is the current face of the cubes.
   
    //the cubes list pose exeeded a specafic bounds
    for (int i=0;i<4;i++) {
        UIView * view =faces[i];
        // Create a matrix that translate object in y axis
        

        CATransform3D S =CATransform3DIdentity;
        // Setup the perspective modifying the matrix elementat [3][4]
        S.m34=M34;
        
        // Perform rotate on the translation matrix
        float r=cubeHeight/2.0;
        float offsetY=0;
        float offsetX=2*r*sin(degY/2.0)*cos(degY/2.0);
        float offsetZ=2*r*sin(degY/2.0)*sin(degY/2.0);
        CATransform3D T1 =CATransform3DMakeTranslation(offsetX, offsetY, offsetZ);
        CATransform3D R1 =CATransform3DMakeRotation(degY, 0.0, 1.0f, 0.0f);
      
        //M=T1.R.S.T2
        CATransform3D M= CATransform3DConcat(T1, CATransform3DConcat(R1,S));
        view.layer.transform = M;
        // Add the degree needed for the next plane
        degY+= degForPlane;
    }
    float degX = degForPlane;//angle of face 1 of the cube

    for(int i=4;i<6;i++){
        UIView * view =faces[i];
        // Create a matrix that translate object in y axis
        
        
        CATransform3D S =CATransform3DIdentity;
        // Setup the perspective modifying the matrix elementat [3][4]
        S.m34=M34;
        
        // Perform rotate on the translation matrix
        float r=cubeHeight/2.0;
        float offsetY=2*r*sin(degX/2.0)*cos(degX/2.0);
        float offsetX=0;
        float offsetZ=2*r*sin(degX/2.0)*sin(degX/2.0);
        CATransform3D R1 =CATransform3DMakeRotation(currentThetaY, 0.0, 1.0f, 0.0f);
        

        CATransform3D R2 =CATransform3DMakeRotation(degX, 1.0, 0.0f, 0.0f);

        CATransform3D T1 =CATransform3DMakeTranslation(offsetX, -offsetY, -offsetZ);
        
        
        //M=T1.R.S.T2
        CATransform3D M= CATransform3DConcat(R2, CATransform3DConcat(R1,CATransform3DConcat(T1,S)));

        view.layer.transform =M;
        // Add the degree needed for the next plane
        degX+= 2*degForPlane;
    
    }
    for(int i=0;i<6;i++){
        UIView* view=faces[i];
        CATransform3D R =CATransform3DMakeRotation(currentThetaX, 1.0, 0, 0);
        CATransform3D T1 =CATransform3DMakeTranslation(0, 0, cubeHeight/2.0);
        R=CATransform3DConcat(T1,R);
        CATransform3D T=view.layer.transform;
        T=CATransform3DConcat(T, R);
        view.layer.transform=T;
    }
    [self adjustWhichIsEnabledForInteraction];
    
}
-(void)adjustWhichIsEnabledForInteraction{
    
    BOOL enabled[]={NO,NO,NO,NO,NO,NO};
    int count=0;
    while(count<3){
        int nearestIndex= [self getNearest:enabled];
        count++;
        //
        enabled[nearestIndex]=YES;
        
    }
    for(int i=0;i<6;i++){
        //NSLog(@"face %i is %i \n",i+1,enabled[i]);
        [faces[i] setUserInteractionEnabled:enabled[i]];
        
    }
    
}
-(int)getNearest:(BOOL*)enabled{
    float max=-99999.0;
    int maxIndex=-1;
    for(int i=0;i<6;i++){
        if(enabled[i])continue;
        float zVal=[faces[i] layer].transform.m33;

        if(zVal>max)
        {max=zVal;
            maxIndex=i;
        }
    }
    return maxIndex;;
}
//
//

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self.nextResponder touchesEnded:touches withEvent:event];
    return;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self stopInirtiaThread];
    
    [super touchesBegan:touches withEvent:event];
    
    [self.nextResponder touchesBegan:touches withEvent:event];
    return;
    
    //    }
    
    
}
-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    float xVelocity=  Abs([gestureRecognizer velocityInView:self.view].x);
    float yVelocity=  Abs([gestureRecognizer velocityInView:self.view].y);
    
    //if want to disable either vertical or horizontal motion
    if(xVelocity>yVelocity)
        return YES;
    return YES;
    
    
}



-(void)panAction:(UIPanGestureRecognizer*)gesture{
    float cubesDragingOffsetX=0,cubesDragingOffsetY=0,cubesDraggingAngularOffsetX=0,cubesDraggingAngularOffsetY=0;
    float offsetX =[gesture translationInView:self.view].x;
    float offsetY =[gesture translationInView:self.view].y;
    cubesDragingOffsetX= offsetX-prevOffsetX;
    cubesDragingOffsetY= offsetY-prevOffsetY;
    
    prevOffsetX=offsetX;
    prevOffsetY=offsetY;
    //
  
    float r=0.2;
    cubesDraggingAngularOffsetX=(cubesDragingOffsetX)/(self.view.frame.size.width*r);// ( cubesDragingOffset /
    cubesDraggingAngularOffsetY=(cubesDragingOffsetY)/(self.view.frame.size.width*r);// ( cubesDragingOffset /

    //when begining panning screen stop any working animations
    if(gesture.state == UIGestureRecognizerStateBegan){
        
        [self stopInirtiaThread];
        [self stopAnimationThread];

        [self touchesBegan:nil withEvent:nil];
        cubesDragingOffsetX = 0;
        prevOffsetX=0;
        cubesDragingOffsetY = 0;
        prevOffsetY=0;
        self.isCubeAnimatnigByUser=YES;
    }
    else {
        [self stopAnimationThread];

        float angularDisplacmentX=self.dynamicAngularDisplacment? cubesDraggingAngularOffsetX:0;
        float angularDisplacmentY=self.dynamicAngularDisplacment? cubesDraggingAngularOffsetY:0;
        
        
//        angularDisplacmentX=Abs(angularDisplacmentX)>Abs(angularDisplacmentY)?angularDisplacmentX:0;
//        angularDisplacmentY=Abs(angularDisplacmentY)>Abs(angularDisplacmentX)?angularDisplacmentY:0;
       
        [self rotateAroundXYAxisOmegaX:-angularDisplacmentY omegaY:angularDisplacmentX];
    }
    if(gesture.state==UIGestureRecognizerStateEnded){
        initialOmegaY=[gesture velocityInView:self.view].x/(self.view.frame.size.width*r)/50.0;
        initialOmegaX=-[gesture velocityInView:self.view].y/(self.view.frame.size.width*r)/50.0;
        [self startInertiaThread];

        
    }
}
#pragma mark threading section
- (void)startInertiaThread
{
    [self stopAnimationThread];
    
   
    virtualMagnitudeY= initialOmegaY;
    virtualMagnitudeX= initialOmegaX;
    virtualTime=M_PI_2;
    inirtiaThread = [[NSThread alloc] initWithTarget:self selector:@selector(inirtiaThread:) object:nil];
    [inirtiaThread start];
}

- (void)stopInirtiaThread
{
    self.view.userInteractionEnabled=YES;
    panGesture.enabled=YES;
    inirtiaThreadrunning=NO;
    self.isCubeAnimatnigByUser=NO;
   //
}
- (void)inirtiaThread:(id)object
{
    @autoreleasepool
    {
        inirtiaThreadrunning = YES;
        //the inirtiaThreadrunning is changed from another method (stopInirtiaThread).
        while(inirtiaThreadrunning)
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self animate];
                
            });
            [NSThread sleepForTimeInterval:.0007];
            
        }
        [inirtiaThread cancel];
        inirtiaThread =nil;
    }
}

/**
 *  Update the cube pose.
 */
- (void)animate

{
    float decayTermX=((virtualMagnitudeX*(M_PI_2*M_PI_2*M_PI_2))/(virtualTime*virtualTime*virtualTime));
    float decayTermY=((virtualMagnitudeY*(M_PI_2*M_PI_2*M_PI_2))/(virtualTime*virtualTime*virtualTime));
    float sinsoidalTermX=sin(10*virtualTime/(10*M_PI_2));
    float sinsoidalTermY=sin(10*virtualTime/(10*M_PI_2));
    //
    float omegaX=decayTermX*sinsoidalTermX;
    float omegaY=decayTermY*sinsoidalTermY;
    //current magnitude is very low and current theta is too low
    if((Abs(decayTermX)<0.00001*M_PI)&&(Abs(decayTermX)<0.00001*M_PI))
    {
      
        //stop animation.
        [self stopInirtiaThread];
        return;
    }
    //calculate the new theta using the sinusoidal function.
   ;

    [self rotateAroundXYAxisOmegaX:omegaX  omegaY:omegaY];
    //incerement virtual time.
   virtualTime+=(0.01*M_PI);
    
}
#pragma mark
#pragma mark threading section
- (void)startAnimationThread
{
    
   
    animationThread = [[NSThread alloc] initWithTarget:self selector:@selector(animationThread:) object:nil];
    [animationThread start];
}

- (void)stopAnimationThread
{
    animationThreadRunning=NO;
    self.isCubeAnimatnigAutomaticly=NO;
}
- (void)animationThread:(id)object
{
    @autoreleasepool
    {
        animationThreadRunning = YES;
        //the inirtiaThreadrunning is changed from another method (stopInirtiaThread).
        while(animationThreadRunning)
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self animate2];
                
            });
            [NSThread sleepForTimeInterval:.01];
            
        }
        [animationThread cancel];
        animationThread =nil;
    }
}

/**
 *  Update the cube pose.
 */
- (void)animate2

{
    animationCounter++;
    
    float omega1=M_PI/1000.0;
    float omega2=M_PI/300.0;
    if(animationCounter<=600){
        [self rotateAroundXYAxisOmegaX:omega1  omegaY:omega2];
    }else if(animationCounter<=1200){
        [self rotateAroundXYAxisOmegaX:omega2  omegaY:omega1];

    }
    else if (animationCounter==1201){
        animationCounter=0;
    }
   
    
}
#pragma mark
-(void)addSubviewController:(AbstractFaceViewController*)viewController ToFace:(int)face{
    ((AbstractFaceViewController*)viewController).cubeController=self;
    [facesSubviewControllers[face] addObject:viewController];
    UIView * currentFace=faces[face];
   [currentFace addSubview:viewController.view];
}
-(NSArray*)getSubviewsControllersOfFace:(int)face{
    return   facesSubviewControllers[face];
}



-(void)switchToFreeAnimationMode{
    [self stopAnimationThread];
    self.view.userInteractionEnabled=YES;
    
}

-(void)switchToNonFreeAnimationMode{
    [self stopInirtiaThread];
    [self startAnimationThread];
    self.view.userInteractionEnabled=NO;
    
}

-(void)addSubViewControllerToFace1:(AbstractFaceViewController *)viewController{
    
    [self addSubviewController:viewController ToFace:0];
}
-(void)addSubViewControllerToFace2:(AbstractFaceViewController *)viewController{
    
    [self addSubviewController:viewController ToFace:1];
}
-(void)addSubViewControllerToFace3:(AbstractFaceViewController *)viewController{
    
    [self addSubviewController:viewController ToFace:2];
}
-(void)addSubViewControllerToFace4:(AbstractFaceViewController *)viewController{
    
    [self addSubviewController:viewController ToFace:3];
}
-(void)addSubViewControllerToFace5:(AbstractFaceViewController *)viewController{
    
    [self addSubviewController:viewController ToFace:4];
}
-(void)addSubViewControllerToFace6:(AbstractFaceViewController *)viewController{
    
    [self addSubviewController:viewController ToFace:5];
}




// /// // // / / /

-(NSArray*)getFaceViewController1{
    return  [self getSubviewsControllersOfFace:0];
    
}
-(NSArray*)getFaceViewController2{
    return  [self getSubviewsControllersOfFace:1];
    
}
-(NSArray*)getFaceViewController3{
    return  [self getSubviewsControllersOfFace:2];
    
}
-(NSArray*)getFaceViewController4{
    return  [self getSubviewsControllersOfFace:3];
    
}
////////////// Set Face Image Methods ////////////////////
//
-(void)setFace1ImageFromImage:(UIImage*)image{
    face1.faceImage.image=image;
}
-(void)setFace2ImageFromImage:(UIImage*)image{
    face2.faceImage.image=image;

}
-(void)setFace3ImageFromImage:(UIImage*)image{
    face3.faceImage.image=image;

}
-(void)setFace4ImageFromImage:(UIImage*)image{
    face4.faceImage.image=image;

}
-(void)setFace5ImageFromImage:(UIImage*)image{
    face5.faceImage.image=image;

}
//

-(void)setFace1ImageFromDir:(NSString*)imageDir{
    UIImage * image=getImageFromDir(imageDir);
    [self setFace1ImageFromImage:image];
    
}
-(void)setFace2ImageFromDir:(NSString*)imageDir{
    UIImage * image=getImageFromDir(imageDir);
    [self setFace2ImageFromImage:image];
    
}

-(void)setFace3ImageFromDir:(NSString*)imageDir{
    UIImage * image=getImageFromDir(imageDir);
    [self setFace3ImageFromImage:image];
    
}

-(void)setFace4ImageFromDir:(NSString*)imageDir{
    UIImage * image=getImageFromDir(imageDir);
    [self setFace4ImageFromImage:image];
    
}

-(void)setFace5ImageFromDir:(NSString*)imageDir{
    UIImage * image=getImageFromDir(imageDir);
    [self setFace5ImageFromImage:image];
    
}

//

-(void)setFace1ImageFromURL:(NSString*)imageURL{
    
        UIImage * image=getImageFromURL(imageURL);
        [self setFace1ImageFromImage:image];
        
    

}
-(void)setFace2ImageFromURL:(NSString*)imageURL{
    
    UIImage * image=getImageFromURL(imageURL);
    [self setFace2ImageFromImage:image];
    
    
    
}

-(void)setFace3ImageFromURL:(NSString*)imageURL{
    
    UIImage * image=getImageFromURL(imageURL);
    [self setFace3ImageFromImage:image];
    
    
    
}

-(void)setFace4ImageFromURL:(NSString*)imageURL{
    
    UIImage * image=getImageFromURL(imageURL);
    [self setFace4ImageFromImage:image];
    
    
    
}

-(void)setFace5ImageFromURL:(NSString*)imageURL{
    
    UIImage * image=getImageFromURL(imageURL);
    [self setFace5ImageFromImage:image];
    
    
    
}

//

@end

