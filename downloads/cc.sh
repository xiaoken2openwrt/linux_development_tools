#!/bin/sh

ignorefile=`cat .ctagsignore `
echo ${ignorefile}

ignorepath=""
for p in ${ignorefile}
do
#    if [ ! ${ignorepath[0]} ]; then
#        ignorepath="${ignorepath} -path ${p}"
#    else
#        ignorepath="${ignorepath} -o -path ${p}"
#    fi
    ignorepath=${ignorepath}" -o -path ./"${p}
done

echo ${ignorepath}
ignorepath=${ignorepath:3}
echo ${ignorepath}

#find . \( -path './.git' -o  -path './ci' \) -prune -o -print  >cscope.file
#find . \( ${ignorepath} \) -prune -o -print  >cscope.files
#find . \( ${ignorepath} \) -prune -o -type f -name *.c -print  >cscope.files
find . \( ${ignorepath} \) -prune -o -type f \( -name "*.cpp" -o -name "*.cc" -o -name "*.c" -o -name "*.h" \) -print  >cscope.files


#cscope -Rbkq;ctags -R --exclude=@.ctagsignore  *
cscope -bkq -i cscope.files;ctags -R --exclude=@.ctagsignore  *

