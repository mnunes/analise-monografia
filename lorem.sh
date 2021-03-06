#!/usr/bin/env bash
lorem(){
        while getopts ':w:p:s:h' flag; do
                case "$flag" in
                        p) [[ ! -z ${OPTARG} ]] && lorem-ipsum ${OPTARG} paragraphs | sed 's/\.$/\n/g';;
                        w) [[ ! -z ${OPTARG} ]] && lorem-ipsum ${OPTARG} words;;
                        s) [[ ! -z ${OPTARG} ]] && lorem-ipsum ${OPTARG} sentences;;
                        *|h) echo "use: $0 [-p,-w,-s] NUM → [paragraphs,words,sentences] numbers" && exit 1;;
                esac
        done
	exit 0
}

lorem "$@"


