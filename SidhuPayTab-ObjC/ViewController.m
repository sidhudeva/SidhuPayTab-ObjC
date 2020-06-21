//
//  ViewController.m
//  SidhuPayTab-ObjC
//
//  Created by sidhudevarayan on 11/06/20.
//  Copyright © 2020 sidhudevarayan. All rights reserved.
//

#import "ViewController.h"
#import <paytabs-iOS/paytabs_iOS.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _checkOutBtn.layer.cornerRadius = 20;
    _myScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 800);
}

// Validate Mobile Number
- (BOOL)myMobileNumberValidate:(NSString*)number {
    NSString *numberRegEx = @"[0-9]{10}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    if ([numberTest evaluateWithObject:number] == YES)
        return TRUE;
    else
        return FALSE;
}

//Email Validation
- (BOOL)validateEmailWithString:(NSString*)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

// Check out using PayTabs SDK
- (IBAction)setOnClickPay:(id)sender {
    
    float amount = [self.amountTxtField.text floatValue];
    
    // Validate email
    if ([self validateEmailWithString:self.emailTxtField.text] == true) {
        NSLog(@"Valid email");
    }else{
        NSLog(@"INValid email");
        [self successAlert: @"Alert" : @"Enter Valid EmailID": false];
        return;
    }
    
    // Validate amount
    if (amount == 0){
        [self successAlert: @"Alert" : @"Enter Valid Amount for Transcation": false];
        return;
    }
    
    // Validate Address
    if ([self.nameTxtField.text isEqualToString: @""] || [self.s_AddressTxtField.text isEqualToString: @""] || [self.s_AddressTxtField.text isEqualToString: @""] || [self.s_CityTxtField.text isEqualToString: @""] || [self.s_StateTxtField.text isEqualToString: @""] || [self.s_CountryTxtField.text isEqualToString: @""] || [self.s_ZipTxtField.text isEqualToString: @""] || [self.b_AddressTxtField.text isEqualToString: @""] || [self.b_CityTxtField.text isEqualToString: @""] || [self.b_StateTxtField.text isEqualToString: @""] || [self.b_CountryTxtField.text isEqualToString: @""] || [self.b_ZipTxtField.text isEqualToString: @""]) {
        
        [self successAlert: @"Alert" : @"Kindly Enter All Fields": false];
        return;
    }
    
    // Validate mobile number
    if ([self myMobileNumberValidate:self.b_MobileTxtField.text] == true) {
        NSLog(@"Valid mobile");
    }else{
        NSLog(@"INValid mobile");
        [self successAlert: @"Alert" : @"Enter Valid Mobile Number": false];
        return;
    }
    
    // Hit PayTab payment
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"Resources" withExtension:@"bundle"]];
    
    PTFWInitialSetupViewController *view = [[PTFWInitialSetupViewController alloc]
                                            initWithBundle:bundle
                                            andWithViewFrame:self.view.frame
                                            andWithAmount:amount
                                            andWithCustomerTitle: self.nameTxtField.text
                                            andWithCurrencyCode:@"USD"
                                            andWithTaxAmount:0.0
                                            andWithSDKLanguage:@"en"
                                            andWithShippingAddress:self.s_AddressTxtField.text
                                            andWithShippingCity:self.s_CityTxtField.text
                                            andWithShippingCountry:@"IND"
                                            andWithShippingState:self.s_StateTxtField.text
                                            andWithShippingZIPCode:self.s_ZipTxtField.text
                                            andWithBillingAddress:self.b_AddressTxtField.text
                                            andWithBillingCity:self.b_CityTxtField.text
                                            andWithBillingCountry:@"IND"
                                            andWithBillingState:self.b_StateTxtField.text
                                            andWithBillingZIPCode:self.b_ZipTxtField.text
                                            andWithOrderID:@"100"
                                            andWithPhoneNumber:self.b_MobileTxtField.text
                                            andWithCustomerEmail:self.emailTxtField.text
                                            andIsTokenization:YES
                                            andIsPreAuth:NO
                                            andWithMerchantEmail:@"sidhudevarayan93@gmail.com"
                                            andWithMerchantSecretKey:@"h7zZ1Dko2hz9RtKnt0CEXirDCFUAJtg0AP0Ctl0wCAFu3pRxqucoNE1qkV03ph4Z74BBpC72dMwhcoOCT10HF27ZY82np6mxbY8A"
                                            andWithAssigneeCode:@"SDK"
                                            andWithThemeColor:[UIColor redColor]
                                            andIsThemeColorLight:YES];
    
    view.didReceiveBackButtonCallback = ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    view.didStartPreparePaymentPage = ^{
        // Start Prepare Payment Page
        // Show loading indicator
    };
    
    view.didFinishPreparePaymentPage = ^{
        // Finish Prepare Payment Page
        // Stop loading indicator
    };
    
    view.didReceiveFinishTransactionCallback = ^(int responseCode, NSString * _Nonnull result, int transactionID, NSString * _Nonnull tokenizedCustomerEmail, NSString * _Nonnull tokenizedCustomerPassword, NSString * _Nonnull token, BOOL transactionState) {
        NSLog(@"Response Code: %i", responseCode);
        NSLog(@"Response Result: %@", result);
        
        // In Case you are using tokenization
        NSLog(@"Tokenization Cutomer Email: %@", tokenizedCustomerEmail);
        NSLog(@"Tokenization Customer Password: %@", tokenizedCustomerPassword);
        NSLog(@"TOkenization Token: %@", token);
        [self dismissViewControllerAnimated:YES completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (responseCode == 100) {
                [self successAlert: result : tokenizedCustomerEmail: true];
            }else{
                [self successAlert: result : @"Please Try Again Later": false];
            }
        });
    };
    
    [self presentViewController:view animated:true completion:nil];
}

// Common Alert View
- (void)successAlert :(NSString *)title :(NSString *)msg :(BOOL)transcation {
    NSString *str = msg;
    if (transcation == true) {
        str = [NSString stringWithFormat:@"Transaction Succeed with %@", msg];
    }
     UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                  message:str
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
        if (transcation == true) {
               [self clearTextFields];
        }
    }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

// Clear all the text values
-(void)clearTextFields {
    self.nameTxtField.text = @"";
    self.emailTxtField.text = @"";
    self.amountTxtField.text = @"";
    self.s_AddressTxtField.text = @"";
    self.s_ZipTxtField.text = @"";
    self.s_StateTxtField.text = @"";
    self.s_CountryTxtField.text = @"";
    self.s_CityTxtField.text = @"";
    self.b_AddressTxtField.text = @"";
    self.b_ZipTxtField.text = @"";
    self.b_StateTxtField.text = @"";
    self.b_CountryTxtField.text = @"";
    self.b_CityTxtField.text = @"";
    self.b_MobileTxtField.text = @"";
}

@end
