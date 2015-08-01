//
//  ViewController.m
//  Interactive3DCube
//
//  Created by Ahmed Saad on 12/10/14.
//  Copyright (c) 2014 Ahmed Saad. All rights reserved.
//

#import "profileViewController.h"
#import "Face1.h"
#import "Face2.h"
#import "Face3.h"
#import "Face4.h"
#import "Face5.h"
#import "Face6.h"
#import "CubeController.h"
#import "CubeCell.h"
@interface profileViewController ()
{
    int numberOfCubes;
    //NSMutableArray * cubes;
    NSMutableArray * cells;
    
}


@end

@implementation profileViewController
-(CubeController*) addCube{
    CubeController * cubeController=[[CubeController alloc] initWithNibName:@"CubeController" bundle:nil];
    
    
    [cubeController buildCube:150.0f];
      // [cubes addObject:cubeController];
    return cubeController;
}

-(NSString* ) saveImage:(UIImage*)image{
    
    NSData *pngData = UIImageJPEGRepresentation(image,.70);
    NSArray * dirPaths = NSSearchPathForDirectoriesInDomains(
                                                             NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docsDir = dirPaths[0];
    NSString * Date =[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    NSString* imageFilePath = [docsDir
                               stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",Date]];
    [pngData writeToFile:imageFilePath atomically:YES];
    
    return imageFilePath;

}
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return !_viewMode? UITableViewCellEditingStyleDelete:UITableViewCellEditingStyleNone;
    }
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //The style of editing is delete.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [cells removeObjectAtIndex:indexPath.row];
        numberOfCubes--;
        
        [UIView animateWithDuration:.5 animations:^{
            
            [tableView beginUpdates];
            //delete the cell with animation.
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationLeft];
            [tableView endUpdates];
            
        } completion:^(BOOL finished){
            
            [UIView animateWithDuration:0.5 animations:^{
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished){}];
            
            
            
        }];
        
        
    }{
        [self.tableView reloadData];
        
    
    }}
-(void)createACell{
    
        CubeController * cube=[self addCube];
        
       CubeCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"CubeCell" owner:self options:nil] lastObject];
  

        [cell setCube:cube];
        [cells addObject:cell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor lightGrayColor];
        cell.clipsToBounds=NO;
        [cell setNeedsDisplay];
        
        
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 260
    ;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CubeCell * cell=cells[cells.count -indexPath.row-1];
    
    return  cell;

}
-(UIBarButtonItem* )getAddItem{
    static UIBarButtonItem* addItem;
    if (!addItem) {
       addItem= [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStyleDone target:self action:@selector(addCubeAction:)];
        [addItem setTitleTextAttributes:@{
                                          NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Thin" size:50.0]
                                          //,NSForegroundColorAttributeName: [UIColor whiteColor]
                                          } forState:UIControlStateNormal];
    }
    return addItem;
   
}
-(UIBarButtonItem* )getDone{
    static UIBarButtonItem* Done=nil;
    if (!Done) {
        Done= [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(DoneAction)];
        [Done setTitleTextAttributes:@{
                                         NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0]
                                         //,NSForegroundColorAttributeName: [UIColor whiteColor]
                                         } forState:UIControlStateNormal] ;
    }
    return Done;
    
}
-(UIBarButtonItem* )getBackItem{
    static UIBarButtonItem* back=nil;
    if (!back) {
        back= [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
        [back setTitleTextAttributes:@{
                                         NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0]
                                         //,NSForegroundColorAttributeName: [UIColor whiteColor]
                                         } forState:UIControlStateNormal] ;
    }
    return back;
    
}
-(UIBarButtonItem* )getEditItem{
    static UIBarButtonItem* edit=nil;
    if (!edit) {
        edit= [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleDone target:self action:@selector(editAction:)];
        [edit setTitleTextAttributes:@{
                                       NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0]
                                       //,NSForegroundColorAttributeName: [UIColor whiteColor]
                                       } forState:UIControlStateNormal] ;
    }
    return edit;
    
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)DoneAction{
    self.viewMode=YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.profileNameField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.profileNameField resignFirstResponder];
    
}
-(void)setViewMode:(BOOL)viewMode{
    _viewMode=viewMode;
    if(viewMode){
        self.profileNameField.userInteractionEnabled=NO;
        self.profileNameField.placeholder=@"";
        for(CubeCell * cell in cells)
            [[cell getCube] switchToNonFreeAnimationMode];
        UIBarButtonItem* editItem =  [self getEditItem];
        
        self.navigationItem.rightBarButtonItem =editItem ;
        //
        UIBarButtonItem* back = [self getBackItem];
        self.navigationItem.leftBarButtonItem=back ;
    }else{
        self.profileNameField.userInteractionEnabled=YES;
        self.profileNameField.placeholder=@"Profile Name";
        for(CubeCell * cell in cells)
            [[cell getCube] switchToFreeAnimationMode];
        
        UIBarButtonItem* addItem =  [self getAddItem];
        
        self.navigationItem.rightBarButtonItem =addItem ;
        //
        UIBarButtonItem* Done = [self getDone];
        self.navigationItem.leftBarButtonItem=Done ;

    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  numberOfCubes;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(void)editAction:(id)sender{
    self.viewMode=!_viewMode;

   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    numberOfCubes=0;
    //cubes=[[NSMutableArray alloc] init];
    cells=[[NSMutableArray alloc] init];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.viewMode=_viewMode;
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addCubeAction:(id)sender {
    numberOfCubes++;
    [self createACell];
    [self.tableView reloadData];
    
}
@end
