//
//  AbstractFaceViewController.m
//  Interactive3DCube
//
//  Created by Ahmed Saad on 12/12/14.
//  Copyright (c) 2014 Ahmed Saad. All rights reserved.
//

#import "AbstractFaceViewController.h"
#import "CubeController.h"
@interface AbstractFaceViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPopoverControllerDelegate>
{
    UITapGestureRecognizer * gesture;
    UIActionSheet * actionSheet;
    BOOL isCamera,newMedia;
}
@end

@implementation AbstractFaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    gesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [gesture setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:gesture];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)tapAction:(UILongPressGestureRecognizer*)gesture{
    [self addImage:nil];
    
    

}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        [self pickImageFromCamera ];
    }else if(buttonIndex==1){
        [self pickImageFromGallary];
        
    }
}
-(void)pickImageFromGallary{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self.view.window.rootViewController presentViewController:picker animated:YES completion:NULL];
    
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error access photo library"
                                                        message:@"your device does not support photo library"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        
       NSData *pngData = UIImageJPEGRepresentation(chosenImage,.60);
        
        self.faceImage.image = [UIImage imageWithData:pngData];
        
        self.faceImage.layer.borderColor=[UIColor redColor].CGColor;
        self.faceImage.layer.borderWidth=2;
        [self.cubeController redrawCube];
       
    });
   
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void) pickImageFromCamera{
if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self.view.window.rootViewController presentViewController:picker animated:YES completion:NULL];
}else {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error accessing Camera"
                                                    message:@""
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addImage:(id)sender {
    actionSheet=[[UIActionSheet alloc] initWithTitle:@"Choose Image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"From Camera",@"From Gallery",nil];
    [actionSheet showInView:self.view];
}
@end
