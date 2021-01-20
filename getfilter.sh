#!/bin/sh
set +e

cd "$DATA_DIR"

curl https://raw.githubusercontent.com/Loukky/gfwlist-by-loukky/master/gfwlist.txt | base64 -d | sort -u | sed '/^$\|@@/d'| sed 's#!.\+##; s#|##g; s#@##g; s#http:\/\/##; s#https:\/\/##;' | sed '/\*/d; /apple\.com/d; /sina\.cn/d; /sina\.com\.cn/d; /baidu\.com/d; /qq\.com/d' | sed '/^[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+$/d' | grep '^[0-9a-zA-Z\.-]\+$' | grep '\.' | sed 's#^\.\+##' | sort -u > ./gfwlist1.txt
curl https://raw.githubusercontent.com/hq450/fancyss/master/rules/gfwlist.conf | sed 's/ipset=\/\.//g; s/\/gfwlist//g; /^server/d' > ./koolshare.txt 

if [ -f "./gfwlist1.txt" ] && [ -f "./koolshare.txt" ]
then
  cat ./gfwlist1.txt ./koolshare.txt | sort -u > ./gfw_list.txt
  rm ./gfwlist1.txt  ./koolshare.txt
else
  exit 1
fi

curl https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf  | sed 's/server=\///g;s/\/114.114.114.114//g' > ./china_list1.txt
curl https://raw.githubusercontent.com/hq450/fancyss/master/rules/WhiteList_new.txt  | sed 's/Server=\///g;s/\///g' > ./china_list2.txt 

if [ -f "./china_list1.txt" ] && [ -f "./china_list2.txt" ]
then
  cat ./china_list1.txt ./china_list2.txt | sort -u > ./china_list.txt
  rm ./china_list1.txt ./china_list2.txt
else
  exit 1
fi

curl https://raw.githubusercontent.com/17mon/china_ip_list/master/china_ip_list.txt >  china_ip_list1.txt

if [ -f "china_ip_list1.txt" ]
then
  cp china_ip_list1.txt china_ip_list.txt
  rm china_ip_list1.txt
else
  exit 1
fi

set -e