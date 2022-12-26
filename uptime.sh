#!/bin/bash
mkdir -p ./data
cd data

touch 192.168.2.01
touch 192.168.2.20

touch 192.168.2.005
touch 192.168.2.010
touch 192.168.2.015
touch 192.168.2.021

# 测试
Test_ip(){
if [ ! -s $1 ]  
then
    echo > $1
fi

ping -c 1 -W 2 $1
if [ $? -eq 0 ]; then
    sed -i "1 i ✅|"  $1
else
    sed -i "1 i ❌|"  $1
fi
}

for i in *
do
    echo    $i
    Test_ip $i
done

# 打印数据
cat ../head.md           >  ../show.md
for i in *
do
    echo -n "|"$(echo $i | awk -F '.' '{print $4}')"|"   >> ../show.md
    head -n 30  $i | tr -d '\n'                          >> ../show.md
    echo                                                 >> ../show.md
done