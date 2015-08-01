//
//  Test1ViewController.m
//  Interactive3DCube
//
//  Created by Ahmed Saad on 12/15/14.
//  Copyright (c) 2014 Ahmed Saad. All rights reserved.
//

#import "Test1ViewController.h"

@interface Test1ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *testView;
- (IBAction)changeAction:(id)sender;

@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CATransform3D tt= CATransform3DMakeRotation(2, 0.25, 0.75, 0.73);
//    tt=CATransform3DTranslate(tt,22, 2, -13);
//    tt=CATransform3DRotate(tt,1.5, 0.25, 0.75, 0.73);
//    tt=CATransform3DTranslate(tt,22, 2, -13);

    
    self.testView.layer.transform=tt;
    // Do any additional setup after loading the view.
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

- (IBAction)changeAction:(id)sender {
    self.image.image=[UIImage imageNamed:@"3"];
}
@end
