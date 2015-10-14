//
//  RoleDetailTVC.m
//  Staff Manager
//
//  Created by Tim Roadley on 14/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RoleDetailTVC.h"

@implementation RoleDetailTVC
@synthesize delegate;
@synthesize roleNameTextField;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize role = _role;

- (void)viewDidLoad 
{
    NSLog(@"Setting the value of fields in this static table to that of the passed Role");
    self.roleNameTextField.text = self.role.name;
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setRoleNameTextField:nil];
    [super viewDidUnload];
}

- (IBAction)save:(id)sender
{
    NSLog(@"Telling the AddRoleTVC Delegate that Save was tapped on the AddRoleTVC");
    [self.role setName:roleNameTextField.text];
    [self.managedObjectContext save:nil];  // write to database
    [self.delegate theSaveButtonOnTheRoleDetailTVCWasTapped:self];
}
@end


