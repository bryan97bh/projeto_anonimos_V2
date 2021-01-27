// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_DrugsRunners.sqf
//	@file Author: Staynex
//  @file Author: bryan 

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf";

private ["_convoyVeh", "_veh1", "_veh2", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_drop_item", "_drugpilerandomizer", "_drugpile", "_cal1", "_cal2"];

_setupVars =
{
	_missionType = "PATRULHA DE RECONHECIMENTO";
	_locationsArray = nil;
};

_setupObjects =
{
	_town = (call cityList) call BIS_fnc_selectRandom;
	_missionPos = markerPos (_town select 0);
	
	// pick the vehicles for the convoy
	_convoyVeh = if (missionDifficultyHard) then
	{
		["B_T_LSV_01_armed_F"]
	}
	else
	{
		["O_T_LSV_02_armed_F"]
	};

	_veh1 = _convoyVeh select 0;

	_createVehicle =
	{
		private ["_type", "_position", "_direction", "_vehicle", "_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "None"];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInCargo [_vehicle, 0];
        
        _soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInGunner  _vehicle;
		
		_vehicle addEventhandler ["HandleDamage", {0.75*(_this select 2)}];
		_vehicle addEventhandler ["HandleDamage", {if (_this select 1 in ["wheel_1_1_steering","wheel_1_2_steering","wheel_2_1_steering","wheel_2_2_steering"]) then {0*(_this select 2)}}];

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		[_vehicle, "client\images\vehicleTextures\woodtiger.paa"] call applyVehicleTexture;

		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_pos = getMarkerPos (_town select 0);
	_rad = _town select 1;
	_vehiclePos = [_pos,5,_rad,5,0,0,0] call findSafePos;
	
	_vehicles =
	[
		[_veh1, _vehiclePos, 0] call _createVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "GREEN"; // units will never fire
	_aiGroup setBehaviour "CARELESS"; // nits will try to stay on roads, not caring about finding any cover
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "FULL" } else { "FULL" };
	
	_aiGroup setSpeedMode _speedMode;
	
	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointBehaviour "CARELESS";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh1 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh1 >> "displayName");

	_missionHintText = format ["Um grupo de Ex-militares das Forças Especiais esta dirigindo um <t color='%2'>%1</t> e parece transportar algo valioso, verifique o que é!", _vehicleName, sideMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

_drop_item = 
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
};

_successExec =
{
	// Mission completed
	/*_box1 = createVehicle ["Box_NATO_Wps_F", _lastPos, [], 2, "None"];
	_box1 setDir random 360;
	[_box1, ["MILITIA", "OTHER"] call BIS_fnc_selectRandom] call fn_refillbox;
    
    /*
	_box2 = createVehicle ["Box_East_WpsSpecial_F", _lastPos, [], 2, "None"];
	_box2 setDir random 360;
	[_box2, ["US", "OTHER"] call BIS_fnc_selectRandom] call fn_refillbox;
    */

    _cal1 = createVehicle ["I_HMG_01_F", _lastPos, [], 2, "None"];
	_cal1 setDir random 360;
	
	_cal2 = createVehicle ["I_HMG_02_F", _lastPos, [], 2, "None"];
	_cal2 setDir random 360;

	//{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
    { _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_cal1, _cal2];
    
    
    //Spawn some drugs ;) As Staynex hates drugs :P
	_drugpilerandomizer = [5,10,15];
	_drugpile = _drugpilerandomizer call BIS_fnc_SelectRandom;
	
	for "_i" from 1 to _drugpile do 
	{
	  private["_item"];
	  _item = [
	          ["energydrink", "Land_Can_V3_F"],
	          ["energydrink", "Land_Can_V3_F"],
	          ["energydrink", "Land_Can_V3_F"],
			  ["energydrink", "Land_Can_V3_F"],
			  ["energydrink", "Land_Can_V3_F"],
			  ["energydrink", "Land_Can_V3_F"],
			  ["energydrink", "Land_Can_V3_F"],
			  ["energydrink", "Land_Can_V3_F"],
			  ["energydrink", "Land_Can_V3_F"],
	          ["energydrink", "Land_Can_V3_F"]
	        ] call BIS_fnc_selectRandom;
	  [_item, _lastPos] call _drop_item;
	};
	
	_successHintMessage = "A patrulha foi eliminada, pegue o pacote e saia dai";
};

_this call sideMissionProcessor;