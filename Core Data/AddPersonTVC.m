//
//  AddPersonTVC.m
//  Staff Manager
//
//  Created by Tim Roadley on 9/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddPersonTVC.h"

@implementation AddPersonTVC
@synthesize delegate;
//@synthesize personNameTextField;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize personFirstnameTextField;
@synthesize personSurnameTextField;

- (void)viewDidUnload
{
//    [self setPersonNameTextField:nil];
    [self setPersonFirstnameTextField:nil];
    [self setPersonSurnameTextField:nil];
    [super viewDidUnload];
}

- (IBAction)save:(id)sender
{
    NSLog(@"Telling the AddPersonTVC Delegate that Save was tapped on the AddPersonTVC");
    
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                               inManagedObjectContext:self.managedObjectContext];
    
//    person.name = personNameTextField.text;
    person.firstname = personFirstnameTextField.text;
    person.surname = personSurnameTextField.text;
    
    [self.managedObjectContext save:nil];  // write to database
    
    [self.delegate theSaveButtonOnTheAddPersonTVCWasTapped:self];
}
@end


