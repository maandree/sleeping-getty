.POSIX:

CONFIGFILE = config.mk
include $(CONFIGFILE)

all: sleeping-getty

sleeping-getty: sleeping-getty.o
	$(CC) -o $@ sleeping-getty.o $(LDFLAGS)

install: sleeping-getty
	mkdir -p -- "$(DESTDIR)$(PREFIX)/sbin"
	mkdir -p -- "$(DESTDIR)$(MANPREFIX)/man8"
	mkdir -p -- "$(DESTDIR)$(PREFIX)/share/licenses/sleeping-getty"
	cp -- sleeping-getty "$(DESTDIR)$(PREFIX)/sbin/"
	cp -- sleeping-getty.8 "$(DESTDIR)$(MANPREFIX)/man8/"
	cp -- LICENSE "$(DESTDIR)$(PREFIX)/share/licenses/sleeping-getty/"

uninstall:
	-rm -f -- "$(DESTDIR)$(PREFIX)/sbin/sleeping-getty"
	-rm -f -- "$(DESTDIR)$(MANPREFIX)/man8/sleeping-getty.8"
	-rm -rf -- "$(DESTDIR)$(PREFIX)/share/licenses/sleeping-getty"

clean:
	-rm -f -- sleeping-getty *.o

.SUFFIXES:
.SUFFIXES: .o .c

.PHONY: all install uninstall clean
