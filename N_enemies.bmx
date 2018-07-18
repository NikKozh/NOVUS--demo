Type TEnemy

	Field link:TLink
	Field X#, Y#
	Field Speed#
	Field Life
	Field Ang
	Field Alpha#
	Field Death
	Field Frame, Animnext

	Method Remove()
		link.remove
	EndMethod
	
	Method AddLast( list:TList )
		link = list.AddLast( Self )
	EndMethod
	
	Method Update()

		If Y > 700 Then Remove
		
		X:+ Speed * Cos( 90 )
		Y:+ Speed * Sin( 90 )
		
		Ang:+ 5
		If Ang = 360 Then Ang = 0
		
		If Death <> 2 Then TClonEnemy.CreateClonEnemy( X, Y, Ang )
		CurrentClones:+ 1

		For Bullet:TBullet = EachIn list_Bullets

			If ImagesCollide( img_Bullet1, Bullet.X, Bullet.Y, 0, img_Enemy1, X, Y, 0 ) Then

				Life:- 5
				Death = 3
				Bullet.Remove

			EndIf

		Next
		
		If ( ImagesCollide2( img_Laser1, plr_X, plr_Y, 0, 270, 1, 1, img_Enemy1, X, Y, 0, Ang, 1, 1 ) ) And ( DrawLaser1 = True ) Then

			Life:- 5
			Death = 2

		EndIf

		If Life <= 0 Then
		
			Select Death
			Case 2
			
			Alpha:- 0.01
			If Animnext < MilliSecs() Then
				Frame:+ 1
				Animnext = MilliSecs() + 60
			EndIf
			If Frame = 10 Then Remove

			Case 3

			TPartEnemy.CreatePartEnemy( X - 10, Y - 10, Ang, Speed, 1 )
			TPartEnemy.CreatePartEnemy( X - 10, Y + 10, Ang, Speed, 2 )
			TPartEnemy.CreatePartEnemy( X + 10, Y + 10, Ang, Speed, 3 )
			TPartEnemy.CreatePartEnemy( X, Y, Ang, Speed, 4 )
			TPartEnemy.CreatePartEnemy( X + 10, Y, Ang, Speed, 5 )
			TPartEnemy.CreatePartEnemy( X + 10, Y - 10, Ang, Speed, 6 )
			Remove
			' CountKillEnemies:+ 1
			
			EndSelect

		EndIf

	EndMethod
	
	Function CreateEnemy:TEnemy( x#, y#, speed#, life# )
	
		Local Enemy:TEnemy = New TEnemy
		Enemy.X = x
		Enemy.Y = y
		Enemy.Ang = 0
		Enemy.Speed = speed
		Enemy.Life = life
		Enemy.Alpha = 1
		Enemy.Frame = 0
		Enemy.Animnext = 0
		Enemy.Death = 0
		Enemy.AddLast( list_Enemies )
		Return Enemy
	
	EndFunction

EndType

Type TClonEnemy

	Field link:TLink
	Field X#, Y#
	Field Ang
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
			CurrentClones:- 1
		EndIf

	EndMethod
	
	Function CreateClonEnemy:TClonEnemy( x#, y#, ang )

		Local ClonEnemy:TClonEnemy = New TClonEnemy
		ClonEnemy.X = x
		ClonEnemy.Y = y
		ClonEnemy.Ang = ang
		ClonEnemy.Alpha = 1
		ClonEnemy.AddLast( list_ClonEnemies )
		Return ClonEnemy

	EndFunction

EndType

Type TPartEnemy

	Field link:TLink
	Field X#, Y#
	Field Ang
	Field Speed, acc_Speed#
	Field Image
	
	Method Remove()
		link.remove
	EndMethod
	
	Method AddLast( list:TList )
		link = list.AddLast( Self )
	EndMethod
	
	Method Update()
		
		' Speed:+ acc_Speed

		If Y > 700 Then Remove
		
		'X:+ Speed * Cos( 90 )

		If ( Image = 1 ) Or ( Image = 2 ) Then X:- 2
		If ( Image = 4 ) Or ( Image = 5 ) Or ( Image = 6 ) Then X:+ 2
		Y:+ Speed * Sin( 90 )
		
		Ang:+ 5
		If Ang >= 360 Then Ang = 0

	EndMethod
	
	Function CreatePartEnemy:TPartEnemy( x#, y#, ang, speed, img )

		Local PartEnemy:TPartEnemy = New TPartEnemy
		PartEnemy.X = x
		PartEnemy.Y = y
		PartEnemy.Ang = ang
		PartEnemy.Speed = Rand( 6, 9 )
		PartEnemy.acc_Speed = Rnd( 0.1, 0.4 )
		PartEnemy.Image = img
		PartEnemy.AddLast( list_PartEnemies )
		Return PartEnemy

	EndFunction

EndType


Global list_Enemies:TList
Global list_ClonEnemies:TList
Global list_PartEnemies:TList