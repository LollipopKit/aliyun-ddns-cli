# Intro
According to the [origin version](https://github.com/honwen/aliyun-ddns-cli), this version support set multiple domains and automatic binaries releasing([Release](https://github.com/LollipopKit/aliyun-ddns-cli/releases)). 


# Usage
- 1.Get `AccessKeyID` and `AccessKeySecret` from your [Aliyun RAM Control Panel](https://ram.console.aliyun.com/manage/ak).
- 2.There are two example ways to run this DDNS tool on your server.   
 
**Attention: You can set multiple domains use param `--domain` with separator `/`. eg: `--domain ddns.a.com/ddns.b.com`**
#### Bash
```bash
# Automatic get IP from public API
./aliyun-ddns-cli --id ${AccessKeyID} --secret ${AccessKeySecret} auto-update --domain ddns.example.win
# or
# Manually set IP addr
./aliyun-ddns-cli --id ${AccessKeyID} --secret ${AccessKeySecret} update --domain ddns.example.win --ipaddr $(ifconfig pppoe-wan | sed -n '2{s/[^0-9]*://;s/[^0-9.].*//p}')
```
or
#### Docker
```bash
$ docker pull chenhw2/aliyun-ddns-cli
$ docker run -d \
    -e "AKID=[ALIYUN's AccessKey-ID]" \
    -e "AKSCT=[ALIYUN's AccessKey-Secret]" \
    -e "DOMAIN=ddns.aliyun.win" \
    -e "REDO=600" \
    chenhw2/aliyun-ddns-cli
```


# Thanks
Go Package: [alidns](https://github.com/denverdino/aliyungo)
# Advanced Usage
```
$ docker run --rm chenhw2/aliyun-ddns-cli -h
NAME:
   aliddns - aliyun-ddns-cli

USAGE:
   aliyun-ddns-cli [global options] command [command options] [arguments...]

VERSION:
   Git:[MISSING BUILD VERSION [GIT HASH]] (go1.16)

COMMANDS:
   help, h  Shows a list of commands or help for one command

   DDNS:
     list         List AliYun's DNS DomainRecords Record
     delete       Delete AliYun's DNS DomainRecords Record
     update       Update AliYun's DNS DomainRecords Record, Create Record if not exist
     auto-update  Auto-Update AliYun's DNS DomainRecords Record, Get IP using its getip

   GET-IP:
     getip          Get IP Combine 12 different Web-API
     resolve        Get DNS-IPv4 Combine 5 DNS Upstream

GLOBAL OPTIONS:
   --access-key-id value, --id value          AliYun's Access Key ID
   --access-key-secret value, --secret value  AliYun's Access Key Secret
   --ipapi value, --api value                 Web-API to Get IP, like: http://myip.ipip.net
   --help, -h                                 show help
   --version, -v                              print the version
```
