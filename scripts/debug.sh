#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"
cd ..


#Dependency :
#sudo apt install libzstd-dev

rm  sample.ppm.zst sampleRecode.ppm depth16Recode.ppm segmentRecode.ppm 

gcc zstdInput.c  -D_GNU_SOURCE -O0 -g3 -fno-omit-frame-pointer -Wstrict-overflow  -fPIE -fPIC -lzstd -lm -o zstdInput 

valgrind --tool=memcheck --leak-check=yes --show-reachable=yes --track-origins=yes --num-callers=20 --track-fds=yes ./zstdInput compress sample.ppm sample.pzm $@ 2>error1.txt
valgrind --tool=memcheck --leak-check=yes --show-reachable=yes --track-origins=yes --num-callers=20 --track-fds=yes ./zstdInput decompress sample.pzm sampleRecode.ppm  $@ 2>error2.txt
 

valgrind --tool=memcheck --leak-check=yes --show-reachable=yes --track-origins=yes --num-callers=20 --track-fds=yes ./zstdInput compress depth16.pnm depth16.pzm $@ 2>error3.txt
valgrind --tool=memcheck --leak-check=yes --show-reachable=yes --track-origins=yes --num-callers=20 --track-fds=yes ./zstdInput decompress depth16.pzm depth16Recode.ppm  $@ 2>error4.txt


valgrind --tool=memcheck --leak-check=yes --show-reachable=yes --track-origins=yes --num-callers=20 --track-fds=yes ./zstdInput compress segment.ppm segment.pzm $@ 2>error5.txt
valgrind --tool=memcheck --leak-check=yes --show-reachable=yes --track-origins=yes --num-callers=20 --track-fds=yes ./zstdInput decompress segment.pzm segmentRecode.ppm  $@ 2>error6.txt

exit 0
