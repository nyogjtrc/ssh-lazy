#!/bin/bash
#
# program for easy load ssh ip 
#
# author nyo
# create project at 2013-02-16
#
# version 0.2 
# release at 2014-01-28

#
# define
#
SSH_CMD="ssh"
MY_DIR=`dirname $0`

#
# include
#
source $MY_DIR/lazy_machine.sh

#
# functions
#
usage() 
{
    echo "usage:"
    exit 2
}

print_ip_list()
{
    load_ip_list
    #[[ "${!IP_A[@]}" ]] || return
    #if [ "${!IP_A}" ]; then
    #    echo exsist
    #else
    #    echo not exsist
    #fi
    load_ip_comment
    
    for VAR in ${!IP_A[*]}
    do
        echo ' '$VAR : ${IP_A[$VAR]} : ${IP_C[$VAR]}
    done
}

#
# main
#
main()
{
    echo 'welcome to ssh lazy.'

    load_ip_list

    #echo ${IP_A[*]}

    if ! [[ "$1" =~ ^[0-9]+$ ]]; then
        exec >&2
        echo "error: Not a number"
        exit 1
    elif [ "$1" == 0 ]; then
        #echo ${IP_A[*]}
        print_ip_list
    else
        TO_EXEC="$SSH_CMD ${IP_A[$1]}"
        echo $TO_EXEC
        $TO_EXEC
        echo end $TO_EXEC
    fi 
    exit 0
}

# check args
if [ $# = 0 ]; then
    usage;
fi

main ${@:-`cat`}
