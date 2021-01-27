//	@file Version: 1.0
//	@file Name: midGroup.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 21:58
//	@file Args:

if (!isServer) exitWith {};

private ["_group", "_pos", "_leader", "_man2", "_man3", "_man4", "_man5", "_man6", "_man7", "_man8", "_man9", "_man10"];

_group = _this select 0;
_pos = _this select 1;
_nbUnits = param [2, 7, [0]];
_radius = param [3, 10, [0]];

// Leader
_leader = _group createUnit ["C_man_1", [(_pos select 0) - 30, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _leader;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_leader addHeadgear "H_HelmetO_ViperSP_hex_F";
_leader addGoggles "G_WirelessEarpiece_F";
_leader addUniform "U_O_CombatUniform_ocamo";
_leader addVest "V_EOD_coyote_F";

_leader addMagazine "30Rnd_65x39_caseless_green_mag_Tracer";
_leader addWeapon "arifle_Katiba_F";
_leader addPrimaryWeaponItem "muzzle_snds_H";
_leader addPrimaryWeaponItem "acc_pointer_IR";
_leader addPrimaryWeaponItem "optic_Arco_blk_F";

_leader addMagazines ["SmokeShell", 2];
_leader addItemToVest "FirstAidKit";
for "_i" from 1 to 2 do {_leader addItemToVest "HandGrenade";};
		
_leader call setMissionSkill;
_leader addRating 1e11;
_leader spawn refillPrimaryAmmo;
_leader addEventHandler ["Killed", server_playerDied];


// Soldier2 - AT-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_man2 = _group createUnit ["C_man_1", [(_pos select 0) - 30, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _man2;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man2 linkItem "NVGoggles";
_man2 addHeadgear "H_HelmetLeaderO_ocamo";
_man2 addGoggles "G_WirelessEarpiece_F";
_man2 addUniform "U_O_CombatUniform_ocamo";
_man2 addVest "V_HarnessO_brn";
_man2 addBackpack "B_FieldPack_khk";

_man2 addMagazine "30Rnd_65x39_caseless_green_mag_Tracer";
_man2 addWeapon "arifle_Katiba_C_F";
_man2 addPrimaryWeaponItem "optic_Holosight_blk_F";

_man2 addMagazine "Vorona_HEAT";
_man2 addWeapon "launch_O_Vorona_brown_F";
for "_i" from 1 to 1 do {_man2 addItemToBackpack "Vorona_HEAT";};
for "_i" from 1 to 1 do {_man2 addItemToBackpack "Vorona_HE";};

_man2 addMagazines ["SmokeShell", 2];
_man2 addItemToVest "FirstAidKit";
		
_man2 call setMissionSkill;
_man2 addRating 1e11;
_man2 spawn refillPrimaryAmmo;
_man2 addEventHandler ["Killed", server_playerDied];

// Soldier3 - AA-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_man3 = _group createUnit ["C_man_1", [(_pos select 0) - 30, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _man3;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man3 linkItem "NVGoggles";
_man3 addHeadgear "H_HelmetLeaderO_ocamo";
_man3 addGoggles "G_WirelessEarpiece_F";
_man3 addUniform "U_O_CombatUniform_ocamo";
_man3 addVest "V_HarnessO_brn";
_man3 addBackpack "B_FieldPack_ocamo_AA";

_man3 addMagazine "30Rnd_65x39_caseless_green_mag_Tracer";
_man3 addWeapon "arifle_Katiba_C_F";
_man3 addPrimaryWeaponItem "optic_Holosight_blk_F";

_man3 addMagazine "Titan_AA";
_man3 addWeapon "launch_O_Titan_F";
for "_i" from 1 to 2 do {_man3 addItemToBackpack "Titan_AA";};

_man3 addMagazines ["SmokeShell", 2];
_man3 addItemToVest "FirstAidKit";
		
_man3 call setMissionSkill;
_man3 addRating 1e11;
_man3 spawn refillPrimaryAmmo;
_man3 addEventHandler ["Killed", server_playerDied];

// Soldier4 GL-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_man4 = _group createUnit ["C_man_1", [(_pos select 0) - 30, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _man4;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man4 addHeadgear "H_HelmetLeaderO_ocamo";
_man4 addGoggles "G_WirelessEarpiece_F";
_man4 addUniform "U_O_CombatUniform_ocamo";
_man4 addVest "V_HarnessOGL_brn";

_man4 addMagazine "30Rnd_65x39_caseless_green_mag_Tracer";
_man4 addWeapon "arifle_Katiba_GL_F";
_man4 addPrimaryWeaponItem "optic_ACO_grn";

_man4 addMagazines ["SmokeShell", 2];
_man4 addItemToVest "FirstAidKit";
for "_i" from 1 to 4 do {_man4 addItemToVest "1Rnd_HE_Grenade_shell";};
		
_man4 call setMissionSkill;
_man4 addRating 1e11;
_man4 spawn refillPrimaryAmmo;
_man4 addEventHandler ["Killed", server_playerDied];


// Soldier5 GL-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_man5 = _group createUnit ["C_man_1", [(_pos select 0) - 30, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _man5;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man5 addHeadgear "H_HelmetLeaderO_ocamo";
_man5 addGoggles "G_WirelessEarpiece_F";
_man5 addUniform "U_O_CombatUniform_ocamo";
_man5 addVest "V_HarnessOGL_brn";

_man5 addMagazine "30Rnd_65x39_caseless_green_mag_Tracer";
_man5 addWeapon "arifle_Katiba_GL_F";
_man5 addPrimaryWeaponItem "optic_ACO_grn";

_man5 addMagazines ["SmokeShell", 2];
_man5 addItemToVest "FirstAidKit";
for "_i" from 1 to 4 do {_man5 addItemToVest "1Rnd_HE_Grenade_shell";};
		
_man5 call setMissionSkill;
_man5 addRating 1e11;
_man5 spawn refillPrimaryAmmo;
_man5 addEventHandler ["Killed", server_playerDied];

// Soldier6 SNIPER-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_man6 = _group createUnit ["C_man_1", [(_pos select 0) - 30, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _man6;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man6 addHeadgear "H_HelmetLeaderO_ocamo";
_man6 addGoggles "G_WirelessEarpiece_F";
_man6 addUniform "U_O_CombatUniform_ocamo";
_man6 addVest "V_HarnessO_brn";

_man6 addMagazine "10Rnd_762x54_Mag";
_man6 addWeapon "srifle_DMR_01_F";
_man6 addPrimaryWeaponItem "muzzle_snds_B";
_man6 addPrimaryWeaponItem "optic_DMS_weathered_F";
_man6 addPrimaryWeaponItem "bipod_02_F_blk";

_man6 addMagazines ["SmokeShell", 2];
_man6 addItemToVest "FirstAidKit";
		
_man6 call setMissionSkill;
_man6 addRating 1e11;
_man6 spawn refillPrimaryAmmo;
_man6 addEventHandler ["Killed", server_playerDied];

// Soldier7 CB-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_man7 = _group createUnit ["C_man_1", [(_pos select 0) - 30, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _man7;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man7 addHeadgear "H_HelmetLeaderO_ocamo";
_man7 addGoggles "G_WirelessEarpiece_F";
_man7 addUniform "U_O_CombatUniform_ocamo";
_man7 addVest "V_HarnessO_brn";

_man7 addMagazine "150Rnd_93x64_Mag";
_man7 addWeapon "MMG_01_hex_F";
_man7 addPrimaryWeaponItem "optic_ERCO_snd_F";
_man7 addPrimaryWeaponItem "bipod_02_F_hex";

_man7 addItemToVest "FirstAidKit";
		
_man7 call setMissionSkill;
_man7 addRating 1e11;
_man7 spawn refillPrimaryAmmo;
_man7 addEventHandler ["Killed", server_playerDied];

// Soldier8 SD-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_man8 = _group createUnit ["C_man_1", [(_pos select 0) - 30, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _man8;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man8 addHeadgear "H_HelmetLeaderO_ocamo";
_man8 addGoggles "G_WirelessEarpiece_F";
_man8 addUniform "U_O_CombatUniform_ocamo";
_man8 addVest "V_HarnessO_brn";

_man8 addMagazine "30Rnd_65x39_caseless_green_mag_Tracer";
_man8 addWeapon "arifle_Katiba_F";
_man8 addPrimaryWeaponItem "acc_flashlight";

_man8 enablegunlights "forceOn";
_man8 addMagazines ["SmokeShell", 2];
_man8 addItemToVest "FirstAidKit";
for "_i" from 1 to 2 do {_man8 addItemToVest "HandGrenade";};
		
_man8 call setMissionSkill;
_man8 addRating 1e11;
_man8 spawn refillPrimaryAmmo;
_man8 addEventHandler ["Killed", server_playerDied];

// Soldier9 SD-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_man9 = _group createUnit ["C_man_1", [(_pos select 0) - 30, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _man9;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man9 addHeadgear "H_HelmetLeaderO_ocamo";
_man9 addGoggles "G_WirelessEarpiece_F";
_man9 addUniform "U_O_CombatUniform_ocamo";
_man9 addVest "V_HarnessO_brn";

_man9 addMagazine "30Rnd_65x39_caseless_green_mag_Tracer";
_man9 addWeapon "arifle_Katiba_F";
_man9 addPrimaryWeaponItem "acc_flashlight";

_man9 addMagazines ["SmokeShell", 2];
_man9 addItemToVest "FirstAidKit";
		
_man9 enablegunlights "forceOn";
_man9 call setMissionSkill;
_man9 addRating 1e11;
_man9 spawn refillPrimaryAmmo;
_man9 addEventHandler ["Killed", server_playerDied];

// Soldier10 SD-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_man10 = _group createUnit ["C_man_1", [(_pos select 0) - 30, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _man10;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man10 addHeadgear "H_HelmetLeaderO_ocamo";
_man10 addGoggles "G_WirelessEarpiece_F";
_man10 addUniform "U_O_CombatUniform_ocamo";
_man10 addVest "V_HarnessO_brn";

_man10 addMagazine "30Rnd_65x39_caseless_green_mag_Tracer";
_man10 addWeapon "arifle_Katiba_F";
_man10 addPrimaryWeaponItem "acc_flashlight";

_man10 addMagazines ["SmokeShell", 2];
_man10 addItemToVest "FirstAidKit";
		
_man10 enablegunlights "forceOn";
_man10 call setMissionSkill;
_man10 addRating 1e11;
_man10 spawn refillPrimaryAmmo;
_man10 addEventHandler ["Killed", server_playerDied];

_leader = leader _group;
[_group, _pos] call defendArea;