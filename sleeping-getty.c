/* See LICENSE file for copyright and license details. */
#include <linux/vt.h>
#include <ctype.h>
#include <errno.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stropts.h>
#include <unistd.h>

static char *argv0;

static void
usage(void)
{
	fprintf(stderr, "usage: %s vtno getty-command [arguments] ...\n", argv0);
	exit(1);
}

int
main(int argc, char *argv[])
{
	struct vt_stat state;
	long int tmp;
	int tty;
	char *end;

	argv0 = argv[0];
	if (argc < 3)
		usage();

	if (!isdigit(argv[1][0]))
		usage();
	errno = 0;
	tmp = strtol(argv[1], &end, 10);
	if (errno || *end || tmp < 0 || tmp > INT_MAX)
		usage();
	tty = (int)tmp;

	if (!ioctl(STDIN_FILENO, (long)VT_GETSTATE, &state))
		if (state.v_active != tty)
			ioctl(STDIN_FILENO, (long)VT_WAITACTIVE, tty);

	execvp(argv[2], &argv[2]);
	fprintf(stderr, "%s: execvp %s: %s\n", argv0, argv[2], strerror(errno));
	return 1;
}
