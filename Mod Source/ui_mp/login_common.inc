#define TEXT_FIELD( ID, x, y, variable, txt ) \
itemDef \
{ \
	visible			1 \
	origin			(x+55) (y-2) \
	forecolor		1 1 1 1 \
	exp				text( txt ) \
	textfont		UI_FONT_NORMAL \
	textalign		ITEM_ALIGN_RIGHT \
	textscale		0.4 \
	decoration \
} \
itemDef \
{ \
	name			"login" \
	visible			1 \
	rect			(x+65) (y-20) 240 20 0 0 \
	text			" " \
	type			ITEM_TYPE_EDITFIELD \
	textstyle		ITEM_TEXTSTYLE_SHADOWED \
	textscale		0.3 \
	dvar			variable \
	forecolor		1 1 1 1 \
	style			WINDOW_STYLE_SHADER \
	background		BLACK \
	textalign		ITEM_ALIGN_MIDDLE_LEFT \
} \
itemDef \
{ \
	visible			1 \
	origin			163 225 \
	forecolor		1 1 1 1 \
	exp				text("Log in using following prefix: USERNAME:PASSWORD") \
	textfont		UI_FONT_NORMAL \
	textalign		ITEM_ALIGN_LEFT \
	textscale		0.4 \
	decoration \
} \
itemDef \
{ \
	visible			1 \
	origin			280 278 \
	forecolor		1 1 1 1 \
	exp				text( dvarString( "login_state" ) ) \
	textfont		UI_FONT_NORMAL \
	textalign		ITEM_ALIGN_LEFT \
	textscale		0.4 \
	decoration \
} 
//CHOICE_SCRIPTS_ACTION( ID, 0 ) \