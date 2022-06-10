/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static int centered = 0;                    /* -c option; centers dmenu on screen */
static int min_width = 960;                    /* minimum width when centered */
static int colorprompt = 1;                /* -p  option; if 1, prompt uses SchemeSel, otherwise SchemeNorm */
static int fuzzy = 0;                      /* -F  option; if 0, dmenu doesn't use fuzzy matching     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"FantasqueSansMono Nerd Font:size=10",
    "JoyPixels:size=10:antialias=true:hinting=true"
};
static const unsigned int bgalpha = 0xb0;
static const unsigned int fgalpha = OPAQUE;
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { "#2a2a2a", "#e0e0e0"},
	[SchemeSel] = { "#484848", "#0184bc" },
	[SchemeSelHighlight] = { "#f3ce84", "#ba68c8" },
	[SchemeNormHighlight] = { "#282828", "#9e4e85" },
	[SchemeOut] = { "#1b1c21", "#4b5617" },
	[SchemeHp] = { "#e45649", "#909090" }
};
static const unsigned int alphas[SchemeLast][2] = {
	/*		fgalpha		bgalphga	*/
	[SchemeNorm] = { fgalpha, bgalpha },
	[SchemeSel] = { fgalpha, bgalpha },
	[SchemeSelHighlight] = { fgalpha, bgalpha },
	[SchemeNormHighlight] = { fgalpha, bgalpha },
	[SchemeOut] = { fgalpha, bgalpha },
	[SchemeHp] = { fgalpha, bgalpha }
};

/* -l and -g options; controls number of lines and columns in grid if > 0 */
static unsigned int lines      = 0;
static unsigned int columns    = 0;
/* -h option; minimum height of a menu line */
static unsigned int lineheight = 36;
static unsigned int min_lineheight = 36;
static unsigned int xoffset = 6;
static unsigned int yoffset = 4;
/*static unsigned int yoffset = 0; */
static unsigned int width = 3810;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static unsigned int border_width = 0;
