#! /bin/bash

filename="id_rsa"
path="$HOME/.ssh"


echo "Enter hostname ip address"
read  hostname
echo "Enter password for new user"
read -s  -r password

if [ -f $path/$filename ]
then
    echo "RSA key exists on $path/$filename, using existing file"
else
    ssh-keygen -t rsa -f "$path/$filename" -C "$COMMENT"
    echo RSA key pair generated
fi

input="username.txt"
IFS=$'\n'
for username in `cat $input`; do
   echo "$username"
   echo "login into $hostname"
   ssh "$hostname" -l ubuntu " sudo useradd -m -s /bin/bash "$username"; echo ""$username":"$password"" | sudo chpasswd "
   cat "$path/$filename.pub" |sshpass -p "$password" ssh "$hostname" -l "$username" ' [ -d ~/.ssh ] || \
                                                             mkdir -p ~/.ssh ; \
                                                             cat > ~/.ssh/KEY ; \
                                                             KEY=$(cat ~/.ssh/KEY) ; \
                                                             export KEY ; \
                                                             cat ~/.ssh/KEY >> .ssh/authorized_keys ; \
                                                             chmod 700 ~/.ssh ; \
                                                             chmod 600 ~/.ssh/authorized_keys ;
                                                             rm ~/.ssh/KEY'
   status=$?

if [ $status -eq 0 ]
then
   echo "Set up complete, try to ssh to $hostname now"
else
   echo "An error has occured"
fi
done
