#include "R_stors.h"


#ifndef SEXP_H
#define SEXP_H

SEXP srexp(SEXP s_size, SEXP Rpassed_params);
SEXP srexp_trunc_nav(SEXP Rlx, SEXP Rrx, SEXP Rgrid_number);
SEXP srexp_trunc(SEXP s_size, SEXP Rxl, SEXP Rxr , SEXP Rcsl, SEXP Rcsr,  SEXP Ril, SEXP Rir, SEXP Rgrid_number);

#endif


