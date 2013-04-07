#!/bin/sh

VERSIONS=( "1.8.7-p371" "1.9.3-p392" "2.0.0-p0" )

# exit with error if rbenv is not executable
if [ ! -z rbenv ]; then
    echo "rbenv is not installed or included in PATH.\n" > /dev/null 
fi

# install roop with VERSIONS
for version in ${VERSIONS[@]}
do
   rbenv install ${version}
    if [ $? -ne 0 ]; then
        echo "Some problem might occour during installing version ${version}.\n" > /dev/null
        exit 1
    fi
    rbenv rehash
done

# exit when succeed
echo "Done."
exit 0
