#include "snorm.h"
#include "macro_var.h"

#define NAME srnorm

#define CNUM 1

#define L_TAIL ARS

#define R_TAIL ARS

// #define L_ITF(u)(log(2*u))

// #define R_ITF(u)(-log(2 - 2 * u))

#define F(sample)(0.3989423 * exp(-0.5 * sample * sample))

// =================================

#include "stors_sample.c"

// =================================

#include "stors_trunc_nav.c"

// =================================


#include "stors_sample_trunc.c"


// =================================


#undef CNUM

#undef L_TAIL

#undef R_TAIL
