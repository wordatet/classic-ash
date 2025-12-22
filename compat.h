/* Portability compatibility header for 4.4BSD-Lite2 sh port */
#ifndef COMPAT_H
#define COMPAT_H

#if defined(__linux__) || defined(__GLIBC__)
#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif
#endif

#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <stdint.h>
#include <fcntl.h>

/* Handle BSD-specific macros */
#ifndef __P
#if defined(__STDC__) || defined(__cplusplus)
#define __P(protos) protos
#else
#define __P(protos) ()
#endif
#endif

#ifndef __BEGIN_DECLS
#if defined(__cplusplus)
#define __BEGIN_DECLS extern "C" {
#define __END_DECLS }
#else
#define __BEGIN_DECLS
#define __END_DECLS
#endif
#endif

/* Standardize naming for internal symbols if needed */

/* Map BSD signal functions to POSIX if missing */
#ifndef sigblock
#define sigblock(m) (0) /* Placeholder */
#endif

/* Portability helpers */
#define sys_siglist_at(sig) strsignal(sig)
#define NSIG_VAL NSIG

#if defined(__linux__)
#include <bsd/unistd.h>
#endif

#endif /* COMPAT_H */
