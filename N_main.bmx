AppTitle = "NOVUS"

Include "N_AI.bmx"
Include "N_loadimages.bmx"
Include "N_drawimages.bmx"
Include "N_player.bmx"
Include "N_enemies.bmx"

Global sW = 800, sH = 600
Global UserQuit = False
Global Screen = -1
Global ScreenChange = -1
Global PauseAll = False

Graphics sW, sH
HideMouse()
SeedRnd( MilliSecs() )
SetBlend( ALPHABLEND )

LoadAllImages( 0 )

CreateAllLists( 0 )

MoveMouse( 400, 300 )

Screen = 0


Repeat

If Grabbing = True Then

	pm_Grab1 = GrabPixmap( 0, 0, sW, sH )
	SavePixmapPNG( pm_Grab1, "Data\Images\Grab1.png" )
	'pm_Grab2 = GrabPixmap( 0, 0, sW, sH )
	'SavePixmapPNG( pm_Grab2, "Data\Images\Grab2.png" )

	img_Grab1 = LoadImage( "Data\Images\Grab1.png" )
	MidHandleImage( img_Grab1 )
	'img_Grab2 = LoadImage( "Data\Images\Grab2.png" )
	'MidHandleImage( img_Grab2 )

	DrawGrab = True
	DrawGrab2 = True
	DrawBlack = True
	GrabChange = True
	Grabbing = False

EndIf

Cls
ResetCollisions()

If Pause = False Then

	Select Screen
	Case 0
	
	UpdateBackgrounds( 0 )
	UpdateAllAI( 0 )
	DrawAllImages( 0 )
	If KeyHit( key_escape ) Then UserQuit = True
	
	Case 1
	
	UpdateBackgrounds( 1 )
	UpdateAllAI( 1 )
	UpdatePlayer()
	DrawAllImages( 1 )
	If KeyHit( key_escape ) Then ScreenChange = 0

	EndSelect

EndIf

	Select ScreenChange
	Case 0

	PauseAll = True
	If GrabChange = False Then Grabbing = True
	
	If GrabChange = True Then
		Grab1Scale:- 0.05
		Grab1Alpha:- 0.05
		Grab2Scale:+ 0.05
		Grab2Alpha:- 0.05
		If Grab1Alpha < 0 Then
			Cls
			FreeAllRes( 1 )
			LoadAllImages( 0 )
			CreateAllLists( 0 )
			FlushKeys()
			FlushMouse()
			Grab1Scale = 1
			Grab1Alpha = 1
			Grab2Scale = 1
			Grab2Alpha = 1
			DrawGrab = False
			'DrawGrab2 = False
			GrabChange = False
			BlackChange = True
			ResetVariables( 0 )
			Screen = 0
			PauseAll = False
			ScreenChange = -1
			Cls
		EndIf
	EndIf
	
	Case 1

	PauseAll = True
	If GrabChange = False Then Grabbing = True

	If GrabChange = True Then
		Grab1Scale:- 0.05
		Grab1Alpha:- 0.05
		Grab2Scale:+ 0.05
		Grab2Alpha:- 0.05
		If Grab1Alpha < 0 Then
			Cls
			FreeAllRes( 0 )
			LoadAllImages( 1 )
			CreateAllLists( 1 )
			FlushKeys()
			FlushMouse()
			Grab1Scale = 1
			Grab1Alpha = 1
			Grab2Scale = 1
			Grab2Alpha = 1
			DrawGrab = False
			'DrawGrab2 = False
			GrabChange = False
			BlackChange = True
			ResetVariables( 1 )
			Screen = 1
			PauseAll = False
			ScreenChange = -1
			Cls
		EndIf
	EndIf

	EndSelect

	If BlackChange = True Then

		BlackAlpha:- 0.05
		If BlackAlpha <= 0 Then
			BlackAlpha = 1
			DrawBlack = False
			BlackChange = False
		EndIf

	EndIf

	If DrawBlack = True Then

		SetColor( 0, 0, 0 )
		SetAlpha( BlackAlpha )
		DrawRect( 0, 0, 800, 600 )
		SetAlpha( 1 )
		SetColor( 255, 255, 255 )
	
	EndIf

	If DrawGrab = True Then

		SetScale( Grab1Scale, Grab1Scale )
		SetAlpha( Grab1Alpha )
		DrawImage( img_Grab1, 400, 300 )
		SetScale( Grab2Scale, Grab2Scale )
		SetAlpha( Grab2Alpha )
		DrawImage( img_Grab1, 400, 300 )
		SetScale( 1, 1 )
		SetAlpha( 1 )

	EndIf

	DrawText( plr_coeff_Weapon1Y, 10, 10 )
	DrawText( plr_coeff_Weapon2Y, 10, 30 )
	' DrawText( plr_Weapon2X + "x" + plr_Weapon2Y, 10, 50 )
	' DrawText( plr_WeaponChange, 10, 70 )

	' DrawText( plr_Life, 10, 10 )
	' DrawText( timer_LevelTime_Seconds, 10, 30 )

Flip

Until ( UserQuit = True ) Or ( AppTerminate() )