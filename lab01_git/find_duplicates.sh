#!/bin/bash
#This is a simple script that return the name of duplicated files in a directory

declare -A array
shopt -s globstar

for file in **; do #for lopp of the files in the directory
  [[ -f "$file" ]] || continue

  read cksm _ < <(md5sum "$file") 
  if ((array[$cksm]++)); then #if a file have the same checksum value its duplicated
    echo "This file/files is duplicated $file" #This line returns the name
  fi
done

#References
#Modified from http://superuser.com/questions/386199/how-to-remove-duplicated-files-in-a-directory 

