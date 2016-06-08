//
//  DVBaseViewController.m
//  Name Checker
//
//  Created by Divjyot Singh on 07/06/16.
//  Copyright © 2016 Divjyot Singh. All rights reserved.
//

#import "DVBaseViewController.h"
#import "DVCheckerUtility.h"

@interface DVBaseViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
    
@end


@implementation DVBaseViewController


-(void)viewDidLoad{
 self.nameLabel.text = @"Enter the name below";
    
    [self listOfNames];
}


- (IBAction)checkButtonAction:(id)sender {
    
    [self inputString:self.inputTextField.text];

}


-(void)listOfNames{
    
    NSString * designations = @"Assistant Manager/Head (Techno-Commercial)/Assistant Manager/Chief Officer/Industry Interface/Chief Executive/GM-Business Development/C.E.O./Principal Strategist/Director/Dean,Placement and Training/Associate Professor/Department of Fashion Technology/Managing Partner/Founder & CEO/Mangaging Director/Technology Architect/Fashion Makers/Chief Executive Officer/Assistant Professor/Assistant Professor (Senior Grade)/Chief Technology Officer/M&S DIRECTOR C E O/Co-ordinator - Marketing/Director/Managing Director/President/Managing Director & CEO/Activity Chairperson/Faculty Development Programme Project Head/Design Clinic Scheme for MSMEs/Manager/CEO/Vice-Principal/Apple Sales Professional/Associate Professor/Scientist 'E' & Joint Director/EXPORTER IMPORTER & MANUFACTURER/Chief Legal Consultant/Managing Partner/Partner/Patent Agent/Executive Director/Chief Manufactuirng Officer/PLUMBING CONTRACTORS/Zonal Manager/Director- Commercial/Proprietor/IT-Analysis & Development/Executive Director/Junior Officer/APPLICATION ENGINEER/Asst Vice President/Channel Sales Manager/Senior Analyst/Chief Life Insurance Advisor/Agents Recruitment Officer/Executive (Marketing)/Founder & CEO";
    
    
    NSString * companyNames = @"ROOTS INDUSTRIES INDIA LIMITED/MINERVA AUTOMATION/ROOTS INDUSTRIES INDIA LIMITED/Sri Ramakrishna Engineering College/Ista Healthcare/IT HUB/YES YES TECHNOLOGIES/Enventure Technology services India Pvt.Ltd./CND TECHNICAL TEXTILE/Hers/ichiban Business Consultants Private Limited/KALYCITO INFOTECH PRIVATE LIMITED/PSG COLLEGE OF TECHNOLOGY/MANGALA INTERNATIONAL TECHNOLOGY LLC/KrishTech Computers/SYNETICS Automation Solutions Pvt Ltd./VenPep Solutions Pvt Ltd./Advance Exchange Technology Co. Ltd./Infosys Limited/GLOBAL INNOVATIVE TECHNOLOGIES/PSG College of Technology/Synaptris Software Pvt.Ltd./naturals/FURNITURE CORNER/i2rDesign/ELSAFTA INDONESIA/T-FILeS INDONESIA/Swissmango solar energy solutions pvt ltd/Kojo Anima/IMMORTALS/SAPRO ROBOTICS/NUTRICARE NUTRITION COMPANY LIMITED/UNILOGIC TECHNOLOGIES PVT.LTD./VAYAMAA INDIA/ARCHi MEdiA/NATIONAL INSTITUTE OF DESIGN/Southern Scale Services/PSG College of Technology - Science & Technology Entrepreneurial Park/tricely/Dr.Mahalingam College of Engineering and Technology/iPlanet/CEMILAC/DIVES TRADING CO./LTD./Meta Yage IP Strategy Consulting/AIR+MAK INDUSTRIES INC./MAK CONTROLS AND SYSTEMS (P) LTD./Vinzi Sperri/ICICI Bank Limited/Reliance Industries Limited/Fisher Pumps Pvt.Ltd./geomagic/TITAN INDUSTRIES LIMITED - JEWELLERY DIVISION/VectraFORM Engineering Services/VectraFORM Engineering 7 Solutions P Ltd./M.M CABS & CALL TAXI/V.A.S INTERIOR/SRI KRISHNA PLUMBING SOLUTION/naukri.com/AREMPEE COMPRESSORS (P) LTD/EVERSHINE ENTERPRISES/POPULAR SYSTEMS/NCS COMPUTECH LTD./APS MEDIA/accenture/SHREE JAYA SHREE FOOD PRODUCTS/KNR AND COMPANY/maark Group Of Companies/ECOPAN INDUSTRIES/BelieveIT/LIFE INSURANCE CORPORATION OF INDIA/SAKTHI ALUMINIUM PROFILE/Soundara Raajan Agencies/ADITHYA AQUA SOLUTIONS/Ourvivaha.COM/Innovatus Systems/ARCHANA TILES & PAVERS/BRIGHT BURNISHING TOOLS PRIVATE LIMITED/Reach Accountant/infinit SOLUTIONS/derivIT Solutions Pte Ltd/DGM-Engineering Solutions";
    
    NSArray* arrayD = [designations componentsSeparatedByString:@"/"];
    
    NSArray* arrayC = [companyNames componentsSeparatedByString:@"/"];
    
    for(NSString* string in arrayD){
        
        [self inputString:string];
    }
    
    for(NSString* string in arrayC){
        
        [self inputString:string];
    }
//    NSLog(@"Total :%lu",(unsigned long)arrayD.count);
    
}
-(void)inputString:(NSString*)input{
   
    DVCheckerUtility * checkerUtility = [[DVCheckerUtility alloc] init];
    
    if([checkerUtility checkDesignation:input]){
        
        self.nameLabel.text =@"Designation";
        self.nameLabel.textColor = [UIColor colorWithRed:255/255.0 green:128/255.0 blue:255/255.0 alpha:1.0];
    }
    else if([checkerUtility checkCompanyName:input]){
        self.nameLabel.text =@"Company";
        self.nameLabel.textColor = [UIColor orangeColor];
    }
    else {
        self.nameLabel.text =@"Neither";
        self.nameLabel.textColor = [UIColor grayColor];
    }
    
    if([self.nameLabel.text isEqualToString:@"Neither"]){
    NSLog(@"%@",input);
    }
}


@end
