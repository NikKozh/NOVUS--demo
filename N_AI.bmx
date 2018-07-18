Type TBullet

	Field link:TLink
	Field X#, Y#
	Field Speed#
	
	Method Remove()
		link.remove
	EndMethod

	Method AddLast( list:TList )
		link = list.AddLast( Self )
	EndMethod
	
	Method Update()
	
		If Y < -50 Then Remove

		X:+ Speed * Cos( 270 )
		Y:+ Speed * Sin( 270 )
		
		TClonBullet.CreateClonBullet( X, Y )
		
		If ( x < -50 ) Or ( x > sW + 50 ) Or ( y < -50 ) Or ( y > sH + 50 ) Then

			link.remove
			Return
		
		EndIf

	EndMethod
	
	Function CreateBullet:TBullet( x#, y#, speed# )

		Local Bullet:TBullet = New TBullet
		Bullet.X = x
		Bullet.Y = y
		Bullet.Speed = speed
		Bullet.AddLast( list_Bullets )
		Return Bullet

	EndFunction

EndType

Type TClonBullet

	Field link:TLink
	Field X#, Y#
	Field Alpha#
	
	Method Remove()
		link.remove
	EndMethod
	
	Method AddLast( list:TList )
		link = list.AddLast( Self )
	EndMethod
	
	Method Update()

		Alpha:- 0.15
		If Alpha <= 0 Then
			Remove
			' CurrentClones:- 1
		EndIf

	EndMethod
	
	Function CreateClonBullet:TClonBullet( x#, y# )

		Local ClonBullet:TClonBullet = New TClonBullet
		ClonBullet.X = x
		ClonBullet.Y = y
		ClonBullet.Alpha = 1
		ClonBullet.AddLast( list_ClonBullets )
		Return ClonBullet

	EndFunction

EndType

'__________________________________________________________

Global DrawScreenChange1 = False, DrawScreenChange2 = False
Global ScreenChange1X# = -400, ScreenChange1Y# = 900
Global ScreenChange2X# = 1200, ScreenChange2Y# = -300

Global DrawGrab = False, DrawGrab2 = False
Global Grabbing = False
Global GrabChange = False
Global Grab1Scale# = 1, Grab1Alpha# = 1
Global Grab2Scale# = 1, Grab2Alpha# = 1

Global DrawBlack = False
Global BlackChange = False
Global BlackAlpha# = 1

'__________________________________________________________

'----------------------------------

Global timer_Enemies
Global timer_LevelTime_Frames
Global timer_LevelTime_Seconds

Global list_Bullets:TList
Global list_ClonBullets:TList

Global CurrentClones
Global Bg1_downY = 600, Bg1_upY = 0

Global DrawLaser1 = False
Global Laser1Frame, Laser1Animnext

'----------------------------------

Global acc_MBg1Scale#

Global MBg1_scaleX# = 1, MBg1_scaleY# = 1, MBg1_ScaleChange, MBg1_accScaleChange

Global DrawNG1 = False, DrawNG2 = True, DrawNG3 = True, DrawNG4 = False
Global NG3_Alpha#
Global NG_ScaleX# = 0.8, NG_ScaleY# = 0.8, NG_Scale# = 0.8

Global DrawC1 = False, DrawC2 = True, DrawC3 = True, DrawC4 = False
Global C3_Alpha#
Global C_ScaleX# = 0.8, C_ScaleY# = 0.8, C_Scale# = 0.8

Global DrawQ1 = False, DrawQ2 = True, DrawQ3 = True, DrawQ4 = False
Global Q3_Alpha#
Global Q_ScaleX# = 0.8, Q_ScaleY# = 0.8, Q_Scale# = 0.8

Global DrawA1 = False, DrawA2 = True, DrawA3 = True, DrawA4 = False
Global A3_Alpha#
Global A_ScaleX# = 0.8, A_ScaleY# = 0.8, A_Scale# = 0.8


Function UpdateLevelAI()

	timer_LevelTime_Frames:+ 1
	If timer_LevelTime_Frames = 60 Then

		timer_LevelTime_Seconds:+ 1
		timer_LevelTime_Frames = 0

	EndIf

	If timer_Enemies <> 0 Then timer_Enemies:- 1
	
	If timer_Enemies = 0 Then
	
		TEnemy.CreateEnemy( Rand( 50, 750 ), -20, 5, 5 )
		TEnemy.CreateEnemy( Rand( 50, 750 ), -20, 5, 5 )
		timer_Enemies = Rand( 60, 120 )
	
	EndIf

EndFunction

Function CreateAllLists( screen# )

	Select screen
	Case 1

	list_Bullets = New TList
	list_ClonBullets = New TList
	list_Enemies = New TList
	list_ClonEnemies = New TList
	list_PartEnemies = New TList
	list_PlayerClones = New TList

	EndSelect

EndFunction

Function UpdateAllLists()

	For Local Bullets:TBullet = EachIn list_Bullets
		Bullets.Update()
	Next
	
	For Local ClonBullets:TClonBullet = EachIn list_ClonBullets
		ClonBullets.Update()
	Next
	
	For Local Enemies:TEnemy = EachIn list_Enemies
		Enemies.Update()
	Next
	
	For Local ClonEnemies:TClonEnemy = EachIn list_ClonEnemies
		ClonEnemies.Update()
	Next
	
	For Local PartEnemies:TPartEnemy = EachIn list_PartEnemies
		PartEnemies.Update()
	Next
	
	For Local PlayerClones:TPlayerClone = EachIn list_PlayerClones
		PlayerClones.Update()
	Next

EndFunction

Function UpdateAllAI( screen# )

	Select screen
	Case 0
	
	UpdateBackgrounds( 0 )
	UpdateButtons()

	Case 1

	UpdateLevelAI()
	UpdateAllLists()
	UpdateBackgrounds( 1 )

	EndSelect

EndFunction

Function UpdateBackgrounds( screen# )

	Select screen
	Case 0

	If ( MBg1_scaleX => 1 ) And ( MBg1_scaleX < 1.05 ) And ( MBg1_ScaleChange = 0 ) Then
		If acc_MBg1Scale < 0.001 Then acc_MBg1Scale:+ 0.00001
	EndIf

	If ( MBg1_scaleX > 1.15 ) And ( MBg1_scaleX < 2 ) And ( MBg1_ScaleChange = 0 ) Then
		If acc_MBg1Scale > 0.0001 Then acc_MBg1Scale:- 0.00001
	EndIf
	
	If ( MBg1_scaleX > 1.15 ) And ( MBg1_scaleX <= 2 ) And ( MBg1_ScaleChange = 1 ) Then
		If acc_MBg1Scale < 0.001 Then acc_MBg1Scale:+ 0.00001
	EndIf
	
	If ( MBg1_scaleX > 1 ) And ( MBg1_scaleX < 1.05 ) And ( MBg1_ScaleChange = 1 ) Then
		If acc_MBg1Scale > 0.0001 Then acc_MBg1Scale:- 0.00001
	EndIf


	'If MBg1_accScaleChange = 1 Then acc_MBg1Scale:- 0.00005
	'If acc_MBg1Scale <= 0 Then MBg1_accScaleChange = 0

	If ( MBg1_ScaleChange = 0 ) Then
		MBg1_scaleX:+ acc_MBg1Scale
		MBg1_scaleY:+ acc_MBg1Scale
	EndIf
	If MBg1_scaleX >= 1.2 Then MBg1_ScaleChange = 1
	
	If ( MBg1_ScaleChange = 1 ) Then
		MBg1_scaleX:- acc_MBg1Scale
		MBg1_scaleY:- acc_MBg1Scale
	EndIf
	If MBg1_scaleX <= 1 Then MBg1_ScaleChange = 0

	Case 1

	Bg1_downY:+ 10
	Bg1_upY:+ 10
	
	If Bg1_downY = 1200 Then Bg1_downY = 0
	If Bg1_upY = 1200 Then Bg1_upY = 0
	
	EndSelect

EndFunction

Function UpdateButtons()

	NG3_Alpha = 0
	DrawNG2 = True
	DrawNG4 = False

	If ( DepScale( 400, 350, 200, 100, 243, 30, 0.8, 1.0 ) => 0.8 ) And ( DepScale( 400, 350, 200, 100, 243, 30, 0.8, 1.0 ) <= 1 ) Then

		NG_Scale = DepScale( 400, 350, 200, 100, 243, 30, 0.8, 1.0 )
	
	Else
	
		If Not ImagesCollide( img_MouseCollide, MouseX(), MouseY(), 0, img_MenuNG_Collide, 400, 350, 0 ) Then NG_Scale = 0.8
	
	EndIf

	If ImagesCollide( img_MouseCollide, MouseX(), MouseY(), 0, img_MenuNG_Collide, 400, 350, 0 ) Then

		DrawNG1 = True
		NG3_Alpha = 1

		If MouseDown( 1 ) Then

			DrawNG4 = True
			DrawNG2 = False
			DrawNG1 = False
		
		EndIf
		
		If MouseHit( 1 ) Then ScreenChange = 1

	Else
	
		DrawNG1 = False
		If DepAlpha( 400, 350, 200, 100, 243, 30 ) < 1 Then NG3_Alpha = DepAlpha( 400, 350, 200, 100, 243, 30 )
	
	EndIf


	C3_Alpha = 0
	DrawC2 = True
	DrawC4 = False
	
	If ( DepScale( 400, 450, 200, 100, 252, 28, 0.8, 1.0 ) => 0.8 ) And ( DepScale( 400, 450, 200, 100, 252, 28, 0.8, 1.0 ) <= 1 ) Then

		C_Scale = DepScale( 400, 450, 200, 100, 252, 28, 0.8, 1.0 )
	
	Else
	
		If Not ImagesCollide( img_MouseCollide, MouseX(), MouseY(), 0, img_MenuC_Collide, 400, 450, 0 ) Then C_Scale = 0.8
	
	EndIf
	
	If ImagesCollide( img_MouseCollide, MouseX(), MouseY(), 0, img_MenuC_Collide, 400, 450, 0 ) Then

		DrawC1 = True
		C3_Alpha = 1
		
		If MouseDown( 1 ) Then

			DrawC4 = True
			DrawC2 = False
			DrawC1 = False

		EndIf
		
		' If MouseHit( 1 ) Then ...
	Else
	
		DrawC1 = False
		If DepAlpha( 400, 450, 200, 100, 252, 28 ) < 1 Then C3_Alpha = DepAlpha( 400, 450, 200, 100, 252, 28 )

	EndIf


	Q3_Alpha = 0
	DrawQ2 = True
	DrawQ4 = False
	
	If ( DepScale( 400, 550, 200, 100, 144, 30, 0.8, 1.0 ) => 0.8 ) And ( DepScale( 400, 550, 200, 100, 144, 30, 0.8, 1.0 ) <= 1 ) Then

		Q_Scale = DepScale( 400, 550, 200, 100, 144, 30, 0.8, 1.0 )
	
	Else
	
		If Not ImagesCollide( img_MouseCollide, MouseX(), MouseY(), 0, img_MenuQ_Collide, 400, 550, 0 ) Then Q_Scale = 0.8
	
	EndIf
	
	If ImagesCollide( img_MouseCollide, MouseX(), MouseY(), 0, img_MenuQ_Collide, 400, 550, 0 ) Then

		DrawQ1 = True
		Q3_Alpha = 1
		
		If MouseDown( 1 ) Then

			DrawQ4 = True
			DrawQ2 = False
			DrawQ1 = False

		EndIf
		
		If MouseHit( 1 ) Then UserQuit = True
	Else
	
		DrawQ1 = False
		If DepAlpha( 400, 550, 200, 100, 144, 30 ) < 1 Then Q3_Alpha = DepAlpha( 400, 550, 200, 100, 144, 30 )

	EndIf


	A3_Alpha = 0
	DrawA2 = True
	DrawA4 = False
	
	If ( DepScale( 400, 250, 200, 100, 162, 30, 0.8, 1.0 ) => 0.8 ) And ( DepScale( 400, 250, 200, 100, 162, 30, 0.8, 1.0 ) <= 1 ) Then

		A_Scale = DepScale( 400, 250, 200, 100, 162, 30, 0.8, 1.0 )
	
	Else
	
		If Not ImagesCollide( img_MouseCollide, MouseX(), MouseY(), 0, img_MenuA_Collide, 400, 250, 0 ) Then A_Scale = 0.8
	
	EndIf
	
	If ImagesCollide( img_MouseCollide, MouseX(), MouseY(), 0, img_MenuA_Collide, 400, 250, 0 ) Then

		DrawA1 = True
		A3_Alpha = 1
		
		If MouseDown( 1 ) Then

			DrawA4 = True
			DrawA2 = False
			DrawA1 = False

		EndIf
		
		' If MouseHit( 1 ) Then ...
	Else
	
		DrawA1 = False
		If DepAlpha( 400, 250, 200, 100, 162, 30 ) < 1 Then A3_Alpha = DepAlpha( 400, 250, 200, 100, 162, 30 )

	EndIf

	FlushMouse()

EndFunction
Function UpdateLaser( number )

	Select number
	Case 1

	If Laser1Animnext < MilliSecs() Then
		Laser1Animnext = MilliSecs() + 30
		Laser1Frame:+ 1
	EndIf
	If Laser1Frame = 22 Then Laser1Frame = 0

	EndSelect

EndFunction


Function FreeAllRes( screen# )

	Select screen
	Case 0

	img_MouseCollide = Null
	img_MenuBackground1 = Null
	img_MenuBackground2 = Null
	img_MenuBackground3 = Null
	img_MenuCursor1 = Null
	img_MenuNG1 = Null
	img_MenuNG2 = Null
	img_MenuNG3 = Null
	img_MenuNG4 = Null
	img_MenuNG_Collide = Null
	img_MenuNG_Collide2 = Null

	GCCollect()
	
	Case 1
	
	img_Background1_down = Null
	img_Background1_up = Null
	img_Player_Base = Null
	img_Player_Weapon1 = Null
	img_Player_Weapon2 = Null
	img_Player_CloneBase = Null
	img_Player_CloneWeapon1 = Null
	img_Player_CloneWeapon2 = Null
	img_Player_Life = Null
	img_Player_Damage = Null
	img_Bullet1 = Null
	img_Enemy1 = Null
	img_Enemy1_Part1 = Null
	img_Enemy1_Part2 = Null
	img_Enemy1_Part3 = Null
	img_Enemy1_Part4 = Null
	img_Enemy1_Part5 = Null
	img_Enemy1_Part6 = Null
	img_Enemy1_Flare = Null

	GCCollect()

	EndSelect

EndFunction

Function ResetVariables( screen# )

	Select screen
	Case 0

	MoveMouse( 400, 300 )
	
	MBg1_scaleX# = 1
	MBg1_scaleY# = 1
	MBg1_ScaleChange = 0
	MBg1_accScaleChange = 0
	DrawNG1 = False
	DrawNG2 = True
	DrawNG3 = True
	DrawNG4 = False
	NG3_Alpha# = 0
	NG_ScaleX# = 0.8
	NG_ScaleY# = 0.8
	NG_Scale# = 0.8

	Case 1

	MoveMouse( 400, 300 )

	timer_Enemies = 0
	timer_LevelTime_Frames = 0
	timer_LevelTime_Seconds = 0
	
	CurrentClones = 0
	Bg1_downY = 600
	Bg1_upY = 0

	plr_Life = 100
	plr_Weapon = 1

	EndSelect

EndFunction

Function AngleWithPoints:Double( x1:Double, y1:Double, x2:Double, y2:Double )
	Return ATan2( y2 - y1, x2 - x1 )
EndFunction

Function PAA_X( x, k, angle )
 	Return x + k * Cos( angle )
EndFunction

Function PAA_Y( y, k, angle )
	Return y + k * Sin( angle )
EndFunction

Function RectsOverlap( x0, y0, w0, h0, x2, y2, w2, h2 )

	If x0 > ( x2 + w2 ) Or ( x0 + w0 ) < x2 Then Return False
	If y0 > ( y2 + h2 ) Or ( y0 + h0 ) < y2 Then Return False
	Return True

End Function

Function DepAlpha:Float( PrimaryX#, PrimaryY#, ZoneW#, ZoneH#, CollideW#, CollideH# )

	Local Result#

	If ( MouseY() > PrimaryY + CollideH / 2 ) And ( MouseX() > PrimaryX - CollideW / 2 ) And ( MouseX() < PrimaryX + CollideW / 2 ) Then

		CollideH = CollideH / 2
		PrimaryY:+ CollideH
		Result = ( ( PrimaryY + ( ZoneH / 2 ) ) - MouseY() ) * ( 1 / ( ZoneH / 2 ) )
	
	EndIf
	If ( MouseY() < PrimaryY - CollideH / 2 ) And ( MouseX() > PrimaryX - CollideW / 2 ) And ( MouseX() < PrimaryX + CollideW / 2 ) Then

		CollideH = CollideH / 2
		PrimaryY:- CollideH
		Result = ( MouseY() - ( PrimaryY - ( ZoneH / 2 ) ) ) * ( 1 / ( ZoneH / 2 ) )
	
	EndIf

	If ( MouseX() > PrimaryX + CollideW / 2 ) And ( MouseY() > PrimaryY - ( ZoneH / 2 + CollideH / 2 ) ) And ( MouseY() < PrimaryY + ( ZoneH / 2 + CollideH / 2 ) ) Then

		CollideW = CollideW / 2
		PrimaryX:+ CollideW
		Result = ( ( PrimaryX + ( ZoneW / 2 ) ) - MouseX() ) * ( 1 / ( ZoneW / 2 ) )

	EndIf

	If ( MouseX() < PrimaryX - CollideW / 2 ) And ( MouseY() > PrimaryY - ( ZoneH / 2 + CollideH / 2 ) ) And ( MouseY() < PrimaryY + ( ZoneH / 2 + CollideH / 2 ) ) Then

		CollideW = CollideW / 2
		PrimaryX:- CollideW
		Result = ( MouseX() - ( PrimaryX - ( ZoneW / 2 ) ) ) * ( 1 / ( ZoneW / 2 ) )

	EndIf
	
	Return Result#

EndFunction

Function DepScale:Float( PrimaryX#, PrimaryY#, ZoneW#, ZoneH#, CollideW#, CollideH#, MinScale#, MaxScale# )

	Local Result#
	Local coeff_Scale#
	
	coeff_Scale = MaxScale - MinScale

	If ( MouseY() > PrimaryY + CollideH / 2 ) And ( MouseX() > PrimaryX - CollideW / 2 ) And ( MouseX() < PrimaryX + CollideW / 2 ) Then

		Result = ( ( ( ( PrimaryY + CollideH / 2 ) + ( ZoneH / 2 ) ) - MouseY() ) * ( coeff_Scale / ( ZoneH / 2 ) ) ) + MinScale
	
	EndIf

	If ( MouseY() < PrimaryY - CollideH / 2 ) And ( MouseX() > PrimaryX - CollideW / 2 ) And ( MouseX() < PrimaryX + CollideW / 2 ) Then

		Result = ( ( MouseY() - ( ( PrimaryY - CollideH / 2 ) - ( ZoneH / 2 ) ) ) * ( coeff_Scale / ( ZoneH / 2 ) ) ) + MinScale
	
	EndIf

	If ( MouseX() > PrimaryX + CollideW / 2 ) And ( MouseY() > PrimaryY - ( ZoneH / 2 + CollideH / 2 ) ) And ( MouseY() < PrimaryY + ( ZoneH / 2 + CollideH / 2 ) ) Then

		Result = ( ( ( ( PrimaryX + CollideW / 2 ) + ( ZoneW / 2 ) ) - MouseX() ) * ( coeff_Scale / ( ZoneW / 2 ) ) ) + MinScale
	
	EndIf

	If ( MouseX() < PrimaryX - CollideW / 2 ) And ( MouseY() > PrimaryY - ( ZoneH / 2 + CollideH / 2 ) ) And ( MouseY() < PrimaryY + ( ZoneH / 2 + CollideH / 2 ) ) Then

		Result = ( ( MouseX() - ( ( PrimaryX - CollideW / 2 ) - ( ZoneW / 2 ) ) ) * ( coeff_Scale / ( ZoneW / 2 ) ) ) + MinScale
	
	EndIf
	
	Return Result#

EndFunction

Rem
Function DepScaleX:Float( PrimaryX#, PrimaryY#, ZoneW#, ZoneH#, CollideW#, CollideH#, MinScale#, MaxScale# )

	Local Result#
	Local coeff_Scale#
	
	coeff_Scale = MaxScale - MinScale

	If ( MouseX() > PrimaryX + CollideW / 2 ) And ( MouseY() > PrimaryY - ( ZoneH / 2 + CollideH / 2 ) ) And ( MouseY() < PrimaryY + ( ZoneH / 2 + CollideH / 2 ) ) Then

		Result = ( MouseX() - ( PrimaryX + ( ZoneW / 2 ) ) ) * ( coeff_Scale / ( ZoneW / 2 ) )

	EndIf

	If ( MouseX() < PrimaryX - CollideW / 2 ) And ( MouseY() > PrimaryY - ( ZoneH / 2 + CollideH / 2 ) ) And ( MouseY() < PrimaryY + ( ZoneH / 2 + CollideH / 2 ) ) Then

		Result = ( ( MouseX() - ( PrimaryX - ( ZoneW / 2 ) ) ) * ( coeff_Scale / ( ZoneW / 2 ) )

	EndIf
	
	Return Result#

EndFunction
EndRem