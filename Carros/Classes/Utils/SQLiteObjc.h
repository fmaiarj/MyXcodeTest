//
//  SQLiteObjc.h
//  Carros
//
//  Created by Luiz Felipe Oliveira Maia on 21/02/17.
//  Copyright © 2017 Ricardo Lecheta. All rights reserved.
//

#ifndef SQLiteObjc_h
#define SQLiteObjc_h


#endif /* SQLiteObjc_h */



#import <Foundation/Foundation.h>
#import "sqlite3.h"


@interface SQLiteObjc : NSObject


+ (void) bindText:(sqlite3_stmt *)stmt idx:(int)idx withString:(NSString*)s;

+ (NSString*) getText:(sqlite3_stmt *)stmt idx:(int)idx;


@end
