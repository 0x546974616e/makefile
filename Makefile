# :set noexpandtab

BIN = main

CSRC = $(wildcard *.c)
COBJ = $(CSRC:.c=.o)
CDEP = $(CSRC:.c=.d)

CC = gcc

CFLAGS = \
	-Wall \
	-Wextra \
	-Wconversion \
	-Werror \
	-ansi \
	-pedantic

CDEPS = -MMD -MP -MT $@ -MF $(@:.o=.d)

LDFLAGS =

.PHONY : all clean cleanall mrproper run

all : $(BIN)
	@echo "-->" ./$(notdir $<)

$(BIN) : $(COBJ)
	@echo Generating Code...
	@$(CC) $^ -o $@ $(LDFLAGS)

%.o : %.c
	@echo $(notdir $<)
	@$(CC) -c $< -o $@ $(CFLAGS) $(CDEPS)

-include $(CDEP)

clean :
	@rm -f $(COBJ)

cleanall : clean
	@rm -f $(CDEP)

mrproper : cleanall
	@rm -f $(BIN)

run :
	@./$(BIN)

