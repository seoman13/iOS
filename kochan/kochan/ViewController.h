//
//  ViewController.h
//  kochan
//
//  Created by Admin on 11.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *display;
-(void) processDigit: (int) digit;
-(void) processOp: (char) theOp;
-(void) storeFracPart;
// Numeric keys
-(IBAction) clickDigit: (UIButton *) sender;
// Arithmetic Operation keys
-(IBAction) clickPlus;
-(IBAction) clickMinus;
-(IBAction) clickMultiply;
-(IBAction) clickDivide;
// Misc. Keys
-(IBAction) clickOver;
-(IBAction) clickEquals;
-(IBAction) clickClear;

@end

