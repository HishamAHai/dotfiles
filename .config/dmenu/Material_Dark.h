static const unsigned int bgalpha = 0xf2;
/*static const unsigned int bgalpha = 0xff;*/
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { "#e4e4e4", "#222221"},
	[SchemeSel] = { "#fee92e", "#424242" },
	[SchemeSelHighlight] = { "#550087", "#134eb2" },
	[SchemeNormHighlight] = { "#b7141e", "#222221" },
	[SchemeOut] = { "#222221", "#7aba39" },
	[SchemeHp] = { "#b7141e", "#424242" }
};
