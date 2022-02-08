PLUGIN.Name = "Voices"; -- What is the plugin name
PLUGIN.Author = "SilverKnight"; -- Author of the plugin
PLUGIN.Description = "Yey...."; -- The description or purpose of the plugin

function PLUGIN.Init( ) -- We run this in init, because this is called after the entire gamemode has been loaded.
--STALKER
RAD.AddVoice("blackraven", "hgn/stalker/voice/stalker_blackraven.mp3", 1, "Black Raven, Black Raven, Circling above the grave");
RAD.AddVoice("comehere", "hgn/stalker/voice/stalker_comehere.mp3", 1, "Come Here");
RAD.AddVoice("coming", "hgn/stalker/voice/stalker_coming.mp3", 1, "/yell Coming, They are coming!");
RAD.AddVoice("fillin", "hgn/stalker/voice/stalker_fillin.mp3", 1, "Pipe down men, let me fill you in");
RAD.AddVoice("getoverhere", "hgn/stalker/voice/stalker_getoverhere.mp3", 1, "Don't just stand there, get over here");
RAD.AddVoice("goodjob", "hgn/stalker/voice/stalker_goodjob.mp3", 1, "Good job guys, take your positions");
RAD.AddVoice("hello", "hgn/stalker/voice/stalker_hello.mp3", 1, "Hello");
RAD.AddVoice("hellobrother", "hgn/stalker/voice/stalker_hellobrother.mp3", 1, "Hello brother, why have you come?");
RAD.AddVoice("help", "hgn/stalker/voice/stalker_help.mp3", 1, "/yell Someone, help me!");
RAD.AddVoice("ifsomeonehelped", "hgn/stalker/voice/stalker_ifsomeonehelped.mp3", 1, "Dammit, if only someone helped");
RAD.AddVoice("interesting", "hgn/stalker/voice/stalker_interesting.mp3", 1, "Ive always got something interesting for people like you");
RAD.AddVoice("sure", "hgn/stalker/voice/stalker_sure.mp3", 1, "Sure, alright");
RAD.AddVoice("talk", "hgn/stalker/voice/stalker_talk_9.mp3", 1, "/me says some random words");
RAD.AddVoice("talk2", "hgn/stalker/voice/stalker_trade_6.mp3", 1, "/me says some random words");
RAD.AddVoice("yeah", "hgn/stalker/voice/stalker_yeah.mp3", 1, "/me agrees");
RAD.AddVoice("yeah", "hgn/stalker/voice/stalker_yeah.mp3", 1, "/me agrees");
RAD.AddVoice("zwhistle", "hgn/stalker/voice/random_whistle.mp3", 1, "/me Whistles");
--Bandit
RAD.AddVoice("cash", "hgn/stalker/voice/bandit_cash.mp3", 1, "Your cash and your artifacts, and quick you asshole");
RAD.AddVoice("die", "hgn/stalker/voice/bandit_die.mp3", 1, "/yell 11-99, Prepare To Die You Son Of A Bitch!");
RAD.AddVoice("handitover", "hgn/stalker/voice/bandit_handitover.mp3", 1, "Hand it over or we will blow your head off");
RAD.AddVoice("hero", "hgn/stalker/voice/bandit_hero.mp3", 1, "Piss off you stinkin hero wannabe");
RAD.AddVoice("insult1", "hgn/stalker/voice/bandit_combat_5.mp3", 1, "Im going to gut you!");
RAD.AddVoice("insult2", "hgn/stalker/voice/bandit_combat_8.mp3", 1, "Fucking asshole!");
RAD.AddVoice("mindbiz", "hgn/stalker/voice/bandit_mindbiz.mp3", 1, "Just mind your own buisness stalker");
RAD.AddVoice("retard", "hgn/stalker/voice/bandit_retard.mp3", 1, "Don't you get it retard?");
--Duty
RAD.AddVoice("buzzoff", "hgn/stalker/voice/duty_buzzoff.mp3", 1, "Buzz off stalker, we don't let every loser go through");
RAD.AddVoice("donthang", "hgn/stalker/voice/duty_donthang.mp3", 1, "Don't hand around here!");
RAD.AddVoice("getoutst", "hgn/stalker/voice/duty_getoutst.mp3", 1, "Get out of here Stalker!");
RAD.AddVoice("stop", "hgn/stalker/voice/duty_guards_stop.mp3", 1, "Stop! This area is closed to outsiders");
--Eco
RAD.AddVoice("adjustproto", "hgn/stalker/voice/eco_adjust_prototype.mp3", 1, "Alright, let me adjust the prototype");
RAD.AddVoice("throughtous", "hgn/stalker/voice/eco_suit_through_to_us.mp3", 1, "Wow marked one, it's about time you got through to us");
RAD.AddVoice("whydidhedie", "hgn/stalker/voice/eco_why_did_he_die.mp3", 1, "Why did he die, you were supposed to protect him!");
--Freedom
RAD.AddVoice("attack", "hgn/stalker/voice/freedom_attack.mp3", 1, "/me shouts something abusive");
--Military
RAD.AddVoice("chat", "hgn/stalker/voice/military_chat.mp3", 1, "Come up and we will have a chat");
RAD.AddVoice("distressed", "hgn/stalker/voice/soldier_alarm_4.mp3", 1, "Alarmed");
RAD.AddVoice("distressed2", "hgn/stalker/voice/soldier_combat_2.mp3", 1, "Alarmed");
--Trader
RAD.AddVoice("goodhunting", "hgn/stalker/voice/trader_goodhunting.mp3", 7, "Good hunting Stalker");
RAD.AddVoice("gotajob", "hgn/stalker/voice/trader_gotajob.mp3", 7, "Got a job for you marked one ");
RAD.AddVoice("hell", "hgn/stalker/voice/trader_hell.mp3", 7, "/yell Marked One, what the hell! ");
RAD.AddVoice("hello", "hgn/stalker/voice/trader_hello.mp3", 7, "Whats up? How goes it? ");
RAD.AddVoice("hello2", "hgn/stalker/voice/trader_hello2.mp3", 7, "Hows it going? ");
RAD.AddVoice("rookieorstalker", "hgn/stalker/voice/trader_rookieorstalker.mp3", 7, "The choice is yours, either i brainwash you like.... ");
RAD.AddVoice("shit", "hgn/stalker/voice/trader_shit.mp3", 7, "What is this shit! ");
RAD.AddVoice("retard", "hgn/stalker/voice/trader_withoutweap.mp3", 7, "/yell Where are you going without a weapon, retard! ");
RAD.AddVoice("zwhistle", "hgn/stalker/voice/random_whistle.mp3", 7, "/me Whistles");
--Bloodsucker
RAD.AddVoice("breath", "hgn/stalker/creature/snork/bloodsuckerbreath.wav", 8, "/me breaths ");
RAD.AddVoice("growl", "hgn/stalker/background/sucker_growl_1.mp3", 8, "growl");
RAD.AddVoice("growl", "hgn/stalker/player/attack_hit_3.mp3", 8, "growl");
--Snork
RAD.AddVoice("breathe", "hgn/stalker/creature/snork/snork_idle_1.mp3", 9, "Breath");
RAD.AddVoice("growl", "hgn/stalker/creature/snork/snorkleap.wav", 9, "/me Growls");
RAD.AddVoice("growl2", "hgn/stalker/creature/snork/snorkscream.wav", 9, "/me Growls");
--Zombie
RAD.AddVoice("mutter1", "hgn/stalker/voice/zombie_attack.mp3", 10, "/me mutters something");
RAD.AddVoice("mutter2", "hgn/stalker/voice/zombie_enermy.mp3", 10, "/me mutters something");
RAD.AddVoice("mutter3", "hgn/stalker/voice/zombie_idle_16.mp3", 10, "/me mutters something");
end
	