#!/bin/sh

ignoreitem=`cat .ctagsignore `
echo ${ignoreitem}

ignorepath=""
ignorefile=""
for p in ${ignoreitem}
do
    if [ -d ${p} ]; then
		ignorepath=${ignorepath}" -o -path ./"${p}
	elif [ -f ${p} ];then
        ignorefile="${ignorefile} ./${p}"
	else
		echo "not match ${p}"
	fi
#    ignorepath=${ignorepath}" -o -path ./"${p}
done

echo ${ignorepath}
ignorepath=${ignorepath:3}
echo ${ignorepath}
echo ${ignorefile}

#find . \( -path './.git' -o  -path './ci' \) -prune -o -print  >cscope.file
#find . \( ${ignorepath} \) -prune -o -print  >cscope.files
#find . \( ${ignorepath} \) -prune -o -type f -name *.c -print  >cscope.files
find . \( ${ignorepath} \) -prune -o -type f \( -name "*.cpp" -o -name "*.cc" -o -name "*.c" -o -name "*.h" \) -print  >cscope.files

#exclude file
for p in ${ignorefile}
do
	grep -v "${p}"  cscope.files >cscope.temp
	mv cscope.temp cscope.files
done

#cscope -Rbkq;ctags -R --exclude=@.ctagsignore  *
cscope -bkq -i cscope.files;ctags -R --exclude=@.ctagsignore  *

