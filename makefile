# A Makefile for Program 1, CS570

PROGRAM = p1
# comment out the following definition of CC to regain the default cc compiler
CC = gcc
CFLAGS = -g
# note that the declarations in getword.h must be changed if cc is used.

# invoking 'make clean' would try to create the 'clean' target, which doesn't
# actually create anything; it instead removes all transitory files (as
# specified in the last stanza of this file).
#
# 'make' (with no parameters) makes the FIRST target (which in this case
# is equivalent to 'make p1', due to the definition of PROGRAM above).

${PROGRAM}:	getword.o p1.o
		${CC} -o p1 getword.o p1.o
# the action on the above line call gcc (actually, it calls the linker, since
# we are dealing with .o object modules), links them, and renames a.out to p1 .
# The make program first checks if the two files getword.o and p1.o are up to
# date (that is, if their time stamps are younger than getword.c and p1.c,
# respectively).  If (say) p1.o is not up to date, then make looks for guidance
about how to create p1.o, which is listed below:

p1.o:		getword.h

# p1.c could be listed as a dependency above, but 'make' is smart enough to know
# that p1.o depends on p1.c, so we don't really have to list it.
# Why is no target listed below it?  Because 'make' is smart enough to know
# how to create a .o file from a .c file.  In particular, it does:
# $(CC) -c $(CFLAGS) $(CPPFLAGS) -o $@ $<
# which resolves to:
# gcc -c -g -o p1.o p1.c
# (We earlier set CFLAGS to -g, so that the symbol table will be preserved;
# this is useful if we want to use a debugger such as dbx or gdb.)

getword.o:	getword.h

# the dependency line of both the .o targets need to list "getword.h", since
# both .c files #include the getword.h definitions.  For example, if we
# were to change the STORAGE constant to something other than 255, the .o files
# would not magically know that this was changed, unless the .c files were
# recompiled.  This is how we tell 'make' that it should consider the .o files
# out of date if the .h file has been updated.  (That is, 'make' is smart enough
# to know that p1.o depends on p1.c, but there's no easy way for it to figure
# out that p1.c also depends on getword.h -- so we have to explicitly say so.

clean:
		rm -f *.o ${PROGRAM}

lint:
		lint getword.c ${PROGRAM}.c
