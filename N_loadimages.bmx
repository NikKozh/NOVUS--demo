Global pm_Grab1:TPixmap
Global pm_Grab2:TPixmap

Global img_Grab1:TImage
Global img_Grab2:TImage

Global img_ScreenChange1:TImage
Global img_ScreenChange2:TImage

'---------------------------------

Global img_Background1_down:TImage
Global img_Background1_up:TImage

Global img_Player_Base:TImage
Global img_Player_Weapon1:TImage
Global img_Player_Weapon2:TImage
Global img_Player_Weapon3:TImage
Global img_Player_CloneBase:TImage
Global img_Player_CloneWeapon1:TImage
Global img_Player_CloneWeapon2:TImage
Global img_Player_CloneWeapon3:TImage
Global img_Player_Life:TImage
Global img_Player_Damage:TImage

Global img_Bullet1:TImage
Global img_Laser1:TImage

Global img_Enemy1:TImage
Global img_Enemy1_Part1:TImage
Global img_Enemy1_Part2:TImage
Global img_Enemy1_Part3:TImage
Global img_Enemy1_Part4:TImage
Global img_Enemy1_Part5:TImage
Global img_Enemy1_Part6:TImage
Global img_Enemy1_Flare:TImage
Global img_Enemy1_Death1:TImage

'-----------------------------

Global img_MouseCollide:TImage

Global img_MenuBackground1:TImage
Global img_MenuBackground2:TImage
Global img_MenuBackground3:TImage

Global img_MenuCursor1:TImage

Global img_MenuNG1:TImage
Global img_MenuNG2:TImage
Global img_MenuNG3:TImage
Global img_MenuNG4:TImage
Global img_MenuNG_Collide:TImage
Global img_MenuNG_Collide2:TImage

Global img_MenuC1:TImage
Global img_MenuC2:TImage
Global img_MenuC3:TImage
Global img_MenuC4:TImage
Global img_MenuC_Collide:TImage

Global img_MenuQ1:TImage
Global img_MenuQ2:TImage
Global img_MenuQ3:TImage
Global img_MenuQ4:TImage
Global img_MenuQ_Collide:TImage

Global img_MenuA1:TImage
Global img_MenuA2:TImage
Global img_MenuA3:TImage
Global img_MenuA4:TImage
Global img_MenuA_Collide:TImage

Function LoadAllImages( screen# )

	pm_Grab1 = CreatePixmap( 800, 600, PF_RGBA8888 )
	pm_Grab2 = CreatePixmap( 800, 600, PF_RGBA8888 )

	img_ScreenChange1 = LoadImage( "Data\Images\ScreenChange1.png" )
	MidHandleImage( img_ScreenChange1 )
	img_ScreenChange2 = LoadImage( "Data\Images\ScreenChange2.png" )
	MidHandleImage( img_ScreenChange2 )

	Select screen
	Case 0

	img_MenuBackground1 = LoadImage( "Data\Images\BackgroundMenu1.png" )
	MidHandleImage( img_MenuBackground1 )
	img_MenuBackground2 = LoadImage( "Data\Images\BackgroundMenu2.png" )
	MidHandleImage( img_MenuBackground2 )
	img_MenuBackground3 = LoadImage( "Data\Images\BackgroundMenu3.png" )
	MidHandleImage( img_MenuBackground3 )
	
	img_MenuCursor1 = LoadImage( "Data\Images\Cursor1.png" )
	SetImageHandle( img_MenuCursor1, 7, 7 )
	
	img_MenuNG1 = LoadImage( "Data\Images\MenuNG1.png" )
	MidHandleImage( img_MenuNG1 )
	img_MenuNG2 = LoadImage( "Data\Images\MenuNG2.png" )
	MidHandleImage( img_MenuNG2 )
	img_MenuNG3 = LoadImage( "Data\Images\MenuNG3.png" )
	MidHandleImage( img_MenuNG3 )
	img_MenuNG4 = LoadImage( "Data\Images\MenuNG4.png" )
	MidHandleImage( img_MenuNG4 )
	img_MenuNG_Collide = LoadImage( "Data\Images\MenuNG_Collide.png" )
	MidHandleImage( img_MenuNG_Collide )
	img_MenuNG_Collide2 = LoadImage( "Data\Images\MenuNG_Collide2.png" )
	MidHandleImage( img_MenuNG_Collide2 )
	
	img_MenuC1 = LoadImage( "Data\Images\MenuC1.png" )
	MidHandleImage( img_MenuC1 )
	img_MenuC2 = LoadImage( "Data\Images\MenuC2.png" )
	MidHandleImage( img_MenuC2 )
	img_MenuC3 = LoadImage( "Data\Images\MenuC3.png" )
	MidHandleImage( img_MenuC3 )
	img_MenuC4 = LoadImage( "Data\Images\MenuC4.png" )
	MidHandleImage( img_MenuC4 )
	img_MenuC_Collide = LoadImage( "Data\Images\MenuC_Collide.png" )
	MidHandleImage( img_MenuC_Collide )

	img_MenuQ1 = LoadImage( "Data\Images\MenuQ1.png" )
	MidHandleImage( img_MenuQ1 )
	img_MenuQ2 = LoadImage( "Data\Images\MenuQ2.png" )
	MidHandleImage( img_MenuQ2 )
	img_MenuQ3 = LoadImage( "Data\Images\MenuQ3.png" )
	MidHandleImage( img_MenuQ3 )
	img_MenuQ4 = LoadImage( "Data\Images\MenuQ4.png" )
	MidHandleImage( img_MenuQ4 )
	img_MenuQ_Collide = LoadImage( "Data\Images\MenuQ_Collide.png" )
	MidHandleImage( img_MenuQ_Collide )

	img_MenuA1 = LoadImage( "Data\Images\MenuA1.png" )
	MidHandleImage( img_MenuA1 )
	img_MenuA2 = LoadImage( "Data\Images\MenuA2.png" )
	MidHandleImage( img_MenuA2 )
	img_MenuA3 = LoadImage( "Data\Images\MenuA3.png" )
	MidHandleImage( img_MenuA3 )
	img_MenuA4 = LoadImage( "Data\Images\MenuA4.png" )
	MidHandleImage( img_MenuA4 )
	img_MenuA_Collide = LoadImage( "Data\Images\MenuA_Collide.png" )
	MidHandleImage( img_MenuA_Collide )
	
	img_MouseCollide = LoadImage( "Data\Images\MouseCollide.png" )

	Case 1

	img_Background1_down = LoadImage( "Data\Images\BackgroundGame1.png" )
	SetImageHandle( img_Background1_down, 400, 600 )
	img_Background1_up = LoadImage( "Data\Images\BackgroundGame2.png" )
	SetImageHandle( img_Background1_up, 400, 600 )
	
	img_Player_Base = LoadImage( "Data\Images\Player_Base.png" )
	MidHandleImage( img_Player_Base )
	img_Player_Weapon1 = LoadImage( "Data\Images\Player_Weapon1.png" )
	MidHandleImage( img_Player_Weapon1 )
	img_Player_Weapon2 = LoadImage( "Data\Images\Player_Weapon2.png" )
	MidHandleImage( img_Player_Weapon2 )
	img_Player_Weapon3 = LoadImage( "Data\Images\Player_Weapon3.png" )
	MidHandleImage( img_Player_Weapon3 )
	img_Player_Life = LoadImage( "Data\Images\Player_Health.png" )
	MidHandleImage( img_Player_Life )
	img_Player_Damage = LoadImage( "Data\Images\Player_Damage.png" )
	MidHandleImage( img_Player_Damage )
	img_Player_CloneBase = LoadImage( "Data\Images\Player_CloneBase.png" )
	MidHandleImage( img_Player_CloneBase )
	img_Player_CloneWeapon1 = LoadImage( "Data\Images\Player_CloneWeapon1.png" )
	MidHandleImage( img_Player_CloneWeapon1 )
	img_Player_CloneWeapon2 = LoadImage( "Data\Images\Player_CloneWeapon2.png" )
	MidHandleImage( img_Player_CloneWeapon2 )
	img_Player_CloneWeapon3 = LoadImage( "Data\Images\Player_CloneWeapon3.png" )
	MidHandleImage( img_Player_CloneWeapon3 )
	
	img_Bullet1 = LoadImage( "Data\Images\Bullet1.png" )
	MidHandleImage( img_Bullet1 )
	img_Laser1 = LoadAnimImage( "Data\Images\Laser1.png", 600, 8, 0, 22 )
	SetImageHandle( img_Laser1, 0, 4 )
	
	img_Enemy1 = LoadImage( "Data\Images\Enemy1.png" )
	MidHandleImage( img_Enemy1 )
	img_Enemy1_Death1 = LoadAnimImage( "Data\Images\Enemy1_Death1.png", 33, 33, 0, 10 )
	MidHandleImage( img_Enemy1_Death1 )
	img_Enemy1_Part1 = LoadImage( "Data\Images\Enemy1_Part1.png" )
	MidHandleImage( img_Enemy1_Part1 )
	img_Enemy1_Part2 = LoadImage( "Data\Images\Enemy1_Part2.png" )
	MidHandleImage( img_Enemy1_Part2 )
	img_Enemy1_Part3 = LoadImage( "Data\Images\Enemy1_Part3.png" )
	MidHandleImage( img_Enemy1_Part3 )
	img_Enemy1_Part4 = LoadImage( "Data\Images\Enemy1_Part4.png" )
	MidHandleImage( img_Enemy1_Part4 )
	img_Enemy1_Part5 = LoadImage( "Data\Images\Enemy1_Part5.png" )
	MidHandleImage( img_Enemy1_Part5 )
	img_Enemy1_Part6 = LoadImage( "Data\Images\Enemy1_Part6.png" )
	MidHandleImage( img_Enemy1_Part6 )
	
	EndSelect

EndFunction