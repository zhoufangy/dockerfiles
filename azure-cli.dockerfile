FROM alpine:3.10
LABEL description="azure-cli aliyuncli awscli"
RUN echo http://mirrors.aliyun.com/alpine/v3.10/main/ > /etc/apk/repositories && \
    echo http://mirrors.aliyun.com/alpine/v3.10/community/ >> /etc/apk/repositories
RUN apk update && apk upgrade
RUN apk add --no-cache curl tar openssl sudo bash jq

ENV AZURE_CLI_VERSION 2.0.60
RUN apk add py-pip && \
    apk add --virtual=build gcc libffi-dev musl-dev openssl-dev python-dev make

RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple/ \
&& pip config set install.trusted-host pypi.tuna.tsinghua.edu.cn
#RUN pip config list

RUN python -m pip install --upgrade pip \
&& pip install setuptools

#azure cli
RUN pip --default-timeout=1500 install azure-cli==${AZURE_CLI_VERSION} --upgrade
#RUN curl -sL https://aka.ms/InstallAzureCli | bash

#aliyun cli
RUN pip install aliyuncli --upgrade

#aws cli
RUN pip install awscli --upgrade