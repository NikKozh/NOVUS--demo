Type TPlayerClone

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

		Alpha:- 0.1
		If Alpha <= 0 Then
			Remove
			CurrentPC:- 1
		EndIf

	EndMethod
	
	Function CreatePlayerClone:TPlayerClone( x#, y# )

		Local PlayerClone:TPlayerClone = New TPlayerClone
		PlayerClone.X = x
		PlayerClone.Y = y
		PlayerClone.Alpha = 1
		PlayerClone.AddLast( list_PlayerClones )
		Return PlayerClone

	EndFunction

EndType

Global plr_X#, plr_Y#
Global plr_Weapon1X#, plr_Weapon1Y#
Global plr_Weapon2X#, plr_Weapon2Y#
Global plr_Weapon3X#, plr_Weapon3Y#
Global plr_WeaponChange# = -1
Global plr_Ang
Global plr_Life = 100, plr_LifeAlpha#, plr_LifeChange = 0
Global plr_DamageAlpha#
Global plr_Weapon = 1
Global plr_Reload, plr_Weapon3Limit = 60

Global plr_buf_Life, plr_buf_LifeAlpha#, plr_buf_LifeChangeX = False, plr_buf_LifeChangeY = False
Global plr_buf_X#, plr_buf_Y#
Global plr_buf_PlusMinusX = False, plr_buf_PlusMinusY = False

Global plr_coeff_Weapon1X#, plr_coeff_Weapon1Y# = -41
Global plr_coeff_Weapon2X#, plr_coeff_Weapon2Y# = 12
Global plr_coeff_Weapon3X#, plr_coeff_Weapon3Y# = -11

Global plr_timer_LifeChange

Global plr_DrawWeapon1 = True, plr_DrawWeapon2 = False, plr_DrawWeapon3 = False

Global CurrentPC

Global list_PlayerClones:TList

Function UpdatePlayer()

	For Enemy:TEnemy = EachIn list_Enemies

		If ( ImagesCollide( img_Enemy1, Enemy.X, Enemy.Y, 0, img_Player_Base, plr_X, plr_Y, 0 ) ) And ( Enemy.Death = 0 ) Then

			plr_Life:- 10
			plr_buf_LifeAlpha:+ 0.1
			plr_LifeChange = 1
			plr_DamageAlpha = 1
			Enemy.Life:- 100
			Enemy.Death = 3

		EndIf

	Next
	
	If plr_LifeChange = 1 Then

		plr_timer_LifeChange = Rand( 30, 60 )
		plr_buf_X = plr_X
		plr_buf_Y = plr_Y
		plr_LifeChange = 2

	EndIf
	
	If plr_LifeChange = 2 Then

		If plr_LifeAlpha < plr_buf_LifeAlpha Then plr_LifeAlpha:+ 0.01

		plr_buf_LifeChangeX = False
		plr_buf_LifeChangeY = False

		If plr_buf_X <> 0 Then
		
			plr_buf_X = 0
			plr_buf_LifeChangeX = True
		
		EndIf
	 	If plr_buf_Y <> 0 Then

			plr_buf_Y = 0
			plr_buf_LifeChangeY = True
		
		EndIf
		
		If plr_buf_LifeChangeX = False Then

			plr_buf_PlusMinusX = Rand( 0, 1 )
			If plr_buf_PlusMinusX = True Then plr_buf_X:+ Rand( 0, 5 )
			If plr_buf_PlusMinusX = False Then plr_buf_X:- Rand( 0, 5 )

		EndIf
		If plr_buf_LifeChangeY = False Then

			plr_buf_PlusMinusY = Rand( 0, 1 )
			If plr_buf_PlusMinusY = True Then plr_buf_Y:+ Rand( 0, 5 )
			If plr_buf_PlusMinusY = False Then plr_buf_Y:- Rand( 0, 5 )

		EndIf
		
		plr_timer_LifeChange:- 1

		If plr_timer_LifeChange = 0 Then

			plr_buf_Y = 0
			plr_buf_X = 0
			plr_LifeChange = 0

		EndIf

	EndIf

	If plr_DamageAlpha > 0 Then plr_DamageAlpha:- 0.1
	
	If ( MouseX() > 49 ) And ( MouseX() < 751 ) Then plr_X = MouseX() + plr_buf_X Else plr_X:+ plr_buf_X
	If ( MouseY() < 567 ) And ( MouseY() > 34 ) Then plr_Y = MouseY() + plr_buf_Y Else plr_Y:+ plr_buf_Y
	
	If ( KeyHit( key_1 ) ) And ( plr_WeaponChange = -1 ) Then

		If plr_Weapon = 1 Then
			plr_DrawWeapon2 = True
			plr_WeaponChange = 2
		EndIf
		If plr_Weapon = 2 Then
			plr_DrawWeapon1 = True
			plr_WeaponChange = 3
		EndIf
		If ( plr_Weapon = 3 ) Or ( plr_Weapon = 4 ) Then
			plr_DrawWeapon1 = True
			plr_DrawWeapon2 = True
			plr_WeaponChange = 1
		EndIf

	EndIf
	
	If ( KeyHit( key_2 ) ) And ( plr_WeaponChange = -1 ) Then
		
		If ( plr_Weapon = 1 ) Or ( plr_Weapon = 2 ) Or ( plr_Weapon = 3 ) Then
			plr_DrawWeapon3 = True
			plr_WeaponChange = 4
		EndIf

	EndIf

	Select plr_WeaponChange
	Case 1

	If plr_coeff_Weapon2Y < 12 Then plr_coeff_Weapon2Y:+ 1
	If plr_coeff_Weapon1Y > -41 Then plr_coeff_Weapon1Y:- 1
	If plr_coeff_Weapon3Y < -11 Then plr_coeff_Weapon3Y:+ 1
	If ( plr_coeff_Weapon2Y = 12 ) And ( plr_coeff_Weapon1Y = -41 ) And ( plr_coeff_Weapon3Y = -11 ) Then
		plr_Weapon = 1
		plr_DrawWeapon2 = False
		plr_DrawWeapon3 = False
		plr_WeaponChange = -1
	EndIf
	
	Case 2
	
	If plr_coeff_Weapon1Y < -11 Then plr_coeff_Weapon1Y:+ 1
	If plr_coeff_Weapon2Y > -14 Then plr_coeff_Weapon2Y:- 1
	If ( plr_coeff_Weapon1Y = -11 ) And ( plr_coeff_Weapon2Y = -14 ) Then
		plr_Weapon = 2
		plr_DrawWeapon1 = False
		plr_WeaponChange = -1
	EndIf
	
	Case 3
	
	plr_coeff_Weapon1Y:- 1
	If plr_coeff_Weapon1Y = -41 Then
		plr_Weapon = 3
		plr_WeaponChange = -1
	EndIf
	
	Case 4
	
	If plr_coeff_Weapon1Y < -11 Then plr_coeff_Weapon1Y:+ 1
	If plr_coeff_Weapon2Y < 12 Then plr_coeff_Weapon2Y:+ 1
	If plr_coeff_Weapon3Y > -39 Then plr_coeff_Weapon3Y:- 1
	If ( plr_coeff_Weapon1Y = -11 ) And ( plr_coeff_Weapon2Y = 12 ) And ( plr_coeff_Weapon3Y = -39 )
		plr_Weapon = 4
		plr_DrawWeapon1 = False
		plr_DrawWeapon2 = False
		plr_WeaponChange = -1
	EndIf

	EndSelect

	' If KeyHit( key_2 ) Then plr_Weapon = 2
	' If KeyHit( key_3 ) Then plr_Weapon = 3

	plr_Weapon1X = plr_X
	plr_Weapon1Y = plr_Y + plr_coeff_Weapon1Y
	plr_Weapon2X = plr_X
	plr_Weapon2Y = plr_Y + plr_coeff_Weapon2Y
	plr_Weapon3X = plr_X
	plr_Weapon3Y = plr_Y + plr_coeff_Weapon3Y

Rem
	Select plr_Weapon
	Case 1
	
		plr_Weapon1X = plr_X
		plr_Weapon1Y = plr_Y + plr_coeff_Weapon1Y
	
	Case 2
	
		plr_Weapon2X = plr_X
		plr_Weapon2Y = plr_Y + plr_coeff_Weapon2Y

	Case 3

		plr_Weapon1X = plr_X
		plr_Weapon1Y = plr_Y + plr_coeff_Weapon1Y
		plr_Weapon2X = plr_X
		plr_Weapon2Y = plr_Y + plr_coeff_Weapon2Y
	
	EndSelect
EndRem

	TPlayerClone.CreatePlayerClone( plr_X, plr_Y )
	CurrentPC:+ 1

	DrawLaser1 = False

	If plr_Reload <> 0 Then plr_Reload:- 1

	If Not MouseDown( 1 ) Then
		If plr_Weapon3Limit < 30 Then plr_Weapon3Limit:+ 1
	EndIf

	If ( MouseDown( 1 ) ) And ( plr_Reload = 0 ) Then
	
		Select plr_Weapon
		Case 1

			TBullet.CreateBullet( plr_X, plr_Y, 10 )
			plr_Reload = 10

		Case 2

			TBullet.CreateBullet( plr_X - 34, plr_Y - 4, 10 )
			TBullet.CreateBullet( plr_X + 35, plr_Y - 4, 10 )
			plr_Reload = 10
		
		Case 3

			TBullet.CreateBullet( plr_X, plr_Y, 10 )
			TBullet.CreateBullet( plr_X - 34, plr_Y - 4, 10 )
			TBullet.CreateBullet( plr_X + 35, plr_Y - 4, 10 )
			plr_Reload = 10
		
		Case 4

			If plr_Weapon3Limit > 0 Then

				DrawLaser1 = True
				UpdateLaser( 1 )
				plr_Weapon3Limit:- 1
			
			EndIf
		
		EndSelect

	EndIf

EndFunction