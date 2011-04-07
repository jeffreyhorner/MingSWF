AC_INIT(MingSWF, 0.1-1, jeff.horner@vanderbilt.edu)

AC_PATH_PROG([MCONFIG],[ming-config],[no])
if test "$MCONFIG" = "no"; then
	echo
	echo "Cannot find the ming-config build tool."
	echo
	AC_MSG_ERROR( aborting! )
fi

MCFLAGS=`$MCONFIG --cflags`
MLDFLAGS=`$MCONFIG --libs`

AC_SUBST(MCFLAGS)
AC_SUBST(MLDFLAGS)

AC_CONFIG_FILES([src/Makevars])
AC_OUTPUT
