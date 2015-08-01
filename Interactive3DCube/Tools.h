//
//  Tools.h
//  Interactive3DCube
//
//  Created by Ahmed Saad on 12/10/14.
//  Copyright (c) 2014 Ahmed Saad. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

double Abs (double x){
    return x>0?x:-x;
}
CGPoint subtract(CGPoint p1,CGPoint p2){
    return CGPointMake(p1.x-p2.x, p1.y-p2.y);
}
CGPoint add(CGPoint p1,CGPoint p2){
    return CGPointMake(p1.x+p2.x, p1.y+p2.y);
}
UIStoryboard * getStoryBoard(){
    static UIStoryboard *storyboard;
    if(!storyboard)  storyboard= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return storyboard;
}
UIImage *getImageFromURL(NSString *fileURL) {

UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]]];
    return  image;
}
UIImage *getImageFromDir(NSString *fileDir) {
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfFile:fileDir];
    result = [UIImage imageWithData:data];
    
    return result;
}