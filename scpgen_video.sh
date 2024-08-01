#!/bin/bash

ORIGDIR=$PWD
echo '#!/bin/bash' > moviescript.sh
echo ' ' >> moviescript.sh

for path in $@; do 
      cd $path/movie
      echo ""`scpgen.sh movie.mp4`" "$path".mp4 ." >> $ORIGDIR/moviescript.sh
      cd $ORIGDIR
 done

