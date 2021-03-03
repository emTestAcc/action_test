# STEP 3 install required libraries for building apps

# seemes to be nessesary to run from test-dir with current debian release
apt-get install -y apt-utils

echo -e "\ndeb http://http.us.debian.org/debian/ testing non-free contrib main" >> /etc/apt/sources.list

apt-get update -y
apt-get install -y gcc
apt-get install -y g++

# for canOpenRW
apt-get install -y libgmp-dev

# for generating canOpenPLC01.h
apt-get install python-gtk2-dev -y

#Install gtest
apt-get install -y googletest
#googletest-combatabillity hack:
ln -sf /usr/src/googletest/googletest/lib/libgtest.a /usr/lib/gcc/x86_64-linux-gnu/10/libgtest.a 
ln -sf /usr/src/googletest/googletest/lib/libgtest_main.a /usr/lib/gcc/x86_64-linux-gnu/10/libgtest_main.a 
ln -sf /usr/src/googletest/googletest/include/gtest/ /usr/include/gtest
