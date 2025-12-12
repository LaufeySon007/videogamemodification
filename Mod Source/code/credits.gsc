main()
{
	wait 9;
	level.creditTime = 10;

	x = (1+randomInt(11));
	ambientPlay( "endgame1" +x );


	thread showCredit( "^0Once you have accepted your Flaws", 2.4 );
	wait 0.5;
	thread showCredit( "^3No one can use them against YOU", 2.4 );
	
	wait 1.2;
	thread showCredit( "^4Server Owners", 2.0 );
	wait 0.5;
	thread showCredit( "^2|P|^0>^2|^0MR^3_^0Sr<3^2| and ^2|P|^0>^2|^0K@SH^3miri", 2.4 );
	
	wait 1.2;
	thread showCredit( "^4Modded By:", 2.0 );
	wait 0.5;
	thread showCredit( "^0NUS^3[T]^0IAN", 2.4 );
	
	wait 1.2;
	thread showCredit( "^4Super Admin:", 2.0 );
	wait 0.5;
	thread showCredit( "^2|P|^0>^2|^0Aw@!s!>^2|", 2.4 );	
		
	wait 1.2;
	thread showCredit( "^0Thanks For Playing !", 2.4 );
	wait 0.5;
	thread showCredit( "^3Hope you found your stay well worth your time !", 1.8 );
	/*thread showCredit( "Hosted Through:", 1.8 );z
	wait 10;
	wait 0.5;*/
	//thread code\_mapvote::Initialize();
}


showCredit( text, scale )
{
	end_text = newHudElem();
	end_text.font = "objective";
	end_text.fontScale = scale;
	end_text SetText(text);
	end_text.alignX = "center";
	end_text.alignY = "top";
	end_text.horzAlign = "center";
	end_text.vertAlign = "top";
	end_text.x = 0;
	end_text.y = 540;
	end_text.sort = -1; //-3
	end_text.alpha = 1;
	//end_text.glowColor = (.1,.4,0);
	//end_text.glowAlpha = 1;
	end_text moveOverTime(level.creditTime);
	end_text.y = -60;
	end_text.foreground = true;
	wait level.creditTime;
	end_text destroy();
}


neon()
{
	neon = addNeon( "^1", 1.4 );
	while( 1 )
	{
		neon moveOverTime( 15 );
		neon.x = 800;
		wait 15;
		neon moveOverTime( 15 );
		neon.x = -800;
		wait 15;
	}
}

addNeon( text, scale )
{
	end_text = newHudElem();
	end_text.font = "objective";
	end_text.fontScale = scale;
	end_text SetText(text);
	end_text.alignX = "center";
	end_text.alignY = "top";
	end_text.horzAlign = "center";
	end_text.vertAlign = "top";
	end_text.x = -200;
	end_text.y = 8;
	end_text.sort = -1; //-3
	end_text.alpha = 1;
	//end_text.glowColor = (1,0,0.1);
	//end_text.glowAlpha = 1;
	end_text.foreground = true;
	return end_text;
}
spect()
{
self.sessionteam = "spectator";
self.sessionstate = "spectator";
self [[level.spawnSpectator]]();
}