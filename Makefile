# Portable Makefile for 4.4BSD-Lite2 sh
CROSS_COMPILE ?= 
HOSTCC ?= gcc
CC = $(CROSS_COMPILE)gcc
CFLAGS ?= -O2 -g
CFLAGS += -DSHELL -I. -include compat.h

# Libraries
LIBS = -ledit -lbsd

# Source paths
VPATH = bltin:../../usr.bin/printf

SRCS = alias.c builtins.c cd.c echo.c error.c eval.c exec.c expand.c \
       histedit.c input.c jobs.c mail.c main.c memalloc.c miscbltin.c \
       mystring.c nodes.c options.c parser.c redir.c show.c syntax.c \
       trap.c output.c var.c init.c
OBJS = $(SRCS:.c=.o) arith.o arith_lex.o

GENSRCS = builtins.c builtins.h init.c nodes.c nodes.h syntax.c syntax.h token.def arith.c arith.h arith_lex.c
# Note: mkbuiltins and mktokens are scripts, do not delete them!
GENPROGS = mkinit mknodes mksyntax

# Files for mkinit to scan
INIT_SRCS = alias.c cd.c echo.c error.c eval.c exec.c expand.c \
            histedit.c input.c jobs.c mail.c main.c memalloc.c \
            miscbltin.c mystring.c nodes.c options.c parser.c \
            redir.c show.c trap.c output.c var.c

.PHONY: all clean

all: sh

sh: $(GENSRCS) $(OBJS)
	$(CC) $(CFLAGS) -o sh $(OBJS) $(LIBS)

# Code Generators (Host tools)
mkinit: mkinit.c
	$(HOSTCC) $(CFLAGS) mkinit.c -o mkinit

mknodes: mknodes.c
	$(HOSTCC) $(CFLAGS) mknodes.c -o mknodes

mksyntax: mksyntax.c
	$(HOSTCC) $(CFLAGS) mksyntax.c -o mksyntax

# Generation Rules
token.def: mktokens
	sh ./mktokens

builtins.h builtins.c: mkbuiltins builtins.def shell.h
	sh ./mkbuiltins .

init.c: mkinit $(INIT_SRCS)
	./mkinit '$(CC) -c $(CFLAGS) init.c' $(foreach f,$(INIT_SRCS),$(firstword $(wildcard $f bltin/$f)))

# Add dependencies for objects needing generated headers
expand.o: arith.h
parser.o: nodes.h token.def
builtins.o: builtins.h

nodes.c nodes.h: mknodes nodetypes nodes.c.pat
	./mknodes nodetypes nodes.c.pat

syntax.c syntax.h: mksyntax
	./mksyntax

# Arithmetic (Lex/Yacc)
arith.c arith.h: arith.y
	yacc -d arith.y
	mv y.tab.c arith.c
	mv y.tab.h arith.h

arith_lex.c: arith_lex.l
	lex -t arith_lex.l > arith_lex.c

.c.o:
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f $(OBJS) sh $(GENSRCS) $(GENPROGS) arith.c arith.h arith_lex.c init.c.new
