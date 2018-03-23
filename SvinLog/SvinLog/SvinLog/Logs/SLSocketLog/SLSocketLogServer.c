//
//  SLSocketLogServer.c
//  SvinLog
//
//  include this file for your routine program and call the function to bind the port and listening...
//  Created by GJP on 2018/3/23.
//  Copyright © 2018年 svinvy.lnc. All rights reserved.
//

#include "SLSocketLogServer.h"

void listening(int port,char**err)
{
    int listenfd,connfd;
    pid_t childpid;
    socklen_t cli_len;
    IPv4 cliaddr,servaddr;
    
    listenfd = socket(AF_INET, SOCK_STREAM, 0);
    if (listenfd) {
        *err = "Create socket fd failed!!!";return;
    }
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    servaddr.sin_port = htons(port);
    if (bind(listenfd, (SA*)&servaddr, sizeof(servaddr))==-1) {
        *err = "bind port fail!";return;
    }
    if (listen(listenfd, 10)!=0) {
        *err = "listen at fd  fail!";return;
    }
    while (1)
    {
        cli_len = sizeof(cliaddr);
        connfd = accept(listenfd, (SA*)&cliaddr, &cli_len);
        if ((childpid=fork())!=0) {close(connfd);}
        else
        {
            close(listenfd);
            /* read the messages */
        }
    }
}
