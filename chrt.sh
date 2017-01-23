#!/bin/bash
sudo -kSs << EOF
password
whoami
echo "Not a good idea to have a password encoded in plain text"
EOF
