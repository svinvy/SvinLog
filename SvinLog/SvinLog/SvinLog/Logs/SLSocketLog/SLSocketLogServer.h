//
//  SLSocketLogServer.h
//  SvinLog
//
//  Created by GJP on 2018/3/23.
//  Copyright © 2018年 svinvy.lnc. All rights reserved.
//

#ifndef SLSocketLogServer_h
#define SLSocketLogServer_h

#include <stdio.h>
#include <netinet/in.h>
#include <unistd.h>

void listening(int port,char**err);

typedef struct sockaddr SA;
typedef struct sockaddr_in IPv4;
#endif /* SLSocketLogServer_h */
