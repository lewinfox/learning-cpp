# Makefile template from https://hiltmon.com/blog/2013/07/03/a-simple-c-plus-plus-project-structure/

# We can change the .RECIPEPREFIX from the default tab
.RECIPEPREFIX := >

CC := g++ # This is the main compiler
# CC := clang --analyze # and comment out the linker last line for sanity
SRCDIR := src
BINDIR := bin
BUILDDIR := build
TARGET := $(BINDIR)/runner

SRCEXT := cpp
SOURCES := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.o))
CFLAGS := -g # -Wall  # The -g asks the compiler to retain some source level information (e.g. variable names) in the executable so in a crash debugging will be easier.
# LIB := -pthread -lmongoclient -L lib -lboost_thread-mt -lboost_filesystem-mt -lboost_system-mt  # Libraries to include
INC := -I include  # Include dir

# The final binary depends on the object files
$(TARGET): $(OBJECTS)
> @echo " Linking..."
> @mkdir -p $(BINDIR)
> @echo " $(CC) $^ -o $(TARGET) $(LIB)"; $(CC) $^ -o $(TARGET) $(LIB)

# The object files depend on the source files
$(BUILDDIR)/%.o: $(SRCDIR)/%.$(SRCEXT)
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

# Run
# Similar to Rust's `cargo run` - rebuilds the binary and runs it.
run: $(TARGET)
> @echo " ./$(TARGET)"; ./$(TARGET)

# .PHONY means that "clean" is not a compilation target but a command.
# Usually `make clean` means "check if the file `clean` is up to date and
# rebuild it using this recipe if it isn't. Make will consider all .PHONY
# targets to be out of date so this code will always be executed.
.PHONY: clean
.PHONY: run
