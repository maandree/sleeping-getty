.POSIX:

CONFIGFILE = config.mk
include $(CONFIGFILE)


all: sleeping-getty

.c.o:
	$(CC) -c -o $@ $< $(CFLAGS) $(CPPFLAGS)

sleeping-getty: sleeping-getty.o
	$(CC) -o $@ sleeping-getty.o $(LDFLAGS)

install: sleeping-getty
	mkdir -p -- "$(DESTDIR)$(PREFIX)/sbin"
	mkdir -p -- "$(DESTDIR)$(MANPREFIX)/man8"
	cp -- sleeping-getty "$(DESTDIR)$(PREFIX)/sbin/"
	cp -- sleeping-getty.8 "$(DESTDIR)$(MANPREFIX)/man8/"

uninstall:
	-rm -f -- "$(DESTDIR)$(PREFIX)/sbin/sleeping-getty"
	-rm -f -- "$(DESTDIR)$(MANPREFIX)/man8/sleeping-getty.8"

clean:
	-rm -f -- sleeping-getty *.o *.su

.SUFFIXES:
.SUFFIXES: .o .c

.PHONY: all install uninstall clean
