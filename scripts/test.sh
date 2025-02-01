#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"
cd ..

#Dependency :
#sudo apt install libzstd-dev

#Compile
gcc zstdInput.c -lzstd -lm -o zstdInput 

#Test
mkdir output
./pzp compress samples/sample.ppm output/sample.pzp
./pzp decompress output/sample.pzp output/sampleRecode.ppm 

./pzp compress samples/depth16.pnm output/depth16.pzp
./pzp decompress output/depth16.pzp output/depth16Recode.ppm 

./pzp compress samples/rgb8.pnm output/rgb8.pzp
./pzp decompress output/rgb8.pzp output/rgb8Recode.ppm 

./pzp compress samples/segment.ppm output/segment.pzp
./pzp decompress output/segment.pzp output/segmentRecode.ppm 


exit 0
