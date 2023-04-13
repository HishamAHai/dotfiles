/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static const unsigned int alpha = 0xb4;     /* Amount of opacity. 0xff is opaque             */
static const int user_bh = 4;               /* add an defined amount of pixels to the bar height */
static int colorprompt = 1;                /* -p  option; if 1, prompt uses SchemeSel, otherwise SchemeNorm */
static int centered = 0;                    /* -c option; centers dmenu on screen */
static int min_width = 500;                    /* minimum width when centered */
static int fuzzy = 1;                      /* -F  option; if 0, dmenu doesn't use fuzzy matching     */

/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"FantasqueSansMono Nerd Font:size=12",
    "Noto Color Emoji:size=11:antialias=true:hinting=true"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */

#include "Material_Dark.h" /* ColorScheme to be used */
static const unsigned int alphas[SchemeLast][2] = {
	[SchemeNorm] = { OPAQUE, alpha },
	[SchemeSel] = { OPAQUE, alpha },
	[SchemeSelHighlight] = { OPAQUE, alpha },
	[SchemeNormHighlight] = { OPAQUE, alpha },
	[SchemeOut] = { OPAQUE, alpha },
	[SchemeHp]  = { OPAQUE, alpha }
};
/* -l and -g options; controls number of lines and columns in grid if > 0 */
static unsigned int lines      = 0;
static unsigned int columns    = 0;
/* -h option; minimum height of a menu line */
static unsigned int lineheight = 40;
static unsigned int min_lineheight = 8;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static unsigned int border_width = 0;
