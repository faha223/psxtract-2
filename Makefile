CC = gcc
CXX = g++

CFLAGS = -Wall -Wno-unused-variable

ifeq ($(DEBUG), 1)
CFLAGS+=-g -O0
else
CFLAGS+=-O2
endif

OBJDIR = obj
SRCDIR = src
BINDIR = bin
LIBKIRKOBJDIR = $(OBJDIR)/libkirk

TARGET1 = $(LIBKIRKOBJDIR)/libkirk.a
OBJS1 = $(LIBKIRKOBJDIR)/AES.o \
		$(LIBKIRKOBJDIR)/amctrl.o \
		$(LIBKIRKOBJDIR)/bn.o \
		$(LIBKIRKOBJDIR)/DES.o \
		$(LIBKIRKOBJDIR)/ec.o \
		$(LIBKIRKOBJDIR)/kirk_engine.o \
		$(LIBKIRKOBJDIR)/SHA1.o

TARGET2 = $(BINDIR)/psxtract
OBJS2 = $(OBJDIR)/cdrom.o \
		$(OBJDIR)/crypto.o \
		$(OBJDIR)/lz.o \
		$(OBJDIR)/psxtract.o \
		$(OBJDIR)/utils.o

$(LIBKIRKOBJDIR)/%.o: $(SRCDIR)/libkirk/%.c $(SRCDIR)/libkirk/%.h Makefile
	@$(CC) $(CFLAGS) -c $< -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.cpp $(SRCDIR)/%.h Makefile
	@$(CXX) $(CFLAGS) -c $< -o $@

all: $(TARGET1)

$(TARGET1): Makefile $(OBJS1)
	$(AR) rcs $@ $(OBJS1)

all: $(TARGET2)

$(TARGET2): Makefile $(OBJS2)
	$(CXX) $(CFLAGS) $(OBJS2) -o $(TARGET2) -L $(LIBKIRKOBJDIR) -lkirk

clean:
	rm -rf obj/*.o $(TARGET1) $(TARGET2)
