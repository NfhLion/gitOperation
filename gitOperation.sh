#!/bin/bash
tarBranch=""
tarRepository=""
tarOperation=""
noBranch="0"


if [ "$1" = "--help" ]; then
    echo "./gitOperation.sh [ tarOperation ] [ tarRepository ] [ tarBranch ]"
    echo "-------------------------------"
    echo "| default value:              |"
    echo "| tarOperation  = status      |"
    echo "| tarRepository = all-repos   |"
    echo "| tarBranch     = carbon      |"
    echo "--------------------------------------------------------"
    echo "| optional value:                                      |"
    echo "| tarOperation  = [ status|checkout|pull|fetch|clean ] |"
    echo "| tarRepository = [ ./dirs ]                           |"
    echo "| tarBranch     = [ optional branch ]                  |"
    echo "--------------------------------------------------------"
    exit 0
fi

case "$1" in
status)
    tarOperation="status"
    noBranch="1"
    ;;
checkout)
    tarOperation="checkout"
    ;;
pull)
    tarOperation="pull origin"
    ;;
fetch)
    tarOperation="fetch origin"
    ;;
clean)
    tarOperation="clean -dxf"
    noBranch="1"
    ;;
"")
    tarOperation="status"
    noBranch="1"
    ;;
esac
echo "============================================"
echo "tarOperation = $tarOperation"

if [ "$2" = "" ]; then
    tarRepository=""
elif [ "$2" = "all-repos" ]; then
    tarRepository=""
else
    tarRepository="$2"
fi

if [ "$noBranch" = "1" ]; then
    tarBranch=""
else
    if [ "$3" = "" ]; then
        tarBranch="carbon"
    else
        tarBranch="$3"
    fi
fi
    

echo "tarBranch = $tarBranch"

if [ "$tarRepository" != "" ]; then
    echo "[ $tarRepository use: git $tarOperation $tarBranch ]"
    echo "============================================"
    echo ""
    echo "<------------------$tarRepository------------------->"
    cd $tarRepository
    git $tarOperation $tarBranch
    cd ../
    exit 0
fi

echo "============================================"
echo ""
for tarRepository in `ls`; do
    if ! [ -d "$tarRepository" ]; then
        continue
    fi
    echo "<------------------$tarRepository------------------->"
    echo "[ $tarRepository use: git $tarOperation $tarBranch ]"
    cd "$tarRepository"
    git $tarOperation $tarBranch
    cd ../
done