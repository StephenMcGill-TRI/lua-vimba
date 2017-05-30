.PHONY: all clean
OBJS=lua_vimba.o
TARGET=vimba.so

MOD_LIBS=-lVimbaC -lrt

all: $(TARGET)
	@echo --- build
	@echo CFLAGS: $(CFLAGS)
	@echo LIBFLAG: $(LIBFLAG)
	@echo LUA_LIBDIR: $(LUA_LIBDIR)
	@echo LUA_BINDIR: $(LUA_BINDIR)
	@echo LUA_INCDIR: $(LUA_INCDIR)

$(TARGET): $(OBJS)
	$(LD) $(LIBFLAG) -o $@ $(OBJS) -L$(LUA_LIBDIR) $(MOD_LIBS)

%.o: %.c
	# $(CC) -DENABLE_SHM -DDEBUG -c -o $@ $< -I$(LUA_INCDIR) $(CFLAGS)
	$(CC) -DENABLE_SHM -c -o $@ $< -I$(LUA_INCDIR) $(CFLAGS)

install: $(TARGET)
	@echo --- install
	@echo INST_PREFIX: $(INST_PREFIX)
	@echo INST_BINDIR: $(INST_BINDIR)
	@echo INST_LIBDIR: $(INST_LIBDIR)
	@echo INST_LUADIR: $(INST_LUADIR)
	@echo INST_CONFDIR: $(INST_CONFDIR)
	@echo Copying $< ...
	cp $< $(INST_LIBDIR)
	-rm -f $(OBJS)

clean:
	-rm -f $(OBJS)
	-rm -f $(TARGET)
