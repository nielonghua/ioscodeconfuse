//
//  IntTypeLogic.m
//  codeconfuse
//
//  Created by Martin on 2018/5/15.
//  Copyright © 2018年 Martin Liu. All rights reserved.
//

#import "FloatTypeLogic.h"
#import "CodeGenerator.h"
@implementation FloatTypeLogic
- (NSString *)ifFunction:(VariableInfo *)a b:(VariableInfo *)b c:(VariableInfo *)c {
    
    NSArray *nameArr = [NSArray arrayWithObjects:a,b,c, nil];
    
    NSDictionary *nameDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:b,c, nil],a.name,[NSArray arrayWithObjects:a,c, nil],b.name,[NSArray arrayWithObjects:a,b, nil],c.name, nil];
    NSArray *logicArr = [NSArray arrayWithObjects:@"||",@"&&", nil];
    
    int index = arc4random()%[nameArr count];
    
    VariableInfo *var1 = [nameArr objectAtIndex:index];
    
    NSArray *otherVarArr = [nameDic valueForKey:var1.name];
    NSString *l1 = [logicArr objectAtIndex:(arc4random()%[logicArr count])];
    
    VariableInfo *var2 =nil;
    VariableInfo *var3=nil;
    
    if (arc4random()%2) {
        var2 = [otherVarArr objectAtIndex:0];
        var3 = [otherVarArr objectAtIndex:1];
    } else {
        var2 = [otherVarArr objectAtIndex:1];
        var3 = [otherVarArr objectAtIndex:0];
    }
    NSMutableString *str = [NSMutableString new];
    NSArray *equalArr = [NSArray arrayWithObjects:@"==",@">",@"<", nil];
    NSArray *e1 =[equalArr objectAtIndex:arc4random()%[equalArr count]];
    NSArray *e2 =[equalArr objectAtIndex:arc4random()%[equalArr count]];
   
    [str appendString:@"if("];
    [str appendFormat:@"%@ %@ %@ %@ %@ %@ %@",[mCg variableStr:var1 isSet:NO],e1,[mCg variableStr:var2 isSet:NO],l1,[mCg variableStr:var1 isSet:NO],e2,[mCg variableStr:var3 isSet:NO]];
    
    [str appendString:@")"];
    [str appendString:@"{\n"];
    
    
    NSArray *assigArr = [NSArray arrayWithObjects:@"=",@"+=",@"*=",@"-=", nil];
    
    NSArray *opArr = [NSArray arrayWithObjects:@"+",@"-",@"x",@"/", nil];
    
    int num = 1+arc4random()%[assigArr count];
    
    for (int i=0; i<num; i++) {
        NSString *a1 = [assigArr objectAtIndex:(arc4random()%[assigArr count])];
        NSString *op1 = [opArr objectAtIndex:(arc4random()%[opArr count])];
        
        index = arc4random()%[nameArr count];
        
        var1 = [nameArr objectAtIndex:index];
        
        otherVarArr = [nameDic valueForKey:var1.name];
        
        if (arc4random()%2) {
            var2 = [otherVarArr objectAtIndex:0];
            var3 = [otherVarArr objectAtIndex:1];
        } else {
            var2 = [otherVarArr objectAtIndex:1];
            var3 = [otherVarArr objectAtIndex:0];
        }
        int r = arc4random()%2;
        if (r==1) {
            if(arc4random()%2==0){
                [str appendFormat:@"%@ %@ %@;",[mCg variableStr:var1 isSet:NO],a1,[mCg variableStr:var3 isSet:NO]];
            } else {
                [str appendFormat:@"%@ %@ %@;",[mCg variableStr:var1 isSet:NO],a1,[mCg variableStr:var3 isSet:NO]];
            }
        } else {
            if ([op1 isEqualToString:@"x"]) {
                op1 = @"*";
            }
            if ([op1 isEqualToString:@"/"]) {
                [str appendFormat:@"if(%@==0) %@=1;",[mCg variableStr:var3 isSet:NO],[mCg variableStr:var3 isSet:NO]];
            }
            [str appendFormat:@"%@ %@ (%@ %@ %@);",[mCg variableStr:var1 isSet:NO],a1,[mCg variableStr:var2 isSet:NO],op1,[mCg variableStr:var3 isSet:NO]];
        }
    }
    [str appendString:@"}"];
    return str;
}

- (NSString *)forFunction:(VariableInfo *)a b:(VariableInfo *)b c:(VariableInfo *)c {
    NSArray *nameArr = [NSArray arrayWithObjects:a,b,c, nil];
    
    NSDictionary *nameDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:b,c, nil],a.name,[NSArray arrayWithObjects:a,c, nil],b.name,[NSArray arrayWithObjects:a,b, nil],c.name, nil];
    
    int index = arc4random()%[nameArr count];
    
    VariableInfo *var1 = [nameArr objectAtIndex:index];
    
    NSArray *otherVarArr = [nameDic valueForKey:var1.name];
    
    VariableInfo *var2 =nil;
    VariableInfo *var3=nil;
    
    if (arc4random()%2) {
        var2 = [otherVarArr objectAtIndex:0];
        var3 = [otherVarArr objectAtIndex:1];
    } else {
        var2 = [otherVarArr objectAtIndex:1];
        var3 = [otherVarArr objectAtIndex:0];
    }
    NSMutableString *str = [NSMutableString new];
    
    
    NSString *randomName1 = [[DataBase shareInstance] randomName:14];
    NSString *randomName2 = [[DataBase shareInstance] randomName:14];
    NSString *randomName3 = [[DataBase shareInstance] randomName:14];
    NSString *randomName = [[DataBase shareInstance] randomName:14];
    [str appendFormat:@"int %@ = (int)%@;\n",randomName1,[mCg variableStr:var1 isSet:NO]];
   
    [str appendFormat:@"int %@=%@+arc4random()%%2-%@;\nfor(int i=0;i<%@;i++)",randomName,randomName1, randomName1,randomName];
    [str appendString:@"{\n"];
    
    
    NSArray *assigArr = [NSArray arrayWithObjects:@"=",@"+=",@"*=",@"-=", nil];
    
    NSArray *opArr = [NSArray arrayWithObjects:@"+",@"-",@"x",@"/", nil];
    
    int num = 1+arc4random()%[assigArr count];
    
    for (int i=0; i<num; i++) {
        NSString *a1 = [assigArr objectAtIndex:(arc4random()%[assigArr count])];
        NSString *op1 = [opArr objectAtIndex:(arc4random()%[opArr count])];
        
        index = arc4random()%[nameArr count];
        
        var1 = [nameArr objectAtIndex:index];
        
        otherVarArr = [nameDic valueForKey:var1.name];
        
        
        if (arc4random()%2) {
            var2 = [otherVarArr objectAtIndex:0];
            var3 = [otherVarArr objectAtIndex:1];
        } else {
            var2 = [otherVarArr objectAtIndex:1];
            var3 = [otherVarArr objectAtIndex:0];
        }
        randomName1 = [[DataBase shareInstance] randomName:14];
        randomName2 = [[DataBase shareInstance] randomName:14];
        randomName3 = [[DataBase shareInstance] randomName:14];
        
        
        
        int r = arc4random()%2;
        if (r==1) {
            if(arc4random()%2==0){
                [str appendFormat:@"int %@ = (int)%@;\n",randomName1,[mCg variableStr:var1 isSet:NO]];
                [str appendFormat:@"int %@ = (int)%@;\n",randomName2,[mCg variableStr:var2 isSet:NO]];
                [str appendFormat:@"%@ %@ %@;\n",randomName1,a1,randomName2];
            } else {
                [str appendFormat:@"int %@ = (int)%@;\n",randomName1,[mCg variableStr:var1 isSet:NO]];
                [str appendFormat:@"int %@ = (int)%@;\n",randomName3,[mCg variableStr:var3 isSet:NO]];
                [str appendFormat:@"%@ %@ %@;\n",randomName1,a1,randomName3];
            }
        } else {
            [str appendFormat:@"int %@ = (int)%@;\n",randomName1,[mCg variableStr:var1 isSet:NO]];
            [str appendFormat:@"int %@ = (int)%@;\n",randomName2,[mCg variableStr:var2 isSet:NO]];
            [str appendFormat:@"int %@ = (int)%@;\n",randomName3,[mCg variableStr:var3 isSet:NO]];
            if ([op1 isEqualToString:@"x"]) {
                op1 = @"*";
            }
            if ([op1 isEqualToString:@"/"]) {
                [str appendFormat:@"if(%@==0){\n %@=1;\n}\n",randomName3,randomName3];
            }
            
            [str appendFormat:@"%@ %@ (%@ %@ %@);\n",randomName1,a1,randomName2,op1,randomName3];
        }
    }
    randomName1 = [[DataBase shareInstance] randomName:14];
    
    [str appendFormat:@"int %@=arc4random() %% 2;\n if(%@==0)\n{break;}",randomName1,randomName1];
    [str appendString:@"}\n"];
    return str;
}

-(NSString *)switchFunction:(VariableInfo *)a b:(VariableInfo *)b c:(VariableInfo *)c {
    NSArray *nameArr = [NSArray arrayWithObjects:a,b,c, nil];
    
    NSDictionary *nameDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:b,c, nil],a.name,[NSArray arrayWithObjects:a,c, nil],b.name,[NSArray arrayWithObjects:a,b, nil],c.name, nil];
    
    int index = arc4random()%[nameArr count];
    
    VariableInfo *var1 = [nameArr objectAtIndex:index];
    
    NSArray *otherVarArr = [nameDic valueForKey:var1.name];
    
    VariableInfo *var2 =nil;
    VariableInfo *var3=nil;
    
    if (arc4random()%2) {
        var2 = [otherVarArr objectAtIndex:0];
        var3 = [otherVarArr objectAtIndex:1];
    } else {
        var2 = [otherVarArr objectAtIndex:1];
        var3 = [otherVarArr objectAtIndex:0];
    }
    NSMutableString *str = [NSMutableString new];
    
    
    NSString *randomName = [[DataBase shareInstance] randomName:14];
    
    int caseNum = 2+arc4random()%3;
    [str appendFormat:@"int %@=((int)%@)%%5;\n",randomName,[mCg variableStr:var1 isSet:NO]];
    [str appendFormat:@"switch(%@){\n",randomName];
    
    for (int i=0; i<caseNum; i++) {
        NSArray *assigArr = [NSArray arrayWithObjects:@"=",@"+=",@"*=",@"-=", nil];
        
        NSArray *opArr = [NSArray arrayWithObjects:@"+",@"-",@"x",@"/", nil];
        
        int num = 1+arc4random()%[assigArr count];
        [str appendFormat:@"case %d :{\n",i];
        
        for (int i=0; i<num; i++) {
            NSString *a1 = [assigArr objectAtIndex:(arc4random()%[assigArr count])];
            NSString *op1 = [opArr objectAtIndex:(arc4random()%[opArr count])];
            
            index = arc4random()%[nameArr count];
            
            var1 = [nameArr objectAtIndex:index];
            
            otherVarArr = [nameDic valueForKey:var1.name];
            
            
            if (arc4random()%2) {
                var2 = [otherVarArr objectAtIndex:0];
                var3 = [otherVarArr objectAtIndex:1];
            } else {
                var2 = [otherVarArr objectAtIndex:1];
                var3 = [otherVarArr objectAtIndex:0];
            }
            int r = arc4random()%2;
            if (r==1) {
                if(arc4random()%2==0){
                    NSString *randomName1 = [[DataBase shareInstance] randomName:14];
                    NSString *randomName2 = [[DataBase shareInstance] randomName:14];
                    [str appendFormat:@"int %@ = (int)%@;\n",randomName1,[mCg variableStr:var1 isSet:NO]];
                    [str appendFormat:@"int %@ = (int)%@;\n",randomName2,[mCg variableStr:var2 isSet:NO]];
                    
                    [str appendFormat:@"%@ %@ %@;",randomName1,a1,randomName2];
                } else {
                    NSString *randomName1 = [[DataBase shareInstance] randomName:14];
                    NSString *randomName3 = [[DataBase shareInstance] randomName:14];
                    [str appendFormat:@"int %@ = (int)%@;\n",randomName1,[mCg variableStr:var1 isSet:NO]];
                    [str appendFormat:@"int %@ = (int)%@;\n",randomName3,[mCg variableStr:var3 isSet:NO]];
                    
                    [str appendFormat:@"%@ %@ %@;",randomName1,a1,randomName3];
                }
            } else {
                NSString *randomName1 = [[DataBase shareInstance] randomName:14];
                NSString *randomName2 = [[DataBase shareInstance] randomName:14];
                NSString *randomName3 = [[DataBase shareInstance] randomName:14];
                [str appendFormat:@"int %@ = (int)%@;\n",randomName1,[mCg variableStr:var1 isSet:NO]];
                [str appendFormat:@"int %@ = (int)%@;\n",randomName2,[mCg variableStr:var2 isSet:NO]];
                [str appendFormat:@"int %@ = (int)%@;\n",randomName3,[mCg variableStr:var3 isSet:NO]];
                
                
                if ([op1 isEqualToString:@"x"]) {
                    op1 = @"*";
                }
                if ([op1 isEqualToString:@"/"]) {
                    [str appendFormat:@"if(%@==0) %@=1;",randomName3,randomName3];
                }
                [str appendFormat:@"%@ %@ (%@ %@ %@);",randomName1,a1,randomName2,op1,randomName3];
            }
            
        }
        [str appendString:@"}\n"];
    }
    
    [str appendString:@"}\n"];
    return str;
    
}
@end
