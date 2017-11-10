option domain-name "example.com";
option domain-name-servers ns1.example.com;
option subnet-mask 255.255.255.0;
default-lease-time 600;
max-lease-time 7200;
server-name "servername";

subnet 192.168.1.0 netmask 255.255.255.0 {
  range 192.168.1.200 192.168.1.253;
  option routers 192.168.1.1;
}

host clientname {
  filename "/tftpboot.img";
  server-name "servername";
  next-server servername;
  hardware ethernet 01:23:45:67:89:AB;
  fixed-address 192.168.1.90;
}

##

option domain-name "example.com";

default-lease-time 600;
max-lease-time 7200;

allow booting;
allow bootp;

# The next paragraph needs to be modified to fit your case
subnet 192.168.1.0 netmask 255.255.255.0 {
  range 192.168.1.200 192.168.1.253;
  option broadcast-address 192.168.1.255;
# the gateway address which can be different
# (access to the internet for instance)
  option routers 192.168.1.1;
# indicate the dns you want to use
  option domain-name-servers 192.168.1.3;
}

group {
  next-server 192.168.1.3;
  host tftpclient {
# tftp client hardware address
  hardware ethernet  00:10:DC:27:6C:15;
  filename "pxelinux.0";
 }
}

bootps  dgram  udp  wait  root  /usr/sbin/bootpd  bootpd -i -t 120

client:\
  hd=/tftpboot:\
  bf=tftpboot.img:\
  ip=192.168.1.90:\
  sm=255.255.255.0:\
  sa=192.168.1.1:\
  ha=0123456789AB:
