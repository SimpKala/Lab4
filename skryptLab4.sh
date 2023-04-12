#!/bin/bash

function help {
    echo "Usage: $0 [OPTIONS]" #standardowa pierwsza linia skryptu z opcją help
    echo "OPTIONS: "
    echo "--date      to show today's date"
    echo "--logs [n]  to create 100 or n log files and to write file name, script name and date to created files"
    echo "--help      for help"
}

function logs {
    if [[ -z $1 ]]; then
           n=100
    else
           n=$1
    fi

    for i in $(seq 1 $n); do
           echo "File: log$i.txt" > log$i.txt
           echo "Script: $0" >> log$i.txt
           echo "Date: $(date)" >> log$i.txt
    done
}

while [[ %# -gt 0 ]]; do
    case "$1" in
           --date)
               echo "Today's date: $(date +%Y-%m-%d)"
               exit 0
               ;;
           --logs)
               logs $2
               exit 0
               ;;
           --help)
               help
               exit 0
               ;;
           *)
               echo "Error: wrong option: $1"
               help
               exit 1
               ;;
       esac
done

branch_name="taskBranch-$(date +%Y%m%d-%H%M%S)"
echo "Creating new branch $branch_name..."
git chechkout -b $branch_name

echo "Changing files..."
# changes are made here

echo "Making changes..."
git add .
git commit -m "Commit message"
git push

echo "Merging branch with main branch..."
git checkout main
git merge $branch_name

echo "Creating tag v1.0..."
git tag v1.0
git push --tags

