#!/bin/bash

# Use the public_ip variable
public_ip=$1
echo "Public IP: ${public_ip}"

# Execute commands remotely via SSH
ssh -i /home/ubuntu/.ssh/sanjay.pem -o StrictHostKeyChecking=no -T ubuntu@${public_ip} << 'EOF'
cd /home/ubuntu/workspace
echo "Hello! Destroy being called" > destruction.txt
git add destruction.txt
git commit -m "Added file during destroy"
git push origin main
EOF
