TARGETS := xas

C_CXX_FLAGS := -Wall -Wextra -Wpedantic
ifeq ($(shell uname -s),Linux)
C_CXX_FLAGS := $(C_CXX_FLAGS) -D_GNU_SOURCE
endif
C_CXX_FLAGS := $(C_CXX_FLAGS) -O0 -g
# C_CXX_FLAGS := $(C_CXX_FLAGS) -Os
CFLAGS := $(C_CXX_FLAGS) -std=gnu11

all: $(TARGETS)

.PHONY: clean compile_commands.json format

clean:
	rm -rf *.dSYM/
	rm -f $(TARGETS)

xas: xas.c insns.c insns.h regs.c regs.h deps/cbit/cbit/htab.h deps/cbit/cbit/misc.h deps/cbit/cbit/str.c deps/cbit/cbit/str.h deps/cbit/cbit/vec.c deps/cbit/cbit/vec.h
	$(CC) -o $@ xas.c -I deps/cbit deps/cbit/cbit/str.c deps/cbit/cbit/vec.c $(CFLAGS)

compile_commands.json:
	bear -- $(MAKE) -B -f $(MAKEFILE_LIST)
