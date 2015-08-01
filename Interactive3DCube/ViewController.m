//
//  ViewController.m
//  Interactive3DCube
//
//  Created by Ahmed Saad on 12/10/14.
//  Copyright (c) 2014 Ahmed Saad. All rights reserved.
//

#import "ViewController.h"
#import "Face1.h"
#import "Face2.h"
#import "Face3.h"
#import "Face4.h"
#import "Face5.h"
#import "Face6.h"
#import "CubeController.h"
#import "CubeCell.h"
@interface ViewController ()
{
    int numberOfCubes;
    NSMutableArray * cubes;
    NSMutableArray * cells;
}


@end

@implementation ViewController
-(UIView*) addCube{
    CubeController * cubeController=[[CubeController alloc] initWithNibName:@"CubeController" bundle:nil];
    
    
    [cubeController buildCube:200.0f];
    Face1 * face1=[[Face1 alloc] initWithNibName:@"Face1" bundle:nil];
    
    Face2 * face2=[[Face2 alloc] initWithNibName:@"Face2" bundle:nil];
    Face3 * face3=[[Face3 alloc] initWithNibName:@"Face3" bundle:nil];
    Face4 * face4=[[Face4 alloc] initWithNibName:@"Face4" bundle:nil];
    Face5 * face5=[[Face5 alloc] initWithNibName:@"Face5" bundle:nil];
    Face6 * face6=[[Face6 alloc] initWithNibName:@"Face6" bundle:nil];
    [cubeController addSubViewControllerToFace1:face1];
    [cubeController addSubViewControllerToFace2:face2];
    [cubeController addSubViewControllerToFace3:face3];
    [cubeController addSubViewControllerToFace4:face4];
    [cubeController addSubViewControllerToFace5:face5];
    [cubeController addSubViewControllerToFace6:face6];
    [cubes addObject:cubeController];
    return cubeController.view;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
            return UITableViewCellEditingStyleDelete;
    }
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //The style of editing is delete.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [cubes removeObjectAtIndex:indexPath.row];
        numberOfCubes--;
        [self.tableView reloadData];
        
    
    }}
    
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  300.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CubeCell * cell;
    if(cells.count <= indexPath.row)
    {
    UIView * cubeview=[self addCube];
        
   cell = [[[NSBundle mainBundle] loadNibNamed:@"CubeCell" owner:self options:nil] lastObject];
    [cell.myView addSubview:cubeview];
        [cells addObject:cell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor lightGrayColor];
        cell.clipsToBounds=NO;
        [cell setNeedsDisplay];
        
    
    }
    else{
        cell=cells[indexPath.row];
    }
    return  cell;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  numberOfCubes;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    numberOfCubes=2;
    cubes=[[NSMutableArray alloc] init];
    cells=[[NSMutableArray alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addCubeAction:(id)sender {
    numberOfCubes++;
    [self.tableView reloadData];
    
}
@end
