//
//  CubeData.m
//  Interactive3DCube
//
//  Created by Ahmed Saad on 1/4/15.
//  Copyright (c) 2015 Ahmed Saad. All rights reserved.
//

#import "CubeData.h"

@implementation CubeData
- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.cubeName forKey:@"cubeName"];
    [encoder encodeObject:self.comment forKey:@"comment"];
    [encoder encodeObject:self.face1Dir forKey:@"face1Dir"];
    [encoder encodeObject:self.face2Dir forKey:@"face2Dir"];
    [encoder encodeObject:self.face3Dir forKey:@"face3Dir"];
    [encoder encodeObject:self.face4Dir forKey:@"face4Dir"];
    [encoder encodeObject:self.face5Dir forKey:@"face5Dir"];

}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.cubeName = [decoder decodeObjectForKey:@"cubeName"];
        self.comment = [decoder decodeObjectForKey:@"comment"];
        self.face1Dir = [decoder decodeObjectForKey:@"face1Dir"];
        self.face2Dir = [decoder decodeObjectForKey:@"face2Dir"];
        self.face3Dir = [decoder decodeObjectForKey:@"face3Dir"];
        self.face4Dir = [decoder decodeObjectForKey:@"face4Dir"];
        self.face5Dir = [decoder decodeObjectForKey:@"face5Dir"];
           }
    return self;
}
@end
