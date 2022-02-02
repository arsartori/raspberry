#!/bin/bash
sudo cp /usr/share/doc/openvpn/examples/sample-keys/openssl.cnf /etc/openvpn/server/
 
openvpn --genkey --secret ta.key

# Create required directories and files
mkdir -p sample-ca
rm -f sample-ca/index.txt
touch sample-ca/index.txt
touch sample-ca/index.txt.attr
echo "01" > sample-ca/serial


# Generate CA key and cert
openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 \
    -extensions easyrsa_ca -keyout sample-ca/ca.key -out sample-ca/ca.crt \
    -subj "/C=VN/ST=SAIGON/L=SAIGON/O=OpenVPN-TEST/emailAddress=vpn@test.net" \
    -config openssl.cnf

# Create server key and cert
openssl req -new -nodes -config openssl.cnf -extensions server \
    -keyout sample-ca/server.key -out sample-ca/server.csr \
    -subj "/C=VN/ST=SAIGON/O=OpenVPN-TEST/CN=VPN-Server/emailAddress=vpn@test.net"

openssl ca -batch -config openssl.cnf -extensions server \
    -out sample-ca/server.crt -in sample-ca/server.csr

# Generate DH parameters
openssl dhparam -out dh2048.pem 2048
