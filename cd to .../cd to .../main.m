//
//  main.m
//  cd to ...
//
//  Created by James Tuley on 10/9/19.
//  Copyright © 2019 Jay Tuley. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <ScriptingBridge/ScriptingBridge.h>

#import "Finder.h"
#import "Terminal.h"

NSUInteger linesOfHistory(TerminalTab* tab) {
   NSString* hist = [[tab history] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    return [[hist componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] count];
}

/**
 启动vscode
 */
void lauchCode(NSString *path){
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/bash"];
    [task setArguments:@[@"/usr/local/bin/code", path]];
    [task launch];
}

/**
 启动subl
 */
void lauchSubl(NSString *path){
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/bash"];
    [task setArguments:@[@"/usr/local/bin/subl", @"-a", path]];
    [task launch];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        FinderApplication* finder = [SBApplication applicationWithBundleIdentifier:@"com.apple.Finder"];
        FinderItem *target = [(NSArray*)[[finder selection] get] firstObject];

        NSString* fileUrl = [target URL];
        NSURL* url = [NSURL URLWithString:fileUrl];
        lauchCode([url path]);
    }
}
