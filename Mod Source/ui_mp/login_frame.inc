

		// background
		itemDef 
		{
			//rect			80 90 480 420
			rect			150 160 340 180
			style			WINDOW_STYLE_SHADER
			background		"virus_bg"
			border			1
			//bordercolor		0 0 0 1
			bordercolor		0 0.600 1 1
			visible			1
			decoration
		}

		// menu name
		itemDef
		{
			visible			1 //when( !menuisopen( "team_select" ) )
			origin			160 185
			forecolor		1 1 1 1
			exp				text( dvarString( "menuName" ) )
			textfont		UI_FONT_NORMAL
			textalign		ITEM_ALIGN_LEFT
			textscale		0.4
			decoration
		}

