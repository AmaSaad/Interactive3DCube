//
//  ProfileData.m
//  Interactive3DCube
//
//  Created by Ahmed Saad on 1/4/15.
//  Copyright (c) 2015 Ahmed Saad. All rights reserved.
//

#import "ProfileData.h"
#import "CubeData.h"
@implementation ProfileData
- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    if(self.cubesData){
    [encoder encodeObject:self.cubesData forKey:@"cubesData"];
        [encoder encodeObject:self.profileName forKey:@"profileName"];
        
        
    }
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.cubesData = [decoder decodeObjectForKey:@"cubesData"];
        self.profileName=[decoder decodeObjectForKey:@"profileName"];
       
    }
    return self;
}
@end
