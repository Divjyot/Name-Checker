//
//  DVCheckerUtility.m
//  Check
//
//  Created by Divjyot Singh on 07/06/16.
//  Copyright © 2016 Divjyot Singh. All rights reserved.
//

#import "DVCheckerUtility.h"
#import "DVBaseViewController.h"

@interface DVCheckerUtility(){
    NSMutableArray * modalDesignations;
    NSMutableArray * prefixDesignation;
    NSMutableArray * shortDesignations;
    
    NSMutableArray * companyNameSuffix;
    NSMutableArray * shortCompanyNameSuffix;
}
@end

@implementation DVCheckerUtility


#pragma mark - Primary Separate Methods
//====================================


// Inndividual method for Company-name check
-(BOOL)checkCompanyName:(NSString*)inputString{
    
    // Set up Data Source for Company Suffixes
    [self companyDataInitialise];
    return [self processCompanyNameInput:[inputString lowercaseString]];
}

// Inndividual method for Designation check
-(BOOL)checkDesignation:(NSString*)inputString{
    [self designationDataInitialise];
    return [self processDesignationInput:[inputString lowercaseString]];
}


-(BOOL)isLastCharacterDot:(NSString*)input{
    return ([input hasSuffix:@"."] &&
            [shortDesignations containsObject:[input substringToIndex:[input length]-1]]);
}


#pragma mark- Company Suffixes Data Source
//=========================================
-(void)companyDataInitialise{
    companyNameSuffix = [[NSMutableArray alloc] initWithObjects:@"incorporation",@"corporation",@"banking",@"limited",
                         @"solutions",@"solution",@"institute",@"union",@"foundation",@"syndicate",@"society",@"fund",
                         @"club",@"association",@"trust",@"enterprise",@"enterprises",@"cabs",@"incorporated",
                         @"university",@"company",@"industries",@"healthcare",@"technology",@"technologies",@"partnership",
                         @"service",@"group",@"college",@"colleges",@"services",@"systems",@"computers",@"automation",
                         @"robotics",@"cabs", @"media",@"sales",@"contractors",@"agencies",@"agency",@"products",nil];
    
    shortCompanyNameSuffix = [[NSMutableArray alloc]
                              initWithObjects:@"inc",@"co",@"corp",@"ltd",@"pvt",@"llc",@"lc",@"plc",@"pa",@"pllc"
                              ,@"psc",@"pvt.ltd",@"com",nil];
}


#pragma mark- Designation Preffixes Suffixes Data Source
//======================================================

-(void)designationDataInitialise{
    
    
    
    // 1. if these are Suffixes sub-strings of input
    modalDesignations = [[NSMutableArray alloc] initWithObjects:
                         @"accredited",@"associate",@"behavioral",@"board",@"certified",@"chartered",
                         @"director",@"manager",@"engineer",@"developer",@"dealer",@"administrator",
                         @"marketer",@"analyst",@"lead",@"trainee",@"specialist",@"partner",@"member",
                         @"chairman",@"president",@"founder",@"staff",@"officer",@"leader",@"commissioner",
                         @"principal",@"supervisor",@"secretary",@"doctor",@"chancellor",@"dean",@"architect",
                         @"ordinator",@"chairperson",@"manufacturer",@"importer",@"exporter",@"agent",nil];
    
    // 2. If these are first word
    prefixDesignation = [[NSMutableArray alloc] initWithObjects:
                         @"managing",@"ceo",@"it",@"deputy",@"head",@"assistant",@"vice",@"senior",
                         @"general",@"asst",@"gm",@"junior",@"joint",@"chief",@"executive",@"jr",@"sr",
                         nil];

    
    
    
    // 3. If first word is short form
    shortDesignations = [[NSMutableArray alloc] initWithObjects:@"sr",@"jr",@"asst",@"gm",@"c.e.o",@"i.t",nil];

}


#pragma mark - Processing Methods for deduction
//=============================================
-(BOOL)processDesignationInput:(NSString*)input{
    
    NSArray * stringComponentsArray = [input componentsSeparatedByString:@" "];
    NSString * firstWord = stringComponentsArray[0];
    
    if([firstWord hasSuffix:@"."] &&
       [shortDesignations containsObject:[firstWord substringToIndex:[firstWord length]-1]]){
        return YES;
    }
    else if([prefixDesignation containsObject:firstWord] || [modalDesignations containsObject:firstWord]){
        return YES;
        
    }
    else{

        NSArray * newArray=[prefixDesignation arrayByAddingObjectsFromArray:modalDesignations];
        return [self isRestValidWithSource:newArray forInput:input];
    }
}


-(BOOL)processCompanyNameInput:(NSString*)input{
    
    NSArray * stringComponentsArray = [input componentsSeparatedByString:@" "];
    
    NSString * lastWord = [stringComponentsArray lastObject];

    if([lastWord hasSuffix:@"."] ){
        
        if([shortCompanyNameSuffix containsObject:[lastWord substringToIndex:[lastWord length]-1]]){
            return YES;
        }
    }
    else if ([companyNameSuffix containsObject:lastWord] || [shortCompanyNameSuffix containsObject:lastWord]){
        return YES;
    }
    else{
        
        NSArray * newArray=[companyNameSuffix arrayByAddingObjectsFromArray:shortCompanyNameSuffix];
        
        return [self isRestValidWithSource:newArray forInput:input];
    }
    return NO;
}

-(BOOL)isRestValidWithSource:(NSArray*)combinedArray forInput:(NSString*)input{
    
    NSString * formattedString=  [self replaceCharacters:@".-," from:input withString:@" "];
    NSArray * formattedStringArray = [formattedString componentsSeparatedByString:@" "];
    
    NSMutableSet* set1 = [NSMutableSet setWithArray:combinedArray];
    NSMutableSet* set2 = [NSMutableSet setWithArray:formattedStringArray];
    [set1 intersectSet:set2];
    NSArray* result = [set1 allObjects];
    
    return (result.count>0 ? YES:NO);

    
}
-(NSString *)replaceCharacters:(NSString*)specialChars from:(NSString*)input withString:(NSString*)replacedString{
    
    NSString * inputString = input;
    
    for (NSInteger charIdx=0; charIdx<specialChars.length; charIdx++){
        NSString * stringToReplace = [NSString stringWithFormat:@"%c",[specialChars characterAtIndex:charIdx]];
        inputString = [inputString stringByReplacingOccurrencesOfString:stringToReplace withString:replacedString];
    }
    
    return inputString;
    
}



@end


