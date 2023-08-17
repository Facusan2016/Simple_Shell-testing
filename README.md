# Simple_Shell-testing
## Description 

Simple_Shell Testing is a program designed to test the output of the Simple_Shell project executable and the Bourne Shell.
It also runs valgrind to check for memory leaks. The program includes an initial folder named "test," where you will find
the tests that are used for both programs in non-interactive mode. Additionally, there is a mock executable named "fake_exec"
in the same directory.

## Installation and Usage

Follow these steps to install and use Simple_Shell Testing:
1. Clone this repository to your local machine using the following command: `git clone https://github.com/Facusan2016/Simple_Shell-testing`.
2. Modify the HSH_PATH variable in the Makefile to point to the location of your executable. The default reference for this executable is ./hsh.
3. The Makefile provides three different instructions, each of which creates the necessary directories first:
   - `make testing`: Run the tests and print "OK" if they succeed or "KO" if they fail.
   - `make valgrind`: Run the tests using Valgrind and print "OK" if there are no memory leaks, or "KO" if memory leaks are detected.
   - `make clean`: Remove all files within the diff, hsh_out, and sh_out folders.

Please note that it's essential to have Valgrind installed on your local machine to use this program effectively.  

After running `make testing` or `make valgrind`, several directories will be created:
  - `diff`: This directory contains the differences between the output of each program, if any exist.
  - `hsh_out`: In this directory, you can find the output of the hsh program.
  - `sh_out`: In this directory, you can find the output of the sh (Bourne Shell) program.

## Errors
When attempting to test by passing a non-existent executable name, the output of each program will differ as they print different errors.
The correct way to print errors, following the original problem statement, is to display the same output as in bash, with the only change being the program name replaced by argv[0].

Another error is that sometimes Valgrind tests fail and show memory leaks, even though when they are run using cat "file" | ./hsh, there are no memory leaks.

## Author
This project was created by Facundo Sánchez.

