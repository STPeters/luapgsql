# makefile for pgsql library for Lua

# probably no need to change anything below here
CC= gcc
CFLAGS= $(INCS) $(WARN) -O2 $G -fPIC
WARN= -ansi -pedantic -Wall
INCS= `pkg-config --cflags lua5.1` -I`pg_config --includedir`
LIBS= `pkg-config --libs lua5.1` -L`pg_config --libdir` -lpq

MYNAME= pgsql
MYLIB= lua$(MYNAME)

OBJS= $(MYLIB).o
#STATIC_OBJS= foobar.o
T= $(MYNAME).so

all:	so

o:	$(MYLIB).o

so:	$T

$T:	$(OBJS)
	$(CC) -o $@ -shared $(OBJS) $(STATIC_OBJS) $(LIBS) 

clean:
	rm -f $(OBJS) $T core core.*

#doc:
#	@echo "$(MYNAME) library:"
#	@fgrep '/**' $(MYLIB).c | cut -f2 -d/ | tr -d '*' | sort | column

# distribution

D= $(MYNAME)
A= $(MYLIB).tgz
TOTAR= Makefile,$(MYLIB).c,test.lua

tar:	clean
	tar zcvf $A -C .. $D
#	tar zcvf $A -C .. $D/{$(TOTAR)}

distr:	tar
	touch -r $A .stamp

# eof
