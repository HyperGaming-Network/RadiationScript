------------------------------------------
--RadiationScript Animations
--HyperGamer.Net
--Made orginally by Rick, further developed by Last.Exile
------------------------------------------
AlwaysAimed = 
{
	"weapon_physgun",
	"weapon_physcannon",
	"weapon_frag",
	"weapon_slam",
	"weapon_rpg",
	"gmod_tool"
}

NeverAimed =
{
	"hands",
	"cloak"
}

UsableHolstered =
{
   "claws"
}

NPCAnim = { }

NPCAnim[1] = { }
NPCAnim[1].Anim = { }
NPCAnim[1].Models = 
{
			  "models/srp/masterduty.mdl",
	          "models/srp/masterfreedom.mdl",
	          "models/srp/mastermercenary.mdl",
	          "models/srp/mastermonolith.mdl",
	          "models/srp/masterstalker.mdl",
	          "models/srp/bandit1.mdl",
              "models/srp/bandit2.mdl",
              "models/srp/bandit3.mdl",
              "models/srp/bandit4.mdl",
              "models/srp/rookie1.mdl",
              "models/srp/rookie2.mdl",
              "models/srp/rookie3.mdl",
              "models/srp/rookie4.mdl",
			  "models/srp/rookie5.mdl",
              "models/srp/rookie6.mdl",
              "models/srp/rookie7.mdl",
              "models/srp/rookie8.mdl",
			  "models/srp/rookie9.mdl",
			  "models/srp/stalker_bandit_veteran",
			  "models/srp/stalker_bandit_veteran2",
			  "models/srp/stalker_hood.mdl",
			  "models/srp/stalker_hood_duty.mdl",
			  "models/srp/stalker_hood_ecologist.mdl",
			  "models/srp/stalker_hood_monolith.mdl",
			  "models/srp/stalker_hood_svob",
			  "models/srp/stalker_hood_kontroler",
			  "models/srp/stalker_mili.mdl",
			  "models/srp/specnaz.mdl",
              "models/srp/bio_suit.mdl",
			  "models/srp/trader.mdl",
              "models/duty/bullet.mdl",
              "models/freedom/cap.mdl",
			  "models/freedom/exofreedom.mdl",
		      "models/freedom/freedom.mdl",
		      "models/freedom/lukash.mdl",
			  "models/srpmodels/loner1.mdl",
		      "models/srpmodels/loner2.mdl",
			  "models/srpmodels/loner3.mdl",
		      "models/stalker/bandit.mdl",
		      "models/stalker/monolith.mdl",
		      "models/monk.mdl"	 
}

NPCAnim[1].Anim["idle"] = 1
NPCAnim[1].Anim["sprint"] = 12
NPCAnim[1].Anim["walk"] = 6
NPCAnim[1].Anim["run"] = 10
NPCAnim[1].Anim["glide"] = 27
NPCAnim[1].Anim["crouch"] = "crouchidlehide"
NPCAnim[1].Anim["crouchwalk"] = 8
 
NPCAnim[1].Anim["sit"] = "drive_jeep"
NPCAnim[1].Anim["sitfloor"] = 373
NPCAnim[1].Anim["sitchair"] = 376
NPCAnim[1].Anim["leaningleft"] = 368
NPCAnim[1].Anim["leanback"] = 372
NPCAnim[1].Anim["wave"] = 77
NPCAnim[1].Anim["sleep"] = 112
NPCAnim[1].Anim["putinv1"] = 196
NPCAnim[1].Anim["putinv2"] = 197
 
NPCAnim[1].Anim["pistolidle"] = 1 --
NPCAnim[1].Anim["pistolrun"] = 10 --
NPCAnim[1].Anim["pistolwalk"] = 6 --*
NPCAnim[1].Anim["pistolcrouchwalk"] = 8
NPCAnim[1].Anim["pistolcrouch"] = 5 --*
NPCAnim[1].Anim["pistolaimcrouch"] = 266 --*
NPCAnim[1].Anim["pistolaimcrouchwalk"] = 342 --*
NPCAnim[1].Anim["pistolaimidle"] = 317 --
NPCAnim[1].Anim["pistolaimwalk"] = 318 --
NPCAnim[1].Anim["pistolaimrun"] = 319 --*
NPCAnim[1].Anim["pistolreload"] = 359 --*
NPCAnim[1].Anim["pistolfire"] = 289
 
NPCAnim[1].Anim["smgidle"] = 330 --
NPCAnim[1].Anim["smgrun"] = 314 --
NPCAnim[1].Anim["smgwalk"] = 313 --
NPCAnim[1].Anim["smgaimidle"] = 317 --
NPCAnim[1].Anim["smgaimwalk"] = 318 --
NPCAnim[1].Anim["smgcrouchwalk"] = 341 --
NPCAnim[1].Anim["smgcrouch"] = 360 --
NPCAnim[1].Anim["smgaimcrouch"] = 266--
NPCAnim[1].Anim["smgaimcrouchwalk"] = 342--
NPCAnim[1].Anim["smgaimrun"] = 319 --
NPCAnim[1].Anim["smgreload"] = 310 --*
NPCAnim[1].Anim["smgfire"] = 289 --
 
NPCAnim[1].Anim["ar2idle"] = 330 --
NPCAnim[1].Anim["ar2run"] = 1341 --
NPCAnim[1].Anim["ar2walk"] = 1340 --*
NPCAnim[1].Anim["ar2aimidle"] = 1331 --
NPCAnim[1].Anim["ar2aimwalk"] = 1336 --
NPCAnim[1].Anim["ar2crouchwalk"] = 335
NPCAnim[1].Anim["ar2crouch"] = 332 --*
NPCAnim[1].Anim["ar2aimcrouch"] = 266 --*
NPCAnim[1].Anim["ar2aimcrouchwalk"] = 342 --*
NPCAnim[1].Anim["ar2aimrun"] = 336 --*
NPCAnim[1].Anim["ar2reload"] = 310 --*
NPCAnim[1].Anim["ar2fire"] = 289
 
NPCAnim[1].Anim["shotgunidle"] = 320 --
NPCAnim[1].Anim["shotgunwalk"] = 307 --
NPCAnim[1].Anim["shotgunrun"] = 310 --
NPCAnim[1].Anim["shotgunaimidle"] = 1330 --
NPCAnim[1].Anim["shotgunaimwalk"] = 336
NPCAnim[1].Anim["shotgunaimrun"] = 367 --
NPCAnim[1].Anim["shotguncrouchwalk"] = 8
NPCAnim[1].Anim["shotguncrouch"] = 342 --
NPCAnim[1].Anim["shotgunaimcrouch"] = 341 --
NPCAnim[1].Anim["shotgunaimcrouchwalk"] = 373 --
NPCAnim[1].Anim["shotgunreload"] = 310 --
NPCAnim[1].Anim["shotgunfire"] = 288
 
NPCAnim[1].Anim["crossbowidle"] = 316
NPCAnim[1].Anim["crossbowwalk"] = 309
NPCAnim[1].Anim["crossbowrun"] = 310
NPCAnim[1].Anim["crossbowaimidle"] = 256
NPCAnim[1].Anim["crossbowaimwalk"] = 336
NPCAnim[1].Anim["crossbowaimrun"] = 340
NPCAnim[1].Anim["crossbowcrouchwalk"] = 8
NPCAnim[1].Anim["crossbowcrouch"] = 5
NPCAnim[1].Anim["crossbowaimcrouch"] = 275
NPCAnim[1].Anim["crossbowaimcrouchwalk"] = 338
NPCAnim[1].Anim["crossbowreload"] = 359
NPCAnim[1].Anim["crossbowfire"] = 288
 
NPCAnim[1].Anim["meleeidle"] = 1
NPCAnim[1].Anim["meleewalk"] = 6
NPCAnim[1].Anim["meleerun"] = 10
NPCAnim[1].Anim["meleeaimidle"] = 328
NPCAnim[1].Anim["meleeaimcrouchwalk"] = 8
NPCAnim[1].Anim["meleeaimcrouch"] = 5
NPCAnim[1].Anim["meleecrouchwalk"] = 8
NPCAnim[1].Anim["meleecrouch"] = 5
NPCAnim[1].Anim["meleeaimwalk"] = 6
NPCAnim[1].Anim["meleeaimrun"] = 10
NPCAnim[1].Anim["meleefire"] = "swing"
 
NPCAnim[1].Anim["rpgidle"] = 316
NPCAnim[1].Anim["rpgwalk"] = 309
NPCAnim[1].Anim["rpgrun"] = 310
NPCAnim[1].Anim["rpgaimidle"] = 327
NPCAnim[1].Anim["rpgaimwalk"] = 336
NPCAnim[1].Anim["rpgaimrun"] = 340
NPCAnim[1].Anim["rpgcrouchwalk"] = 8
NPCAnim[1].Anim["rpgcrouch"] = 5
NPCAnim[1].Anim["rpgaimcrouch"] = 275
NPCAnim[1].Anim["rpgaimcrouchwalk"] = 338
NPCAnim[1].Anim["rpgfire"] = 272
 
NPCAnim[1].Anim["grenadeidle"] = 1
NPCAnim[1].Anim["grenadewalk"] = 6
NPCAnim[1].Anim["grenaderun"] = 10
NPCAnim[1].Anim["grenadeaimidle"] = 1
NPCAnim[1].Anim["grenadeaimcrouchwalk"] = 8
NPCAnim[1].Anim["grenadeaimcrouch"] = 5
NPCAnim[1].Anim["grenadecrouchwalk"] = 8
NPCAnim[1].Anim["grenadecrouch"] = 5
NPCAnim[1].Anim["grenadeaimwalk"] = 6
NPCAnim[1].Anim["grenadeaimrun"] = 10
NPCAnim[1].Anim["grenadefire"] = 273
 
NPCAnim[1].Anim["slamidle"] = 1
NPCAnim[1].Anim["slamwalk"] = 6
NPCAnim[1].Anim["slamrun"] = 10
NPCAnim[1].Anim["slamaimidle"] = 1
NPCAnim[1].Anim["slamaimcrouchwalk"] = 8
NPCAnim[1].Anim["slamaimcrouch"] = 5
NPCAnim[1].Anim["slamcrouchwalk"] = 8
NPCAnim[1].Anim["slamcrouch"] = 5
NPCAnim[1].Anim["slamaimwalk"] = 6
NPCAnim[1].Anim["slamaimrun"] = 10
NPCAnim[1].Anim["slamfire"] = 273
 
NPCAnim[1].Anim["physgunidle"] = 301
NPCAnim[1].Anim["physgunwalk"] = 336
NPCAnim[1].Anim["physgunrun"] = 340
NPCAnim[1].Anim["physgunaimidle"] = 302
NPCAnim[1].Anim["physgunaimwalk"] = 340
NPCAnim[1].Anim["physgunaimrun"] = 340
NPCAnim[1].Anim["physgunaimcrouchwalk"] = 341
NPCAnim[1].Anim["physgunaimcrouch"] = 5

NPCAnim[2] = { }
NPCAnim[2].Anim = { }
NPCAnim[2].Models = 
{
"models/player/slow/amberlyn/re5/dog/slow.mdl"
}

NPCAnim[2].Anim["idle"] = "Idle_Lower"
NPCAnim[2].Anim["walk"] = "Walk_lower"
NPCAnim[2].Anim["run"] = "Run_lower"
NPCAnim[2].Anim["glide"] = "Jump"
NPCAnim[2].Anim["sprint"] = "Run_lower"
NPCAnim[2].Anim["sit"] = "Crouch_Idle_Lower"
NPCAnim[2].Anim["crouch"] = "Crouch_Idle_Lower"
NPCAnim[2].Anim["crouchwalk"] = "Crouch_Walk_lower"
 
NPCAnim[2].Anim["pistolidle"] = 1
NPCAnim[2].Anim["pistolwalk"] = 6
NPCAnim[2].Anim["pistolrun"] = 10
NPCAnim[2].Anim["pistolcrouchwalk"] = 8
NPCAnim[2].Anim["pistolcrouch"] = 5
NPCAnim[2].Anim["pistolaimidle"] = 21
NPCAnim[2].Anim["pistolaimwalk"] = 346
NPCAnim[2].Anim["pistolaimrun"] = 347
NPCAnim[2].Anim["pistolaimcrouch"] = 51
NPCAnim[2].Anim["pistolaimcrouchwalk"] = 62
NPCAnim[2].Anim["pistolreload"] = 101
NPCAnim[2].Anim["pistolfire"] = 285
 
NPCAnim[2].Anim["smgidle"] = 301; --
NPCAnim[2].Anim["smgrun"] = 338; --
NPCAnim[2].Anim["smgwalk"] = 337; --
NPCAnim[2].Anim["smgaimidle"] = 317; --
NPCAnim[2].Anim["smgaimwalk"] = 318; --
NPCAnim[2].Anim["smgcrouchwalk"] = 341; --
NPCAnim[2].Anim["smgcrouch"] = 332; --
NPCAnim[2].Anim["smgaimcrouch"] = 279; --
NPCAnim[2].Anim["smgaimcrouchwalk"] = 335; --
NPCAnim[2].Anim["smgreload"] = 359
NPCAnim[2].Anim["smgfire"] = 289
 
NPCAnim[2].Anim["ar2idle"] = 307
NPCAnim[2].Anim["ar2walk"] = 309
NPCAnim[2].Anim["ar2run"] = 310
NPCAnim[2].Anim["ar2aimidle"] = 256
NPCAnim[2].Anim["ar2aimwalk"] = 336
NPCAnim[2].Anim["ar2aimrun"] = 340
NPCAnim[2].Anim["ar2crouchwalk"] = 8
NPCAnim[2].Anim["ar2crouch"] = 332
NPCAnim[2].Anim["ar2aimcrouch"] = 275
NPCAnim[2].Anim["ar2aimcrouchwalk"] = 338
NPCAnim[2].Anim["ar2reload"] = 359
NPCAnim[2].Anim["ar2fire"] = 281
 
NPCAnim[2].Anim["shotgunidle"] = 321
NPCAnim[2].Anim["shotgunwalk"] = 309
NPCAnim[2].Anim["shotgunrun"] = 310
NPCAnim[2].Anim["shotgunaimidle"] = 22
NPCAnim[2].Anim["shotgunaimwalk"] = 336
NPCAnim[2].Anim["shotgunaimrun"] = 340
NPCAnim[2].Anim["shotguncrouchwalk"] = 8
NPCAnim[2].Anim["shotguncrouch"] = 5
NPCAnim[2].Anim["shotgunaimcrouch"] = 275
NPCAnim[2].Anim["shotgunaimcrouchwalk"] = 338
NPCAnim[2].Anim["shotgunreload"] = 359
NPCAnim[2].Anim["shotgunfire"] = 288
 
NPCAnim[2].Anim["crossbowidle"] = 316
NPCAnim[2].Anim["crossbowwalk"] = 309
NPCAnim[2].Anim["crossbowrun"] = 310
NPCAnim[2].Anim["crossbowaimidle"] = 256
NPCAnim[2].Anim["crossbowaimwalk"] = 336
NPCAnim[2].Anim["crossbowaimrun"] = 340
NPCAnim[2].Anim["crossbowcrouchwalk"] = 8
NPCAnim[2].Anim["crossbowcrouch"] = 5
NPCAnim[2].Anim["crossbowaimcrouch"] = 275
NPCAnim[2].Anim["crossbowaimcrouchwalk"] = 338
NPCAnim[2].Anim["crossbowreload"] = 359
NPCAnim[2].Anim["crossbowfire"] = 288
 
NPCAnim[2].Anim["meleeidle"] = "Idle_lower"
NPCAnim[2].Anim["meleewalk"] = "Walk_Upper_KNIFE"
NPCAnim[2].Anim["meleerun"] = "Run_lower"
NPCAnim[2].Anim["meleeaimidle"] = "Idle_lower"
NPCAnim[2].Anim["meleeaimcrouchwalk"] = "Crouch_Walk_lower"
NPCAnim[2].Anim["meleeaimcrouch"] = "Crouch_Idle_Lower"
NPCAnim[2].Anim["meleecrouchwalk"] = "Crouch_Walk_lower"
NPCAnim[2].Anim["meleecrouch"] = "Crouch_Idle_Lower"
NPCAnim[2].Anim["meleeaimwalk"] = "Crouch_Walk_lower"
NPCAnim[2].Anim["meleeaimrun"] = "Run_lower"
NPCAnim[2].Anim["meleefire"] = "ACT_Idle_Shoot_KNIFE"
 
NPCAnim[2].Anim["rpgidle"] = 316
NPCAnim[2].Anim["rpgwalk"] = 309
NPCAnim[2].Anim["rpgrun"] = 310
NPCAnim[2].Anim["rpgaimidle"] = 327
NPCAnim[2].Anim["rpgaimwalk"] = 336
NPCAnim[2].Anim["rpgaimrun"] = 340
NPCAnim[2].Anim["rpgcrouchwalk"] = 8
NPCAnim[2].Anim["rpgcrouch"] = 5
NPCAnim[2].Anim["rpgaimcrouch"] = 275
NPCAnim[2].Anim["rpgaimcrouchwalk"] = 338
NPCAnim[2].Anim["rpgfire"] = 272
 
NPCAnim[2].Anim["grenadeidle"] = 1
NPCAnim[2].Anim["grenadewalk"] = 6
NPCAnim[2].Anim["grenaderun"] = 10
NPCAnim[2].Anim["grenadeaimidle"] = 1
NPCAnim[2].Anim["grenadeaimcrouchwalk"] = 8
NPCAnim[2].Anim["grenadeaimcrouch"] = 5
NPCAnim[2].Anim["grenadecrouchwalk"] = 8
NPCAnim[2].Anim["grenadecrouch"] = 5
NPCAnim[2].Anim["grenadeaimwalk"] = 6
NPCAnim[2].Anim["grenadeaimrun"] = 10
NPCAnim[2].Anim["grenadefire"] = 273
 
NPCAnim[2].Anim["slamidle"] = 1
NPCAnim[2].Anim["slamwalk"] = 6
NPCAnim[2].Anim["slamrun"] = 10
NPCAnim[2].Anim["slamaimidle"] = 1
NPCAnim[2].Anim["slamaimcrouchwalk"] = 8
NPCAnim[2].Anim["slamaimcrouch"] = 5
NPCAnim[2].Anim["slamcrouchwalk"] = 8
NPCAnim[2].Anim["slamcrouch"] = 5
NPCAnim[2].Anim["slamaimwalk"] = 6
NPCAnim[2].Anim["slamaimrun"] = 10
NPCAnim[2].Anim["slamfire"] = 273
 
NPCAnim[2].Anim["physgunidle"] = 256
NPCAnim[2].Anim["physgunwalk"] = 336
NPCAnim[2].Anim["physgunrun"] = 340
NPCAnim[2].Anim["physgunaimidle"] = 256
NPCAnim[2].Anim["physgunaimwalk"] = 336
NPCAnim[2].Anim["physgunaimrun"] = 340
NPCAnim[2].Anim["physgunaimcrouchwalk"] = 338
NPCAnim[2].Anim["physgunaimcrouch"] = 275

NPCAnim[3] = { }
NPCAnim[3].Anim = { }
NPCAnim[3].Models =
{
	"models/policc.mdl",
	"models/police.mdl"
}

NPCAnim[3].Anim["idle"] = 1
NPCAnim[3].Anim["walk"] = 6
NPCAnim[3].Anim["run"] = 10
NPCAnim[3].Anim["glide"] = 27
NPCAnim[3].Anim["sit"] = 60
NPCAnim[3].Anim["leaning"] = 60
NPCAnim[3].Anim["crouch"] = 60
NPCAnim[3].Anim["crouchwalk"] = 8

NPCAnim[3].Anim["pistolidle"] = 1
NPCAnim[3].Anim["pistolwalk"] = 6
NPCAnim[3].Anim["pistolrun"] = 10
NPCAnim[3].Anim["pistolcrouchwalk"] = 8
NPCAnim[3].Anim["pistolcrouch"] = 60
NPCAnim[3].Anim["pistolaimidle"] = 304
NPCAnim[3].Anim["pistolaimwalk"] = 352
NPCAnim[3].Anim["pistolaimrun"] = 353
NPCAnim[3].Anim["pistolaimcrouch"] = 60
NPCAnim[3].Anim["pistolaimcrouchwalk"] = 8
NPCAnim[3].Anim["pistolreload"] = 359
NPCAnim[3].Anim["pistolfire"] = 285

NPCAnim[3].Anim["smgidle"] = 301
NPCAnim[3].Anim["smgrun"] = 10
NPCAnim[3].Anim["smgwalk"] = 6
NPCAnim[3].Anim["smgaimidle"] = 302
NPCAnim[3].Anim["smgaimwalk"] = 340
NPCAnim[3].Anim["smgcrouchwalk"] = 8
NPCAnim[3].Anim["smgcrouch"] = 60
NPCAnim[3].Anim["smgaimcrouch"] = 60
NPCAnim[3].Anim["smgaimcrouchwalk"] = 8
NPCAnim[3].Anim["smgaimrun"] = 351
NPCAnim[3].Anim["smgreload"] = 365
NPCAnim[3].Anim["smgfire"] = 289

NPCAnim[3].Anim["ar2idle"] = 301
NPCAnim[3].Anim["ar2walk"] = 6
NPCAnim[3].Anim["ar2run"] = 10
NPCAnim[3].Anim["ar2aimidle"] = 302
NPCAnim[3].Anim["ar2aimwalk"] = 340
NPCAnim[3].Anim["ar2aimrun"] = 351
NPCAnim[3].Anim["ar2crouchwalk"] = 8
NPCAnim[3].Anim["ar2crouch"] = 60
NPCAnim[3].Anim["ar2aimcrouch"] = 60
NPCAnim[3].Anim["ar2aimcrouchwalk"] = 8
NPCAnim[3].Anim["ar2reload"] = 359
NPCAnim[3].Anim["ar2fire"] = 281

NPCAnim[3].Anim["shotgunidle"] = 301
NPCAnim[3].Anim["shotgunwalk"] = 6
NPCAnim[3].Anim["shotgunrun"] = 10
NPCAnim[3].Anim["shotgunaimidle"] = 302
NPCAnim[3].Anim["shotgunaimwalk"] = 340
NPCAnim[3].Anim["shotgunaimrun"] = 351
NPCAnim[3].Anim["shotguncrouchwalk"] = 8
NPCAnim[3].Anim["shotguncrouch"] = 60
NPCAnim[3].Anim["shotgunaimcrouch"] = 60
NPCAnim[3].Anim["shotgunaimcrouchwalk"] = 8
NPCAnim[3].Anim["shotgunreload"] = 359
NPCAnim[3].Anim["shotgunfire"] = 281

NPCAnim[3].Anim["crossbowidle"] = 301
NPCAnim[3].Anim["crossbowwalk"] = 6
NPCAnim[3].Anim["crossbowrun"] = 10
NPCAnim[3].Anim["crossbowaimidle"] = 302
NPCAnim[3].Anim["crossbowaimwalk"] = 340
NPCAnim[3].Anim["crossbowaimrun"] = 351
NPCAnim[3].Anim["crossbowcrouchwalk"] = 8
NPCAnim[3].Anim["crossbowcrouch"] = 60
NPCAnim[3].Anim["crossbowaimcrouch"] = 60
NPCAnim[3].Anim["crossbowaimcrouchwalk"] = 8
NPCAnim[3].Anim["crossbowreload"] = 359
NPCAnim[3].Anim["crossbowfire"] = 288

NPCAnim[3].Anim["meleeidle"] = 1
NPCAnim[3].Anim["meleewalk"] = 6
NPCAnim[3].Anim["meleerun"] = 10
NPCAnim[3].Anim["meleeaimidle"] = 328
NPCAnim[3].Anim["meleeaimcrouchwalk"] = 8
NPCAnim[3].Anim["meleeaimcrouch"] = 60
NPCAnim[3].Anim["meleecrouchwalk"] = 8
NPCAnim[3].Anim["meleecrouch"] = 60
NPCAnim[3].Anim["meleeaimwalk"] = 6
NPCAnim[3].Anim["meleeaimrun"] = 10
NPCAnim[3].Anim["meleefire"] = 277

NPCAnim[3].Anim["rpgidle"] = 301
NPCAnim[3].Anim["rpgwalk"] = 6
NPCAnim[3].Anim["rpgrun"] = 10
NPCAnim[3].Anim["rpgaimidle"] = 302
NPCAnim[3].Anim["rpgaimwalk"] = 340
NPCAnim[3].Anim["rpgaimrun"] = 351
NPCAnim[3].Anim["rpgcrouchwalk"] = 8
NPCAnim[3].Anim["rpgcrouch"] = 60
NPCAnim[3].Anim["rpgaimcrouch"] = 60
NPCAnim[3].Anim["rpgaimcrouchwalk"] = 8
NPCAnim[3].Anim["rpgreload"] = 359
NPCAnim[3].Anim["rpgfire"] = 281

NPCAnim[3].Anim["grenadeidle"] = 1
NPCAnim[3].Anim["grenadewalk"] = 6
NPCAnim[3].Anim["grenaderun"] = 10
NPCAnim[3].Anim["grenadeaimidle"] = 1
NPCAnim[3].Anim["grenadeaimcrouchwalk"] = 8
NPCAnim[3].Anim["grenadeaimcrouch"] = 60
NPCAnim[3].Anim["grenadecrouchwalk"] = 8
NPCAnim[3].Anim["grenadecrouch"] = 60
NPCAnim[3].Anim["grenadeaimwalk"] = 6
NPCAnim[3].Anim["grenadeaimrun"] = 10
NPCAnim[3].Anim["grenadefire"] = 277

NPCAnim[3].Anim["slamidle"] = 1
NPCAnim[3].Anim["slamwalk"] = 6
NPCAnim[3].Anim["slamrun"] = 10
NPCAnim[3].Anim["slamaimidle"] = 1
NPCAnim[3].Anim["slamaimcrouchwalk"] = 8
NPCAnim[3].Anim["slamaimcrouch"] = 278
NPCAnim[3].Anim["slamcrouchwalk"] = 8
NPCAnim[3].Anim["slamcrouch"] = 278
NPCAnim[3].Anim["slamaimwalk"] = 6
NPCAnim[3].Anim["slamaimrun"] = 10
NPCAnim[3].Anim["slamfire"] = 273

NPCAnim[3].Anim["physgunidle"] = 301
NPCAnim[3].Anim["physgunwalk"] = 6
NPCAnim[3].Anim["physgunrun"] = 10
NPCAnim[3].Anim["physgunaimidle"] = 302
NPCAnim[3].Anim["physgunaimwalk"] = 340
NPCAnim[3].Anim["physgunaimrun"] = 351
NPCAnim[3].Anim["physgunaimcrouchwalk"] = 8
NPCAnim[3].Anim["physgunaimcrouch"] = 60

NPCAnim[4] = { }
NPCAnim[4].Anim = { }
NPCAnim[4].Models =
{
			  "models/srp/Blood_Sucker.mdl",
			  "models/srp/Blood_Sucker2.mdl"
}

NPCAnim[4].Anim["idle"] = "scaredidle"
NPCAnim[4].Anim["walk"] = "walk_all"
NPCAnim[4].Anim["run"] = "run_all"
NPCAnim[4].Anim["sprint"] = "run_all"
NPCAnim[4].Anim["glide"] = 27
NPCAnim[4].Anim["sit"] = 0
NPCAnim[4].Anim["crouch"] = "crouchidlehide"
NPCAnim[4].Anim["crouchwalk"] = "Crouch_walk_all"

NPCAnim[4].Anim["pistolidle"] = 1
NPCAnim[4].Anim["pistolwalk"] = 339
NPCAnim[4].Anim["pistolrun"] = 343
NPCAnim[4].Anim["pistolcrouchwalk"] = 8
NPCAnim[4].Anim["pistolcrouch"] = 5
NPCAnim[4].Anim["pistolaimidle"] = 317
NPCAnim[4].Anim["pistolaimwalk"] = 318
NPCAnim[4].Anim["pistolaimrun"] = 319
NPCAnim[4].Anim["pistolaimcrouch"] = 266
NPCAnim[4].Anim["pistolaimcrouchwalk"] = 342
NPCAnim[4].Anim["pistolreload"] = 359
NPCAnim[4].Anim["pistolfire"] = 289

NPCAnim[4].Anim["smgidle"] = 330
NPCAnim[4].Anim["smgrun"] = 314
NPCAnim[4].Anim["smgwalk"] = 313
NPCAnim[4].Anim["smgaimidle"] = 317
NPCAnim[4].Anim["smgaimwalk"] = 318
NPCAnim[4].Anim["smgcrouchwalk"] = 341
NPCAnim[4].Anim["smgcrouch"] = 360
NPCAnim[4].Anim["smgaimcrouch"] = 266
NPCAnim[4].Anim["smgaimcrouchwalk"] = 342
NPCAnim[4].Anim["smgaimrun"] = 319
NPCAnim[4].Anim["smgreload"] = 310
NPCAnim[4].Anim["smgfire"] = 289

NPCAnim[4].Anim["ar2idle"] = 1
NPCAnim[4].Anim["ar2walk"] = 339
NPCAnim[4].Anim["ar2run"] = 343
NPCAnim[4].Anim["ar2aimidle"] = 302
NPCAnim[4].Anim["ar2aimwalk"] = 340
NPCAnim[4].Anim["ar2aimrun"] = 344
NPCAnim[4].Anim["ar2crouchwalk"] = 341
NPCAnim[4].Anim["ar2crouch"] = 5
NPCAnim[4].Anim["ar2aimcrouch"] = 5
NPCAnim[4].Anim["ar2aimcrouchwalk"] = 341
NPCAnim[4].Anim["ar2reload"] = 66
NPCAnim[4].Anim["ar2fire"] = 416

NPCAnim[4].Anim["shotgunidle"] = 1
NPCAnim[4].Anim["shotgunwalk"] = 339
NPCAnim[4].Anim["shotgunrun"] = 343
NPCAnim[4].Anim["shotgunaimidle"] = 302
NPCAnim[4].Anim["shotgunaimwalk"] = 340
NPCAnim[4].Anim["shotgunaimrun"] = 344
NPCAnim[4].Anim["shotguncrouchwalk"] = 341
NPCAnim[4].Anim["shotguncrouch"] = 5
NPCAnim[4].Anim["shotgunaimcrouch"] = 5
NPCAnim[4].Anim["shotgunaimcrouchwalk"] = 341
NPCAnim[4].Anim["shotgunreload"] = 359
NPCAnim[4].Anim["shotgunfire"] = 281

NPCAnim[4].Anim["crossbowidle"] = 1
NPCAnim[4].Anim["crossbowwalk"] = 339
NPCAnim[4].Anim["crossbowrun"] = 343
NPCAnim[4].Anim["crossbowaimidle"] = 302
NPCAnim[4].Anim["crossbowaimwalk"] = 340
NPCAnim[4].Anim["crossbowaimrun"] = 344
NPCAnim[4].Anim["crossbowcrouchwalk"] = 341
NPCAnim[4].Anim["crossbowcrouch"] = 5
NPCAnim[4].Anim["crossbowaimcrouch"] = 5
NPCAnim[4].Anim["crossbowaimcrouchwalk"] = 341
NPCAnim[4].Anim["crossbowreload"] = 359
NPCAnim[4].Anim["crossbowfire"] = 281

NPCAnim[4].Anim["meleeidle"] = "scaredidle"
NPCAnim[4].Anim["meleewalk"] = "walk_all"
NPCAnim[4].Anim["meleerun"] = "run_all"
NPCAnim[4].Anim["meleeaimidle"] = 302
NPCAnim[4].Anim["meleeaimcrouchwalk"] = 341
NPCAnim[4].Anim["meleeaimcrouch"] = 5
NPCAnim[4].Anim["meleecrouchwalk"] = "Crouch_walk_all"
NPCAnim[4].Anim["meleecrouch"] = "crouchidlehide"
NPCAnim[4].Anim["meleeaimwalk"] = "walk_all"
NPCAnim[4].Anim["meleeaimrun"] = "run_all"
NPCAnim[4].Anim["meleefire"] = "ACT_MELEE_ATTACK_SWING"

NPCAnim[4].Anim["rpgidle"] = 1
NPCAnim[4].Anim["rpgwalk"] = 339
NPCAnim[4].Anim["rpgrun"] = 343
NPCAnim[4].Anim["rpgaimidle"] = 302
NPCAnim[4].Anim["rpgaimwalk"] = 340
NPCAnim[4].Anim["rpgaimrun"] = 344
NPCAnim[4].Anim["rpgcrouchwalk"] = 341
NPCAnim[4].Anim["rpgcrouch"] = 5
NPCAnim[4].Anim["rpgaimcrouch"] = 5
NPCAnim[4].Anim["rpgaimcrouchwalk"] = 341
NPCAnim[4].Anim["rpgreload"] = 359
NPCAnim[4].Anim["rpgfire"] = 281

NPCAnim[4].Anim["grenadeidle"] = 1
NPCAnim[4].Anim["grenadewalk"] = 335
NPCAnim[4].Anim["grenaderun"] = 339
NPCAnim[4].Anim["grenadeaimidle"] = 1
NPCAnim[4].Anim["grenadeaimcrouchwalk"] = 337
NPCAnim[4].Anim["grenadeaimcrouch"] = 5
NPCAnim[4].Anim["grenadecrouchwalk"] = 337
NPCAnim[4].Anim["grenadecrouch"] = 5
NPCAnim[4].Anim["grenadeaimwalk"] = 336
NPCAnim[4].Anim["grenadeaimrun"] = 340
NPCAnim[4].Anim["grenadefire"] = 355

NPCAnim[4].Anim["slamidle"] = 1
NPCAnim[4].Anim["slamwalk"] = 335
NPCAnim[4].Anim["slamrun"] = 339
NPCAnim[4].Anim["slamaimidle"] = 1
NPCAnim[4].Anim["slamaimcrouchwalk"] = 337
NPCAnim[4].Anim["slamaimcrouch"] = 5
NPCAnim[4].Anim["slamcrouchwalk"] = 337
NPCAnim[4].Anim["slamcrouch"] = 5
NPCAnim[4].Anim["slamaimwalk"] = 336
NPCAnim[4].Anim["slamaimrun"] = 339
NPCAnim[4].Anim["slamfire"] = 281

NPCAnim[4].Anim["physgunidle"] = 1
NPCAnim[4].Anim["physgunwalk"] = 339
NPCAnim[4].Anim["physgunrun"] = 343
NPCAnim[4].Anim["physgunaimidle"] = 302
NPCAnim[4].Anim["physgunaimwalk"] = 340
NPCAnim[4].Anim["physgunaimrun"] = 344
NPCAnim[4].Anim["physgunaimcrouchwalk"] = 341
NPCAnim[4].Anim["physgunaimcrouch"] = 5

WeapActivityTranslate = { }

WeapActivityTranslate[ACT_HL2MP_IDLE_PISTOL] = "pistol";
WeapActivityTranslate[ACT_HL2MP_IDLE_SMG1] = "smg";
WeapActivityTranslate[ACT_HL2MP_IDLE_AR2] = "ar2";
WeapActivityTranslate[ACT_HL2MP_IDLE_RPG] = "rpg";
WeapActivityTranslate[ACT_HL2MP_IDLE_GRENADE] = "grenade";
WeapActivityTranslate[ACT_HL2MP_IDLE_SHOTGUN] = "shotgun";
WeapActivityTranslate[ACT_HL2MP_IDLE_PHYSGUN] = "physgun";
WeapActivityTranslate[ACT_HL2MP_IDLE_CROSSBOW] = "crossbow";
WeapActivityTranslate[ACT_HL2MP_IDLE_SLAM] = "slam";
WeapActivityTranslate[ACT_HL2MP_IDLE_MELEE] = "melee";
WeapActivityTranslate[ACT_HL2MP_IDLE] = "";
WeapActivityTranslate["weapon_pistol"] = "pistol";
WeapActivityTranslate["weapon_357"] = "pistol";
WeapActivityTranslate["gmod_tool"] = "pistol";
WeapActivityTranslate["weapon_smg1"] = "smg";
WeapActivityTranslate["weapon_ar2"] = "ar2";
WeapActivityTranslate["weapon_rpg"] = "rpg";
WeapActivityTranslate["weapon_frag"] = "grenade";
WeapActivityTranslate["weapon_slam"] = "slam";
WeapActivityTranslate["weapon_physgun"] = "physgun";
WeapActivityTranslate["weapon_physcannon"] = "physgun";
WeapActivityTranslate["weapon_crossbow"] = "crossbow";
WeapActivityTranslate["weapon_shotgun"] = "shotgun";
WeapActivityTranslate["weapon_crowbar"] = "melee";
WeapActivityTranslate["weapon_stunstick"] = "melee";
WeapActivityTranslate["claws"] = "melee";
WeapActivityTranslate["kabar"] = "melee";

for k, v in pairs( NPCAnim ) do

	if( v.Models ) then

		for n, m in pairs( v.Models ) do
		
			NPCAnim[k].Models[n] = string.lower( NPCAnim[k].Models[n] );
		
		end
		
	end

end

function GM:UpdateAnimation( ply, velocity, maxSeqGroundSpeed )

	ply:SetPlaybackRate( 1 );

end

local function GetWeaponAct( ply, act )

	local activeweap = ply:GetActiveWeapon();
	
	if( activeweap == NULL or not activeweap:IsValid() ) then
		return "";
	end

	local class = activeweap:GetClass();
	
	local trans = "";
	local posttrans = "";
	
	if( activeweap:GetNWBool( "NPCAimed" ) ) then
		posttrans = "aim";	
	else
		
		if( activeweap:GetTable().NotHolsterAnim ) then
		
			act = activeweap:GetTable().NotHolsterAnim;
		
		end
	
	end

	if( act ~= -1 ) then
		trans = WeapActivityTranslate[act];
	else
		trans = WeapActivityTranslate[class];
	end
	
	return trans .. posttrans or "";

end

local function FindEnumeration( actname )

	for k, v in pairs ( _E ) do
		if(  k == actname ) then
			return tonumber( v );
		end
	end
	
return -1;

end

local function GetNPCAnim( ply )

	local model = string.lower( ply:GetModel() );

	if( table.HasValue( NPCAnim[1].Models, model ) ) then return NPCAnim[1].Anim; end
	if( table.HasValue( NPCAnim[2].Models, model ) ) then return NPCAnim[2].Anim; end
	if( table.HasValue( NPCAnim[3].Models, model ) ) then return NPCAnim[3].Anim; end
	if( table.HasValue( NPCAnim[4].Models, model ) ) then return NPCAnim[4].Anim; end
	
	return NPCAnim[1].Anim;

end

function NPCAnim.SetPlayerAnimation( ply, weapanim )
	
	local act = "";
	local activeweap = ply:GetActiveWeapon(); 
	
	if( activeweap:IsValid() ) then
		act = GetWeaponAct( ply, ply:Weapon_TranslateActivity( ACT_HL2MP_IDLE ) or -1 );
	end
	local seqname = act;
	local crouch = "";


	if( ply:OnGround() and ply:KeyDown( IN_DUCK ) ) then
		crouch = "crouch";
	end
	
	if( ply:GetVelocity():Length() >= 1 and ply:KeyDown( IN_WALK ) ) then
		seqname = seqname .. crouch .. "walk";
	elseif( ply:GetVelocity():Length() >= 1 and !ply:KeyDown( IN_DUCK )) then
		seqname = seqname .. crouch .. "run";
	elseif( ply:GetVelocity():Length() >= 1 and ply:KeyDown( IN_DUCK ))  then
		seqname = seqname .. crouch .. "walk";

	else
		
		if( crouch == "crouch" ) then
			seqname = seqname .. crouch;
		else
			seqname = seqname .. crouch .. "idle";
		end
		
	end

	local NPCAnim = GetNPCAnim( ply );
	
	if( ( weapanim == PLAYER_ATTACK1 or weapanim == PLAYER_RELOAD ) and activeweap:IsValid() ) then

		local act = nil;
	
		if( weapanim == PLAYER_RELOAD ) then

			local actname = string.gsub( seqname, "aim", "" ) .. "reload";
			actname = string.gsub( actname, "idle", "" );
		
			local act = tonumber( NPCAnim[actname] );
			
			if( act == nil ) then
				return;
			end

			ply:RestartGesture( act );
		
			return true;
			
		else
		
			if( string.find( seqname, "melee" ) or string.find( seqname, "grenade" ) or string.find( seqname, "slam" ) ) then
			
				local actname = string.gsub( seqname, "aim", "" ) .. "fire";
				actname = string.gsub( actname, "idle", "" );
			                
				local act = FindEnumeration( NPCAnim[actname] );
				
				if( act == nil ) then
					return;
				end

				ply:RestartGesture( act );
				ply:Weapon_SetActivity( act, 0 );
				
				return true;
				
			end
		
			return;
			
		end
	
	end

	if ( ( not ply:OnGround() or ply:WaterLevel() > 4 ) and 
		   not ply:InVehicle() ) then
		seqname = "glide";
	end
		if ply.Sitting then
		seqname="sitfloor"
	end
 
 	if ply.leaningleft then
		seqname="leaningleft"
	end
	
	 if ply.leaningback then
		seqname="leaningback"
	end
	
	if ply.sleep then
		seqname="sleep"
	end
	
	if ply.sitchair then
		seqname="sitchair"
	end
		if( ply:KeyDown( IN_SPEED )and !ply:KeyDown( IN_DUCK ) and ply:GetVelocity():Length() > 170) then

		seqname = "sprint";
		end
	local theact = NPCAnim[seqname];
	local seq;

	if( type( theact ) == "string" ) then
		seq = ply:LookupSequence( theact );
	else
		seq = ply:SelectWeightedSequence( theact );
	end
	--If we're already playing this sequence, let's not restart it!
	if ( ply:GetSequence() == seq ) then return true; end
	ply:SetPlaybackRate( 1 );
	ply:ResetSequence( seq );
	ply:SetCycle( 1 );
	
	return true;

end
hook.Add( "SetPlayerAnimation", "NPCAnim.SetPlayerAnimation", NPCAnim.SetPlayerAnimation );

function HolsterToggle( ply )

	if( not ply:GetActiveWeapon():IsValid() ) then
		return;
	end

	if( ply:GetNWInt( "tiedup" ) == 1 ) then 
		return; 
	end
	local activeweap = ply:GetActiveWeapon();

	if( ply:GetNWInt( "holstered" ) == 1 ) then 
		
		for j, l in pairs( NeverAimed ) do
			
			if( l == activeweap:GetClass() ) then
				return;
			end
			
		end
		
		MakeAim( ply );
	else
		
		for j, l in pairs( AlwaysAimed ) do
			
			if( l == activeweap:GetClass() ) then
				return;
			end
			
		end
	
		MakeUnAim( ply );
	end

end
concommand.Add( "rp_toggleholster", HolsterToggle );

function MakeAim( ply )

	if( ply:KeyDown( IN_SPEED ) and ply:GetNWInt( "sprint" ) > 0 ) then
		return;
	end

	if( not ply:GetActiveWeapon():IsValid() ) then return; end
	
	if table.HasValue( NeverAimed, ply:GetActiveWeapon():GetClass() ) then return; end

	if( not ply:GetActiveWeapon():GetTable().Invisible ) then
	//	ply:DrawViewModel( true );
		ply:DrawWorldModel( true );
	else
		ply:DrawViewModel( false );
		ply:DrawWorldModel( false );
	end
	
	ply:GetActiveWeapon():SetNWBool( "NPCAimed", true );
	ply:GetActiveWeapon():SetNextPrimaryFire( CurTime() );
	
	ply:SetNWInt( "holstered", 0 );
	
end

function MakeUnAim( ply )

	if( not ply:GetActiveWeapon():IsValid() ) then return; end
    if table.HasValue( AlwaysAimed, ply:GetActiveWeapon():GetClass() ) then return; end

	// ply:DrawViewModel( false );
	
	if( ply:GetActiveWeapon():IsValid() ) then
		ply:GetActiveWeapon():SetNWBool( "NPCAimed", false );
		
		local delay = true;
		
		for k, v in pairs( UsableHolstered ) do
			if( v == ply:GetActiveWeapon():GetClass() ) then
				delay = false;
			end
		end
		
		if( delay ) then
			ply:GetActiveWeapon():SetNextPrimaryFire( CurTime() + 999999 );
		end
		
	end
	
	ply:SetNWInt( "holstered", 1 );
		
end

function NPCPlayerThink()

	for k, v in pairs( player.GetAll() ) do
	
		if( not v:GetTable().NPCLastWeapon or not v:GetActiveWeapon():IsValid() or v:GetTable().NPCLastWeapon ~= v:GetActiveWeapon():GetClass() ) then
	
			MakeUnAim( v );
			
			v:GetTable().NPCLastWeapon = "";
			
			if( v:GetActiveWeapon():IsValid() ) then
			
				v:GetTable().NPCLastWeapon = v:GetActiveWeapon():GetClass();
			
				for j, l in pairs( AlwaysAimed ) do
				
					if( l == v:GetActiveWeapon():GetClass() and not v:GetActiveWeapon():GetNWBool( "NPCAimed" ) ) then
						MakeAim( v );
					end
				
				end
			
			end
			
		end
	
	end

end
hook.Add( "Think", "NPCPlayerThink", NPCPlayerThink );

Msg( "Gamemode file; animations.lua loaded\n" )

local function PlayerSpawn( pl )
	pl:SetDTFloat( 3, 1 )
	pl:GetTable().WalkSpeed = 80
	pl:GetTable().StaminaDrain 		= .1
	pl:GetTable().StaminaRegen 		= pl:GetTable().StaminaDrain / 3.5
	pl:GetTable().RunSpeed = 260
	pl:GetTable().JogSpeed = 140
	pl:GetTable().HighWeight = 50
	pl:GetTable().MaxWeight = 60
	pl:SetWalkSpeed( pl:GetTable().JogSpeed )
end
local ExoModels = {
"models/srp/masterduty.mdl",
"models/srp/masterfreedom.mdl",
"models/srp/mastermercenary.mdl",
"models/srp/mastermonolith.mdl",
"models/srp/masterstalker.mdl"
}
local function Think( )
	local k, v, delta, a, b, c, vel, moving
	
	delta = FrameTime( )
	
	for k, v in ipairs( player.GetAll( ) ) do
		if not ValidEntity( v ) or not v:Alive( ) then
			return
		end
		
		a = v:GetDTFloat( 3 )
		vel = v:GetVelocity( )
		vel.z = 0
		vel = vel:Length( )
		
		moving = v:KeyDown( IN_FORWARD ) or v:KeyDown( IN_MOVERIGHT ) or v:KeyDown( IN_BACK ) or v:KeyDown( IN_MOVELEFT )
		
		--Calculate stamina
		if v:KeyDown( IN_SPEED ) and ( v:IsOnGround( ) or v:WaterLevel( ) > 0 ) and vel > 0 and not ValidEntity( v:GetVehicle( ) ) and moving then
			--We're on the ground ( or swimming ), sprinting, and not driving
			a = math.Approach( a, 0, delta * v:GetTable().StaminaDrain  )
		else
			if( v:OnGround() ) then
			--Not sprinting, so regenerate it
			if( v:KeyDown( IN_WALK ) or vel == 0) then
			a = math.Approach( a, 1, delta * ( v:GetTable().StaminaRegen ))
			else
			a = math.Approach( a, 1, delta * ( v:GetTable().StaminaRegen / 2 ))
			end
		end
		end
/*
		if v:KeyPressed( IN_JUMP ) then
		if( a >= .1 ) then
			a = a - .1
		end
		end
*/
		if v:KeyDown( IN_SPEED ) then
		if a <= 0.05  then
				v:SetRunSpeed(v:GetTable().JogSpeed)
		elseif( a <= .5 ) then
			v:SetRunSpeed( v:GetTable().JogSpeed + 30 )
		else
			v:SetRunSpeed( v:GetTable().RunSpeed )
		end
	//	elseif v:KeyDown( IN_WALK ) then
	//		v:SetWalkSpeed( v:GetTable().WalkSpeed )
	//	else
	//		v:SetWalkSpeed( v:GetTable().JogSpeed )
		end
		for z,x in pairs( ExoModels ) do
		if( v:GetModel() == x ) then
			 v:SetRunSpeed(v:GetTable().JogSpeed)
		end
		end
	//	if( v:Team() != 24 ) then
	//	if( v:GetDTFloat( 1 ) > v:GetTable().HighWeight ) then
	//		v:SetRunSpeed(v:GetTable().JogSpeed)
	//	elseif( v:GetDTFloat( 1 ) > v:GetTable().MaxWeight() ) then
	//		v:SetRunSpeed( 0 )
	//	end
	//	end
		v:SetDTFloat( 3, a )

	end
end
/*
function BlockJump( ply, bind, pressed )
RAD.DayLog( "script.txt", "Player" .. ply:GetName() .. " running bind " .. bind );
end

hook.Add( "PlayerBindPress", "BlockJump", BlockJump )
*/

function KeyPressed (ply, key)
	if( key == IN_JUMP ) then
		if( ply:GetDTFloat( 3)  >= .1 ) then
			ply:SetDTFloat( 3, ply:GetDTFloat( 3) - .1 )
		end
	end
	if( key == IN_FORWARD or key == IN_MOVERIGHT or key == IN_MOVELEFT or key == IN_BACK  ) then
		if key ==  IN_WALK  then
			ply:SetWalkSpeed( ply:GetTable().WalkSpeed )
		else
			ply:SetWalkSpeed( ply:GetTable().JogSpeed )
		end
	end
end
 
hook.Add( "KeyPress", "KeyPressedHook", KeyPressed )

hook.Add( "Think"			, "Stamina.Think"			, Think 			)
hook.Add( "PlayerSpawn"			, "Stamina.PlayerSpawn"			, PlayerSpawn 			)
hook.Add( "PlayerSwitchFlashlight"	, "Stamina.PlayerSwitchFlashlight"	, PlayerSwitchFlashlight 	)
