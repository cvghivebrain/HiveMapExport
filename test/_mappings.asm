sonic:
mappings:
		ptr frame_Blank
		ptr frame_Walk26
		ptr frame_Walk36
		ptr frame_Stand
		ptr frame_Wait1
		ptr frame_Wait2
		ptr frame_Wait3
		ptr frame_LookUp
		ptr frame_Walk11
		ptr frame_Walk12
		ptr frame_Walk13
		ptr frame_Walk14
		ptr frame_Walk15
		ptr frame_Walk43
		ptr frame_Walk42
		ptr frame_Walk41
		ptr frame_Walk35
		ptr frame_Walk34
		ptr frame_Walk33
		ptr frame_Walk32
		ptr frame_Walk31
		ptr frame_Walk25
		ptr frame_Run13
		ptr frame_Roll3
		ptr frame_Spring
		ptr frame_Shrink3
		ptr frame_Shrink4
		ptr frame_Shrink5
		ptr frame_Float5
		ptr frame_Float6
		ptr frame_Injury
		ptr frame_GetAir
		ptr frame_WaterSlide
		ptr frame_BubStand
		ptr frame_Surf
		ptr frame_Push4
		ptr frame_Push3
		ptr frame_Push2
		ptr frame_Push1
		ptr frame_Leap2
		ptr frame_Leap1
		ptr frame_Hang2
		ptr frame_Hang1
		ptr frame_Roll4
		ptr frame_Run14
		ptr frame_Run21
		ptr frame_Roll5
		ptr frame_Warp1
		ptr frame_Run22
		ptr frame_Warp2
		ptr frame_Run23
		ptr frame_Run24
		ptr frame_Warp3
		ptr frame_Warp4
		ptr frame_Run31
		ptr frame_Run32
		ptr frame_Stop1
		ptr frame_Stop2
		ptr frame_Run33
		ptr frame_Run34
		ptr frame_Duck
		ptr frame_Balance1
		ptr frame_Run41
		ptr frame_Burnt
		ptr frame_Balance2
		ptr frame_Run42
		ptr frame_Walk44
		ptr frame_Walk16
		ptr frame_Walk21
		ptr frame_Walk22
		ptr frame_Walk23
		ptr frame_Walk24
		ptr frame_Run12
		ptr frame_Roll2
		ptr frame_Float4
		ptr frame_Shrink2
		ptr frame_Shrink1
		ptr frame_Death
		ptr frame_Drown
		ptr frame_Float1
		ptr frame_Run43
		ptr frame_Walk45
		ptr frame_Walk46
		ptr frame_Run11
		ptr frame_Roll1
		ptr frame_Float3
		ptr frame_Float2
		ptr frame_Run44

frame_Blank:
		spritemap
		endsprite

dplc_Blank:
	.end:
frame_Walk26:
		spritemap
		piece -17, -17, 4x3, 0
		piece -6, 7, 3x2, 12
		piece 15, -1, 1x1, 18
		endsprite

dplc_Walk26:
		dc.w (11<<12)+0
		dc.w (5<<12)+12
		dc.w (0<<12)+18
	.end:
frame_Walk36:
		spritemap
		piece -17, -12, 1x3, 0
		piece -9, -14, 4x4, 3
		endsprite

dplc_Walk36:
		dc.w (2<<12)+19
		dc.w (15<<12)+22
	.end:
frame_Stand:
		spritemap
		piece -16, -19, 3x4, 0, hi
		piece 8, -7, 1x1, 12
		piece -9, 13, 3x1, 13
		endsprite

dplc_Stand:
		dc.w (11<<12)+38
		dc.w (0<<12)+50
		dc.w (2<<12)+51
	.end:
frame_Wait1:
		spritemap
		piece -15, -18, 3x4, 0
		piece -8, 14, 3x1, 12
		endsprite

dplc_Wait1:
		dc.w (11<<12)+54
		dc.w (2<<12)+66
	.end:
frame_Wait2:
		spritemap
		piece -15, -18, 3x4, 0
		piece -8, 14, 3x1, 12
		endsprite

dplc_Wait2:
		dc.w (11<<12)+69
		dc.w (2<<12)+81
	.end:
frame_Wait3:
		spritemap
		piece -15, -18, 3x4, 0
		piece -8, 14, 3x1, 12
		endsprite

dplc_Wait3:
		dc.w (11<<12)+84
		dc.w (2<<12)+96
	.end:
frame_LookUp:
		spritemap
		piece -16, -18, 3x4, 0
		piece -8, 14, 3x1, 12
		endsprite

dplc_LookUp:
		dc.w (11<<12)+99
		dc.w (2<<12)+111
	.end:
frame_Walk11:
		spritemap
		piece -12, -19, 3x1, 0
		piece -17, -11, 4x3, 3
		piece -17, 13, 1x1, 15
		piece 10, 2, 2x2, 16
		endsprite

dplc_Walk11:
		dc.w (2<<12)+114
		dc.w (11<<12)+117
		dc.w (0<<12)+129
		dc.w (3<<12)+130
	.end:
frame_Walk12:
		spritemap
		piece -12, -18, 3x1, 0
		piece -12, -10, 4x1, 3
		piece -12, -2, 3x3, 7
		piece 12, 11, 1x1, 16
		endsprite

dplc_Walk12:
		dc.w (2<<12)+134
		dc.w (3<<12)+137
		dc.w (8<<12)+141
		dc.w (0<<12)+150
	.end:
frame_Walk13:
		spritemap
		piece -13, -17, 3x4, 0
		piece -10, 15, 2x1, 12
		endsprite

dplc_Walk13:
		dc.w (11<<12)+151
		dc.w (1<<12)+163
	.end:
frame_Walk14:
		spritemap
		piece -12, -19, 3x1, 0
		piece -12, -11, 4x4, 3
		piece -20, 0, 1x3, 19
		endsprite

dplc_Walk14:
		dc.w (2<<12)+165
		dc.w (15<<12)+168
		dc.w (2<<12)+184
	.end:
frame_Walk15:
		spritemap
		piece -13, -18, 3x4, 0
		piece -21, 0, 1x2, 12
		piece -3, 14, 2x1, 14
		endsprite

dplc_Walk15:
		dc.w (11<<12)+187
		dc.w (1<<12)+199
		dc.w (1<<12)+201
	.end:
frame_Walk43:
		spritemap
		piece -19, -9, 3x3, 0
		piece 2, -19, 2x3, 9
		piece 5, 5, 1x1, 15
		endsprite

dplc_Walk43:
		dc.w (8<<12)+203
		dc.w (5<<12)+212
		dc.w (0<<12)+218
	.end:
frame_Walk42:
		spritemap
		piece -18, -8, 3x3, 0
		piece 6, -10, 2x3, 9
		piece -5, -23, 2x2, 15
		piece -8, 16, 1x1, 19
		endsprite

dplc_Walk42:
		dc.w (8<<12)+219
		dc.w (5<<12)+228
		dc.w (3<<12)+234
		dc.w (0<<12)+238
	.end:
frame_Walk41:
		spritemap
		piece -19, -11, 3x4, 0
		piece 5, -5, 2x2, 12
		piece 21, -5, 1x1, 16
		piece -13, -19, 2x1, 17
		endsprite

dplc_Walk41:
		dc.w (11<<12)+239
		dc.w (3<<12)+251
		dc.w (0<<12)+255
		dc.w (1<<12)+256
	.end:
frame_Walk35:
		spritemap
		piece -18, -12, 2x3, 0
		piece -2, -11, 2x3, 6
		piece 8, 13, 1x1, 12
		piece 14, -10, 1x2, 13
		endsprite

dplc_Walk35:
		dc.w (5<<12)+258
		dc.w (5<<12)+264
		dc.w (0<<12)+270
		dc.w (1<<12)+271
	.end:
frame_Walk34:
		spritemap
		piece -19, -13, 1x3, 0
		piece -11, -13, 4x4, 3
		piece 2, -20, 2x1, 19
		endsprite

dplc_Walk34:
		dc.w (2<<12)+273
		dc.w (15<<12)+276
		dc.w (1<<12)+292
	.end:
frame_Walk33:
		spritemap
		piece -17, -12, 4x3, 0
		piece 15, -3, 1x2, 12
		endsprite

dplc_Walk33:
		dc.w (11<<12)+294
		dc.w (1<<12)+306
	.end:
frame_Walk32:
		spritemap
		piece -18, -14, 4x4, 0
		piece 11, -19, 2x2, 16
		piece 14, 2, 1x1, 20
		endsprite

dplc_Walk32:
		dc.w (15<<12)+308
		dc.w (3<<12)+324
		dc.w (0<<12)+328
	.end:
frame_Walk31:
		spritemap
		piece -19, -14, 4x4, 0
		piece 2, -20, 2x2, 16
		piece 13, 9, 1x1, 20
		endsprite

dplc_Walk31:
		dc.w (15<<12)+329
		dc.w (3<<12)+345
		dc.w (0<<12)+349
	.end:
frame_Walk25:
		spritemap
		piece -16, -20, 3x2, 0
		piece -12, -4, 4x2, 6
		piece -3, 12, 1x1, 14
		piece 12, 12, 1x1, 15
		endsprite

dplc_Walk25:
		dc.w (5<<12)+350
		dc.w (7<<12)+356
		dc.w (0<<12)+364
		dc.w (0<<12)+365
	.end:
frame_Run13:
		spritemap
		piece -12, -15, 3x2, 0
		piece -18, 0, 4x3, 6
		endsprite

dplc_Run13:
		dc.w (5<<12)+366
		dc.w (11<<12)+372
	.end:
frame_Roll3:
		spritemap
		piece -16, -16, 4x4, 0
		endsprite

dplc_Roll3:
		dc.w (15<<12)+384
	.end:
frame_Spring:
		spritemap
		piece -16, -22, 3x4, 0
		piece -7, 10, 1x2, 12
		endsprite

dplc_Spring:
		dc.w (11<<12)+400
		dc.w (1<<12)+412
	.end:
frame_Shrink3:
		spritemap
		piece -11, -14, 3x4, 0
		endsprite

dplc_Shrink3:
		dc.w (11<<12)+414
	.end:
frame_Shrink4:
		spritemap
		piece -7, -9, 2x3, 0
		endsprite

dplc_Shrink4:
		dc.w (5<<12)+426
	.end:
frame_Shrink5:
		spritemap
		piece -4, -5, 1x2, 0
		endsprite

dplc_Shrink5:
		dc.w (1<<12)+432
	.end:
frame_Float5:
		spritemap
		piece -28, -12, 4x3, 0
		piece 4, -3, 2x2, 12
		endsprite

dplc_Float5:
		dc.w (11<<12)+434
		dc.w (3<<12)+446
	.end:
frame_Float6:
		spritemap
		piece -12, -12, 4x3, 0
		piece 20, -7, 1x1, 12
		endsprite

dplc_Float6:
		dc.w (11<<12)+450
		dc.w (0<<12)+462
	.end:
frame_Injury:
		spritemap
		piece -20, -12, 4x4, 0
		piece 12, -6, 1x3, 16
		endsprite

dplc_Injury:
		dc.w (15<<12)+463
		dc.w (2<<12)+479
	.end:
frame_GetAir:
		spritemap
		piece -18, -18, 4x4, 0
		piece -15, 14, 4x1, 16
		piece 14, 4, 1x1, 20
		endsprite

dplc_GetAir:
		dc.w (15<<12)+482
		dc.w (3<<12)+498
		dc.w (0<<12)+502
	.end:
frame_WaterSlide:
		spritemap
		piece -20, -12, 4x4, 0
		piece 12, -8, 1x3, 16
		endsprite

dplc_WaterSlide:
		dc.w (15<<12)+503
		dc.w (2<<12)+519
	.end:
frame_BubStand:
		spritemap
		piece -14, -21, 3x4, 0
		piece -8, 11, 2x2, 12
		endsprite

dplc_BubStand:
		dc.w (11<<12)+522
		dc.w (3<<12)+534
	.end:
frame_Surf:
		spritemap
		piece -16, -19, 3x2, 0
		piece -15, -3, 4x3, 6
		endsprite

dplc_Surf:
		dc.w (5<<12)+538
		dc.w (11<<12)+544
	.end:
frame_Push4:
		spritemap
		piece -11, -17, 3x4, 0
		piece -13, 11, 2x2, 12
		endsprite

dplc_Push4:
		dc.w (11<<12)+556
		dc.w (3<<12)+568
	.end:
frame_Push3:
		spritemap
		piece -11, -16, 3x4, 0
		piece -17, 11, 3x2, 12
		endsprite

dplc_Push3:
		dc.w (11<<12)+572
		dc.w (5<<12)+584
	.end:
frame_Push2:
		spritemap
		piece -11, -17, 3x4, 0
		piece -13, 11, 2x2, 12
		endsprite

dplc_Push2:
		dc.w (11<<12)+590
		dc.w (3<<12)+602
	.end:
frame_Push1:
		spritemap
		piece -11, -16, 3x4, 0
		piece -18, 10, 4x2, 12
		endsprite

dplc_Push1:
		dc.w (11<<12)+606
		dc.w (7<<12)+618
	.end:
frame_Leap2:
		spritemap
		piece -16, -24, 4x4, 0
		piece 16, -23, 1x1, 16
		piece -7, 8, 3x2, 17
		endsprite

dplc_Leap2:
		dc.w (15<<12)+626
		dc.w (0<<12)+642
		dc.w (5<<12)+643
	.end:
frame_Leap1:
		spritemap
		piece -16, -24, 4x4, 0
		piece -7, 8, 3x2, 16
		piece 16, -10, 1x1, 22
		endsprite

dplc_Leap1:
		dc.w (15<<12)+649
		dc.w (5<<12)+665
		dc.w (0<<12)+671
	.end:
frame_Hang2:
		spritemap
		piece -24, -10, 4x3, 0
		piece 8, -3, 2x3, 12
		endsprite

dplc_Hang2:
		dc.w (11<<12)+672
		dc.w (5<<12)+684
	.end:
frame_Hang1:
		spritemap
		piece -24, -10, 4x3, 0
		piece 8, -4, 2x3, 12
		endsprite

dplc_Hang1:
		dc.w (11<<12)+690
		dc.w (5<<12)+702
	.end:
frame_Roll4:
		spritemap
		piece -16, -16, 4x4, 0
		endsprite

dplc_Roll4:
		dc.w (15<<12)+708
	.end:
frame_Run14:
		spritemap
		piece -12, -16, 3x2, 0
		piece -19, 0, 4x3, 6
		endsprite

dplc_Run14:
		dc.w (5<<12)+724
		dc.w (11<<12)+730
	.end:
frame_Run21:
		spritemap
		piece -16, -17, 4x3, 0
		piece -5, 7, 3x2, 12
		piece 16, -2, 1x2, 18
		endsprite

dplc_Run21:
		dc.w (11<<12)+742
		dc.w (5<<12)+754
		dc.w (1<<12)+760
	.end:
frame_Roll5:
		spritemap
		piece -16, -16, 4x4, 0
		endsprite

dplc_Roll5:
		dc.w (15<<12)+762
	.end:
frame_Warp1:
		spritemap
		piece -20, -11, 4x3, 0
		piece 12, -11, 1x3, 12
		endsprite

dplc_Warp1:
		dc.w (11<<12)+778
		dc.w (2<<12)+790
	.end:
frame_Run22:
		spritemap
		piece -15, -18, 4x3, 0
		piece -5, 6, 3x2, 12
		piece 17, -1, 1x2, 18
		endsprite

dplc_Run22:
		dc.w (11<<12)+793
		dc.w (5<<12)+805
		dc.w (1<<12)+811
	.end:
frame_Warp2:
		spritemap
		piece -16, -16, 4x4, 0
		endsprite

dplc_Warp2:
		dc.w (15<<12)+813
	.end:
frame_Run23:
		spritemap
		piece -16, -17, 4x3, 0
		piece -5, 7, 3x2, 12
		piece 16, -2, 1x2, 18
		endsprite

dplc_Run23:
		dc.w (11<<12)+829
		dc.w (5<<12)+841
		dc.w (1<<12)+847
	.end:
frame_Run24:
		spritemap
		piece -15, -18, 4x3, 0
		piece -5, 6, 3x2, 12
		piece 17, -1, 1x2, 18
		endsprite

dplc_Run24:
		dc.w (11<<12)+849
		dc.w (5<<12)+861
		dc.w (1<<12)+867
	.end:
frame_Warp3:
		spritemap
		piece -11, -20, 3x4, 0
		piece -11, 12, 3x1, 12
		endsprite

dplc_Warp3:
		dc.w (11<<12)+869
		dc.w (2<<12)+881
	.end:
frame_Warp4:
		spritemap
		piece -16, -16, 4x4, 0
		endsprite

dplc_Warp4:
		dc.w (15<<12)+884
	.end:
frame_Run31:
		spritemap
		piece -15, -12, 2x3, 0
		piece 0, -11, 3x4, 6
		endsprite

dplc_Run31:
		dc.w (5<<12)+900
		dc.w (11<<12)+906
	.end:
frame_Run32:
		spritemap
		piece -16, -12, 2x3, 0
		piece 0, -10, 3x4, 6
		endsprite

dplc_Run32:
		dc.w (5<<12)+918
		dc.w (11<<12)+924
	.end:
frame_Stop1:
		spritemap
		piece -14, -16, 3x4, 0
		piece 10, -2, 1x3, 12
		piece 2, 16, 1x1, 15
		endsprite

dplc_Stop1:
		dc.w (11<<12)+936
		dc.w (2<<12)+948
		dc.w (0<<12)+951
	.end:
frame_Stop2:
		spritemap
		piece -13, -16, 3x4, 0
		piece 11, -2, 1x3, 12
		piece 3, 16, 1x1, 15
		piece -21, 4, 1x1, 16
		endsprite

dplc_Stop2:
		dc.w (11<<12)+952
		dc.w (2<<12)+964
		dc.w (0<<12)+967
		dc.w (0<<12)+968
	.end:
frame_Run33:
		spritemap
		piece -15, -12, 2x3, 0
		piece 0, -10, 3x4, 6
		endsprite

dplc_Run33:
		dc.w (5<<12)+969
		dc.w (11<<12)+975
	.end:
frame_Run34:
		spritemap
		piece -16, -12, 2x3, 0
		piece 0, -10, 3x4, 6
		endsprite

dplc_Run34:
		dc.w (5<<12)+987
		dc.w (11<<12)+993
	.end:
frame_Duck:
		spritemap
		piece -15, -6, 4x4, 0
		endsprite

dplc_Duck:
		dc.w (15<<12)+1005
	.end:
frame_Balance1:
		spritemap
		piece -32, -5, 4x3, 0
		piece -21, -20, 3x2, 12
		piece 0, 2, 1x1, 18
		piece -11, 19, 1x1, 19
		endsprite

dplc_Balance1:
		dc.w (11<<12)+1021
		dc.w (5<<12)+1033
		dc.w (0<<12)+1039
		dc.w (0<<12)+1040
	.end:
frame_Run41:
		spritemap
		piece -17, -14, 3x4, 0
		piece -2, -21, 2x1, 12
		piece 7, -17, 2x3, 14
		endsprite

dplc_Run41:
		dc.w (11<<12)+1041
		dc.w (1<<12)+1053
		dc.w (5<<12)+1055
	.end:
frame_Burnt:
		spritemap
		piece -14, -24, 4x4, 0
		piece -8, 8, 3x2, 16
		piece 18, -19, 1x1, 22
		endsprite

dplc_Burnt:
		dc.w (15<<12)+1061
		dc.w (5<<12)+1077
		dc.w (0<<12)+1083
	.end:
frame_Balance2:
		spritemap
		piece -30, -19, 4x4, 0
		piece 2, -11, 1x1, 16
		piece -16, 13, 2x1, 17
		endsprite

dplc_Balance2:
		dc.w (15<<12)+1084
		dc.w (0<<12)+1100
		dc.w (1<<12)+1101
	.end:
frame_Run42:
		spritemap
		piece -18, -12, 3x4, 0
		piece -2, -21, 3x1, 12
		piece 6, -13, 2x3, 15
		endsprite

dplc_Run42:
		dc.w (11<<12)+1103
		dc.w (2<<12)+1115
		dc.w (5<<12)+1118
	.end:
frame_Walk44:
		spritemap
		piece -21, -11, 2x4, 0
		piece -5, -11, 3x3, 8
		piece 19, -6, 1x1, 17
		piece -10, -19, 2x1, 18
		endsprite

dplc_Walk44:
		dc.w (7<<12)+1124
		dc.w (8<<12)+1132
		dc.w (0<<12)+1141
		dc.w (1<<12)+1142
	.end:
frame_Walk16:
		spritemap
		piece -13, -17, 4x2, 0
		piece -12, -1, 3x3, 8
		endsprite

dplc_Walk16:
		dc.w (7<<12)+1144
		dc.w (8<<12)+1152
	.end:
frame_Walk21:
		spritemap
		piece -19, -19, 4x3, 0
		piece -9, 5, 2x2, 12
		piece 13, -13, 1x2, 16
		piece -3, 21, 1x1, 18
		endsprite

dplc_Walk21:
		dc.w (11<<12)+1161
		dc.w (3<<12)+1173
		dc.w (1<<12)+1177
		dc.w (0<<12)+1179
	.end:
frame_Walk22:
		spritemap
		piece -18, -18, 4x3, 0
		piece 13, -5, 2x2, 12
		piece -7, 6, 2x1, 16
		piece -1, 14, 2x1, 18
		endsprite

dplc_Walk22:
		dc.w (11<<12)+1180
		dc.w (3<<12)+1192
		dc.w (1<<12)+1196
		dc.w (1<<12)+1198
	.end:
frame_Walk23:
		spritemap
		piece -15, -19, 3x2, 0
		piece -11, -3, 4x2, 6
		piece 1, 13, 2x1, 14
		endsprite

dplc_Walk23:
		dc.w (5<<12)+1200
		dc.w (7<<12)+1206
		dc.w (1<<12)+1214
	.end:
frame_Walk24:
		spritemap
		piece -17, -21, 3x1, 0
		piece -17, -13, 4x3, 3
		piece -11, 11, 2x2, 15
		piece 15, -11, 1x2, 19
		endsprite

dplc_Walk24:
		dc.w (2<<12)+1216
		dc.w (11<<12)+1219
		dc.w (3<<12)+1231
		dc.w (1<<12)+1235
	.end:
frame_Run12:
		spritemap
		piece -12, -16, 3x2, 0
		piece -19, 0, 4x3, 6
		endsprite

dplc_Run12:
		dc.w (5<<12)+1237
		dc.w (11<<12)+1243
	.end:
frame_Roll2:
		spritemap
		piece -16, -16, 4x4, 0
		endsprite

dplc_Roll2:
		dc.w (15<<12)+1255
	.end:
frame_Float4:
		spritemap
		piece -16, -11, 4x3, 0
		piece 16, -10, 2x3, 12
		endsprite

dplc_Float4:
		dc.w (11<<12)+1271
		dc.w (5<<12)+1283
	.end:
frame_Shrink2:
		spritemap
		piece -14, -18, 3x1, 0
		piece -14, -10, 4x4, 3
		endsprite

dplc_Shrink2:
		dc.w (2<<12)+1289
		dc.w (15<<12)+1292
	.end:
frame_Shrink1:
		spritemap
		piece -16, -20, 4x4, 0
		piece -10, 12, 3x1, 16
		endsprite

dplc_Shrink1:
		dc.w (15<<12)+1308
		dc.w (2<<12)+1324
	.end:
frame_Death:
		spritemap
		piece -14, -24, 4x4, 0
		piece -9, 8, 4x1, 16
		piece 18, -18, 1x1, 20
		piece -9, 16, 1x1, 21
		endsprite

dplc_Death:
		dc.w (15<<12)+1327
		dc.w (3<<12)+1343
		dc.w (0<<12)+1347
		dc.w (0<<12)+1348
	.end:
frame_Drown:
		spritemap
		piece -14, -21, 4x4, 0
		piece -9, 11, 4x1, 16
		piece 18, -18, 1x1, 20
		endsprite

dplc_Drown:
		dc.w (15<<12)+1349
		dc.w (3<<12)+1365
		dc.w (0<<12)+1369
	.end:
frame_Float1:
		spritemap
		piece -17, -12, 4x3, 0
		piece 15, -12, 2x3, 12
		endsprite

dplc_Float1:
		dc.w (11<<12)+1370
		dc.w (5<<12)+1382
	.end:
frame_Run43:
		spritemap
		piece -17, -10, 2x4, 0
		piece -3, -20, 2x4, 8
		piece 13, -18, 2x3, 16
		endsprite

dplc_Run43:
		dc.w (7<<12)+1388
		dc.w (7<<12)+1396
		dc.w (5<<12)+1404
	.end:
frame_Walk45:
		spritemap
		piece -20, -8, 2x3, 0
		piece -4, -12, 2x3, 6
		piece 12, -5, 1x1, 12
		piece -2, -19, 2x1, 13
		endsprite

dplc_Walk45:
		dc.w (5<<12)+1410
		dc.w (5<<12)+1416
		dc.w (0<<12)+1422
		dc.w (1<<12)+1423
	.end:
frame_Walk46:
		spritemap
		piece -17, -10, 1x3, 0
		piece -9, -10, 1x4, 3
		piece -2, -21, 3x3, 7
		piece -1, 3, 2x2, 16
		endsprite

dplc_Walk46:
		dc.w (2<<12)+1425
		dc.w (3<<12)+1428
		dc.w (8<<12)+1432
		dc.w (3<<12)+1441
	.end:
frame_Run11:
		spritemap
		piece -12, -15, 3x2, 0
		piece -19, 0, 4x3, 6
		endsprite

dplc_Run11:
		dc.w (5<<12)+1445
		dc.w (11<<12)+1451
	.end:
frame_Roll1:
		spritemap
		piece -16, -16, 4x4, 0
		endsprite

dplc_Roll1:
		dc.w (15<<12)+1463
	.end:
frame_Float3:
		spritemap
		piece -27, -12, 4x3, 0
		piece 5, -3, 1x2, 12
		endsprite

dplc_Float3:
		dc.w (11<<12)+1479
		dc.w (1<<12)+1491
	.end:
frame_Float2:
		spritemap
		piece -22, -12, 4x3, 0
		piece 10, -7, 2x2, 12
		endsprite

dplc_Float2:
		dc.w (11<<12)+1493
		dc.w (3<<12)+1505
	.end:
frame_Run44:
		spritemap
		piece -18, -12, 2x4, 0
		piece -2, -21, 3x4, 8
		endsprite

dplc_Run44:
		dc.w (7<<12)+1509
		dc.w (11<<12)+1517
	.end:
