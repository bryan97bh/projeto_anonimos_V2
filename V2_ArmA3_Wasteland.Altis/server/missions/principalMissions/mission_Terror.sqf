// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Terror.sqf
//	@file Author: Staynex

if (!isServer) exitwith {};
#include "principalMissionsDefines.sqf";

private ["_vehicle","_createVehicle","_veh1","_convoyVeh","_explosive","_explosivePos","_nbUnits", "_box1", "_box2", "_townName", "_missionPos", "_buildingRadius", "_putOnRoof", "_fillEvenly", "_drop_item", "_drugpilerandomizer", "_drugpile","_cash"];

_setupVars =
{
    //Originally this mission called "ISIS incursion", but to avoid political problems #Staynex changed to "TERROR incursion"
	_missionType = "GRUPO TERRORISTA";
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE };

	// settings for this mission
	_locArray = ((call cityList) call BIS_fnc_selectRandom);
	_missionPos = markerPos (_locArray select 0);
	_buildingRadius = _locArray select 1;
	_townName = _locArray select 2;

	//randomize amount of units
	_nbUnits = _nbUnits + round(random (_nbUnits*0.5));
	// reduce radius for larger towns. for example to avoid endless hide and seek in kavala ;)
	_buildingRadius = if (_buildingRadius > 201) then {(_buildingRadius*0.5)} else {_buildingRadius};
	// 25% change on AI not going on rooftops
	if (random 1 < 0.75) then { _putOnRoof = true } else { _putOnRoof = false };
	// 25% chance on AI trying to fit into a single building instead of spreading out
	if (random 1 < 0.75) then { _fillEvenly = true } else { _fillEvenly = false };
};

_setupObjects =
{
	// spawn some crates in the middle of town (Town marker position)
	_box1 = createVehicle ["Box_NATO_Wps_F", _missionPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, "mission_Explosive"] call fn_refillbox;
	_box1 allowDamage false; // just so the bomb doesnt destroy it

	_box2 = createVehicle ["Box_East_Wps_F", _missionPos, [], 5, "None"];
	_box2 setDir random 360;
	[_box2, "mission_Explosive"] call fn_refillbox;
	_box2 allowDamage false; // just so the bomb doesnt destroy it

	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2];
	
	_veh1 = "B_G_Offroad_01_armed_F";

	_createVehicle =
	{
		private ["_type", "_position", "_direction", "_vehicle"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;


        _vehicle = [_type, _position] call createMissionVehicle;
		//[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;

		switch (true) do
		{
			case (_type isKindOf "B_G_Offroad_01_armed_F"):
			{
				[_vehicle, "client\images\vehicleTextures\urban.paa", [0]] call applyVehicleTexture; 
			};
		};

		_vehicle
	};

	_vehiclePos = _missionPos;
	
	_vehicle = [_veh1, _vehiclePos, 0] call _createVehicle;

	// spawn some rebels/enemies :)
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits] call createterrorGroup;

	// move them into buildings
	[_aiGroup, _missionPos, _buildingRadius, _fillEvenly, _putOnRoof] call moveIntoBuildings;
	
	_aiGroup setCombatMode "Red";
	
	_missionHintText = format ["Os rebeldes assumiram o controle <br/><t size='1.25' color='%1'>%2</t><br/><br/>Parece haver 15 escondidos dentro ou em cima de edifícios. Livre-se de todos e leve os suprimentos!", sideMissionColor, _townName, _nbUnits];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_vehicle,_box1, _box2];	
	deleteVehicle _vehicle;
};



_successExec =
{

	/*_drop_item = 
	{
	private["_item", "_pos"];
	_item = _this select 0;
	_pos = _this select 1;

	if (isNil "_item" || {typeName _item != typeName [] || {count(_item) != 2}}) exitWith {};
	if (isNil "_pos" || {typeName _pos != typeName [] || {count(_pos) != 3}}) exitWith {};

	private["_id", "_class"];
	_id = _item select 0;
	_class = _item select 1;

	private["_obj"];
	_obj = createVehicle [_class, _pos, [], 5, "None"];
	_obj setPos ([_pos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
	_obj setVariable ["mf_item_id", _id, true];
	};*/

	// Mission completed
	playSound3D [call currMissionDir + "client\sounds\lastresort.ogg", _vehicle, false, getPosASL _vehicle, 1, 1, 300];
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
    
    uiSleep 2.2;

	//Explode the pickup
	_explosivePos = getPosATL _vehicle;
	_explosive = createMine ["DemoCharge_F", _explosivePos, [], 0];
	_explosive setDamage 1;


	/*for "_x" from 1 to 5 do
	{
		_cash = "Land_Money_F" createVehicle markerPos _marker;
		_cash setPos ((markerPos _marker) vectorAdd ([[2 + random 2,0,0], random 360] call BIS_fnc_rotateVector2D));
		_cash setDir random 360;
		_cash setVariable["cmoney",1500,true];
		_cash setVariable["owner","world",true];
	};*/

	_successHintMessage = format ["Bom trabalho!<br/><br/><t color='%1'>%2</t><br/> é um lugar seguro novamente! <br/> os pertences agora são seus!", moneyMissionColor, _townName];
	
};

_this call principalMissionProcessor;