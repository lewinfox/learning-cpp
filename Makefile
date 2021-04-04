# Makefile template from https://hiltmon.com/blog/2013/07/03/a-simple-c-plus-plus-project-structure/

# First change the fucking recipe prefix
.RECIPEPREFIX := >

CC := g++ # This is the main compiler
# CC := clang --analyze # and comment out the linker last line for sanity
SRCDIR := src
INCLUDEDIR := include
BINDIR := bin
BUILDDIR := build
TARGET := $(BINDIR)/runner

SRCEXT := cpp
HEADEREXT := hpp
SOURCES := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
HEADERS := $(shell find $(INCLUDEDIR) -type f -name *.$(HEADEREXT))
OBJECTS := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.o))
CFLAGS := -g # -Wall  # The -g asks the compiler to retain some source level information (e.g. variable names) in the executable so in a crash debugging will be easier.
# LIB := -pthread -lmongoclient -L lib -lboost_thread-mt -lboost_filesystem-mt -lboost_system-mt  # Libraries to include
INC := -I include  # Include dir

# The final binary depends on the object files
$(TARGET): $(OBJECTS)
> @echo " Linking..."
> @mkdir -p bin
> @echo " $(CC) $^ -o $(TARGET) $(LIB)"; $(CC) $^ -o $(TARGET) $(LIB)

# The object files depend on the source and header files
$(BUILDDIR)/%.o: $(SOURCES) $(HEADERS)
> @mkdir -p $(BUILDDIR)
> @echo " $(CC) $(CFLAGS) $(INC) -c -o $@ $<"; $(CC) $(CFLAGS) $(INC) -c -o $@ $<

# Running `make clean` runs this to tidy things up
clean:
> @echo " Cleaning...";
> @echo " $(RM) -r $(BUILDDIR) $(TARGET)"; $(RM) -r $(BUILDDIR) $(TARGET)

# Tests
tester:
> $(CC) $(CFLAGS) test/tester.cpp $(INC) $(LIB) -o bin/tester

# Spikes
ticket:
> $(CC) $(CFLAGS) spikes/ticket.cpp $(INC) $(LIB) -o bin/ticket

# Run the binary
run: $(TARGET) $(OBJECTS) $(SOURCES)
> @echo "---- Running ./$(TARGET) ----"; ./$(TARGET)

# .PHONY means that "clean" is not a compilation target but a command.
# Usually `make clean` means "check if the file `clean` is up to date and
# rebuild it using this recipe if it isn't. Make will consider all .PHONY
# targets to be out of date so this code will always be executed.
.PHONY: clean run
