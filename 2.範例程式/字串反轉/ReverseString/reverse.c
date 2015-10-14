//
//  reverse.c
//  lookDoc
//
//  Created by JzChang on 13/1/9.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char * reverseStr(const char *oriStr)
{
    int i;
    
    char *result = malloc(sizeof(char));
    
    for (i = 0; i < strlen(oriStr); i++) {
        result[ i ] = oriStr[ strlen(oriStr) - 1 - i ];
    }
    
    result[ i ] = '\0';
    
    return result;
}
