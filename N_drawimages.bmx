Function DrawAllImages( screen# )

	Select screen
	Case 0

	DrawImage( img_MenuBackground1, 400, 300 )
	SetScale( MBg1_scaleX, MBg1_scaleY )
	DrawImage( img_MenuBackground3, 400, 300 )
	SetScale( 1, 1 )
	DrawImage( img_MenuBackground2, 400, 300 )

	SetScale( NG_Scale, NG_Scale )
	SetAlpha( NG3_Alpha )
	If DrawNG3 = True Then DrawImage( img_MenuNG3, 400, 350 )
	SetAlpha( 1 )
	If DrawNG2 = True Then DrawImage( img_MenuNG2, 400, 350 )
	If DrawNG1 = True Then DrawImage( img_MenuNG1, 400, 350 )
	If DrawNG4 = True Then DrawImage( img_MenuNG4, 400, 350 )
	SetScale( 1, 1 )
	
	SetScale( C_Scale, C_Scale )
	SetAlpha( C3_Alpha )
	If DrawC3 = True Then DrawImage( img_MenuC3, 400, 450 )
	SetAlpha( 1 )
	If DrawC2 = True Then DrawImage( img_MenuC2, 400, 450 )
	If DrawC1 = True Then DrawImage( img_MenuC1, 400, 450 )
	If DrawC4 = True Then DrawImage( img_MenuC4, 400, 450 )
	SetScale( 1, 1 )

	SetScale( Q_Scale, Q_Scale )
	SetAlpha( Q3_Alpha )
	If DrawQ3 = True Then DrawImage( img_MenuQ3, 400, 550 )
	SetAlpha( 1 )
	If DrawQ2 = True Then DrawImage( img_MenuQ2, 400, 550 )
	If DrawQ1 = True Then DrawImage( img_MenuQ1, 400, 550 )
	If DrawQ4 = True Then DrawImage( img_MenuQ4, 400, 550 )
	SetScale( 1, 1 )

	SetScale( A_Scale, A_Scale )
	SetAlpha( A3_Alpha )
	If DrawA3 = True Then DrawImage( img_MenuA3, 400, 250 )
	SetAlpha( 1 )
	If DrawA2 = True Then DrawImage( img_MenuA2, 400, 250 )
	If DrawA1 = True Then DrawImage( img_MenuA1, 400, 250 )
	If DrawA4 = True Then DrawImage( img_MenuA4, 400, 250 )
	SetScale( 1, 1 )
	
	DrawImage( img_MenuCursor1, MouseX(), MouseY() )
	DrawImage( img_MouseCollide, MouseX(), MouseY() )

	Case 1

	DrawImage( img_Background1_down, 400, Bg1_downY )
	DrawImage( img_Background1_up, 400, Bg1_upY )
	
	For Local ClonBullet:TClonBullet = EachIn list_ClonBullets
		SetAlpha( ClonBullet.Alpha )
		SetRotation( 270 )
		DrawImage( img_Bullet1, ClonBullet.X, ClonBullet.Y )
		SetRotation( 0 )
		SetAlpha( 1 )
	Next
	
	For Local Bullet:TBullet = EachIn list_Bullets
		SetRotation( 270 )
		DrawImage( img_Bullet1, Bullet.X, Bullet.Y )
		SetRotation( 0 )
	Next
	
	If DrawLaser1 = True Then
		SetRotation( 270 )
		DrawImage( img_Laser1, plr_X, plr_Y, Laser1Frame )
		SetRotation( 0 )
	EndIf

	For Local PartEnemy:TPartEnemy = EachIn list_PartEnemies

		SetRotation( PartEnemy.Ang )
		
		Select PartEnemy.Image

			Case 1
			DrawImage( img_Enemy1_Part1, PartEnemy.X, PartEnemy.Y )
			
			Case 2
			DrawImage( img_Enemy1_Part2, PartEnemy.X, PartEnemy.Y )
			
			Case 3
			DrawImage( img_Enemy1_Part3, PartEnemy.X, PartEnemy.Y )
			
			Case 4
			DrawImage( img_Enemy1_Part4, PartEnemy.X, PartEnemy.Y )
			
			Case 5
			DrawImage( img_Enemy1_Part5, PartEnemy.X, PartEnemy.Y )
			
			Case 6
			DrawImage( img_Enemy1_Part6, PartEnemy.X, PartEnemy.Y )
		
		EndSelect
		
		SetRotation( 0 )

	Next

	For Local ClonEnemy:TClonEnemy = EachIn list_ClonEnemies
		SetRotation( ClonEnemy.Ang )
		SetAlpha( ClonEnemy.Alpha )
		DrawImage( img_Enemy1, ClonEnemy.X, ClonEnemy.Y )
		SetAlpha( 1 )
		SetRotation( 0 )
	Next

	For Local Enemy:TEnemy = EachIn list_Enemies

		Select Enemy.Death
		Case 0

		SetRotation( Enemy.Ang )
		DrawImage( img_Enemy1, Enemy.X, Enemy.Y )
		SetRotation( 0 )
		
		Case 2
		
		SetAlpha( Enemy.Alpha )
		DrawImage( img_Enemy1_Death1, Enemy.X, Enemy.Y, Enemy.Frame )
		SetAlpha( 1 )
		
		EndSelect

	Next

	For Local PlayerClone:TPlayerClone = EachIn list_PlayerClones

		SetAlpha( PlayerClone.Alpha )
		DrawImage( img_Player_CloneBase, PlayerClone.X, PlayerClone.Y )
		If plr_DrawWeapon1 = True Then DrawImage( img_Player_CloneWeapon1, PlayerClone.X, PlayerClone.Y + plr_coeff_Weapon1Y + 2 )
		If plr_DrawWeapon2 = True Then DrawImage( img_Player_CloneWeapon2, PlayerClone.X, PlayerClone.Y + plr_coeff_Weapon2Y )
		If plr_DrawWeapon3 = True Then DrawImage( img_Player_CloneWeapon3, PlayerClone.X, PlayerClone.Y + plr_coeff_Weapon3Y )

		Rem
		Select plr_Weapon

		Case 1 DrawImage( img_Player_CloneWeapon1, PlayerClone.X, PlayerClone.Y - 40 )
		Case 2 DrawImage( img_Player_CloneWeapon2, PlayerClone.X, PlayerClone.Y - 14 )
		Case 3
			DrawImage( img_Player_CloneWeapon1, PlayerClone.X, PlayerClone.Y - 40 )
			DrawImage( img_Player_CloneWeapon2, PlayerClone.X, PlayerClone.Y - 14 )

		EndSelect
		EndRem

		SetAlpha( 1 )

	Next

Rem
	Select plr_Weapon

	Case 1 DrawImage( img_Player_Weapon1, plr_Weapon1X, plr_Weapon1Y )
	Case 2 DrawImage( img_Player_Weapon2, plr_Weapon2X, plr_Weapon2Y )
	Case 3
		DrawImage( img_Player_Weapon1, plr_Weapon1X, plr_Weapon1Y )
		DrawImage( img_Player_Weapon2, plr_Weapon2X, plr_Weapon2Y )

	EndSelect
EndRem

	If plr_DrawWeapon1 = True Then DrawImage( img_Player_Weapon1, plr_Weapon1X, plr_Weapon1Y )
	If plr_DrawWeapon2 = True Then DrawImage( img_Player_Weapon2, plr_Weapon2X, plr_Weapon2Y )
	If plr_DrawWeapon3 = True Then DrawImage( img_Player_Weapon3, plr_Weapon3X, plr_Weapon3Y )
	DrawImage( img_Player_Base, plr_X, plr_Y )
	'DrawImage( img_Player_Weapon2, plr_Weapon2X, plr_Weapon2Y )
	
	SetAlpha( plr_LifeAlpha )
	DrawImage( img_Player_Life, plr_X, plr_Y )
	SetAlpha( 1 )
	
	SetAlpha( plr_DamageAlpha )
	DrawImage( img_Player_Damage, plr_X, plr_Y )
	SetAlpha( 1 )
	
	EndSelect

	If DrawScreenChange1 = True Then DrawImage( img_ScreenChange1, ScreenChange1X, ScreenChange1Y )
	If DrawScreenChange2 = True Then DrawImage( img_ScreenChange2, ScreenChange2X, ScreenChange2Y )

EndFunction