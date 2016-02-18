# Warmup Questions

1.  What is the clone url of this repository?
    >   https://github.com/luiscarm9/lab_vision.git

2.  What is the output of the ``cal`` command?

      Febrero 2016      
do lu ma mi ju vi sá  
    1  2  3  4  5  6  
 7  8  9 10 11 12 13  
14 15 16 17 18 19 20  
21 22 23 24 25 26 27  
28 29                 
       Its the Calendar

# Homework Questions

1.  What is the ``grep``command?
    >   It allow you to search in a file a pattern, character or a complete line.

2.  What is a *makefile*?
    >   its an executable file that allow to install a programm inlinux using ./Makefile or make Makefile

4.  What does the ``-prune`` option of ``find`` do? Give an example
    >   It determinate how deep do you want to search default is true, if its a directory it will not descend over it. Example if you want to ignore a full directory you use: find where [name_parameter] '/directory/to/ignore' -prune it will ignore the whole directory

5.  Where is the ``grub.cfg``  file
    >   It's the file which saves the boot configuration info. it allows to run different O.S setting which OS are available in the computer and the specific disk partitions of each one.

6.  How many files with ``gnu`` in its name are in ``/usr/src``
    >   0 using command find /usr/src/ -name *gnu

7.  How many files contain the word ``gpl`` inside in ``/usr/src``
    >   586 using command grep -H -R "gpl" /usr/src/ | wc -l

8.  What does the ``cut`` command do?
    >   It allows the user to process text info, extracting column/columns info

9.  What does the ``wget`` command do?
    >   It allows the user download files knowing the full http, https or ftp adress.

9.  What does the ``rsync`` command do?
    >   It is used to synchronize and/copy files local or to a sever.

10.  What does the ``diff`` command do?
    >   It's used to identifie the differneces between two differnet versions of the same file. (Usefull in Git)

10.  What does the ``tail`` command do?
    >   It will print the last n(default 10 but can be changed) lines of the file that enters as a paramete, whet more than a file enter, it will print the last 10 lines in the same order as the user set.

10.  What does the ``tail -f`` command do?
    >   When the file you want to analyze is changing with the time for example a log file that save the state of a program will change using this command the terminal will refresh in a set of time an display de last lines of the log.

10.  What does the ``link`` command do?
    >  It´s used to create like a direcvt acces, or like a pointer in C, it create a file that serves as a pointer to a file or directory in other direction inside the computer, it will always point to the file/directory.

11.  How many users exist in the course server?
    >  5 update 17/02

12. What command will produce a table of Users and Shells sorted by shell (tip: using ``cut`` and ``sort``)
    > cat /etc/passwd | sort

13. What command will produce the number of users with shell ``/sbin/nologin`` (tip: using ``grep`` and ``wc``)
    >  17 with command cat /etc/passwd | grep '/sbin/nologin'|wc -l

15. Create a script for finding duplicate images based on their content (tip: hash or checksum)
    You may look in the internet for ideas, but please indicate the source of any code you use
    Save this script as ``find_duplicates.sh`` in this directory and commit your changes to github

16. What is the meaning of ``#! /bin/bash`` at the start of scripts?
    >   It will difine how the following programm must be interpreted. In this case we want that the programm must the interpreted by the bash located in the directory /bin/bash

17. How many unique images are in the ``sipi_images`` database?
    >   0 files
    
