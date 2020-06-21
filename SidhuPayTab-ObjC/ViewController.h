//
//  ViewController.h
//  SidhuPayTab-ObjC
//
//  Created by sidhudevarayan on 11/06/20.
//  Copyright © 2020 sidhudevarayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *checkOutBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
- (IBAction)setOnClickPay:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *nameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *emailTxtField;
@property (weak, nonatomic) IBOutlet UITextField *amountTxtField;

@property (weak, nonatomic) IBOutlet UITextField *s_AddressTxtField;
@property (weak, nonatomic) IBOutlet UITextField *s_CityTxtField;
@property (weak, nonatomic) IBOutlet UITextField *s_StateTxtField;
@property (weak, nonatomic) IBOutlet UITextField *s_CountryTxtField;
@property (weak, nonatomic) IBOutlet UITextField *s_ZipTxtField;

@property (weak, nonatomic) IBOutlet UITextField *b_AddressTxtField;
@property (weak, nonatomic) IBOutlet UITextField *b_CityTxtField;
@property (weak, nonatomic) IBOutlet UITextField *b_StateTxtField;
@property (weak, nonatomic) IBOutlet UITextField *b_CountryTxtField;
@property (weak, nonatomic) IBOutlet UITextField *b_ZipTxtField;
@property (weak, nonatomic) IBOutlet UITextField *b_MobileTxtField;




@end

