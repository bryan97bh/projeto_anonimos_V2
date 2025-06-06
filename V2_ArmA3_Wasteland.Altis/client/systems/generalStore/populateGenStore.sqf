// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: populateGenStore.sqf
//	@file Author: [404] Deadbeat, [KoS] His_Shadow, AgentRev
//	@file Created: 20/11/2012 05:13
//	@file Args:

#include "dialog\genstoreDefines.sqf";
disableSerialization;
private ["_switch", "_dialog", "_itemlist", "_itemlisttext", "_itemDesc", "_showPicture", "_itemsArray", "_playerSideNum", "_parentCfg", "_weapon", "_picture", "_listIndex", "_showItem", "_factionCfg", "_faction", "_isUniform", "_sideCfg", "_side"];
_switch = _this select 0;

// Grab access to the controls
_dialog = findDisplay genstore_DIALOG;
_itemlist = _dialog displayCtrl genstore_item_list;
_itemlisttext = _dialog displayCtrl genstore_item_TEXT;
_itemDesc = _dialog displayCtrl genstore_item_desc;

//Clear the list
lbClear _itemlist;
_itemlist lbSetCurSel -1;
_itemlisttext ctrlSetText "";
_itemDesc ctrlSetText "";

_showPicture = true;

switch(_switch) do
{
	case 0:
	{
		_itemsArray = call headArray;
	};
	case 1:
	{
		_itemsArray = call uniformArray;
	};
	case 2:
	{
		_itemsArray = call vestArray;
	};
	case 3:
	{
		_itemsArray = call backpackArray;
	};
	case 4:
	{
		_itemsArray = call genItemArray;
	};
	case 5:
	{
		_itemsArray = call customPlayerItems;

		_excludedItems = [];

		if !(playerSide in [BLUFOR,OPFOR]) then
		{
			_excludedItems pushBack "warchest";
		};

		if (["A3W_unlimitedStamina"] call isConfigOn) then
		{
			_excludedItems pushBack "energydrink";
		};

		if !(["A3W_survivalSystem"] call isConfigOn) then
		{
			_excludedItems pushBack "water";
			_excludedItems pushBack "cannedfood";
		};

		if (count _excludedItems > 0) then
		{
			_itemsArray = [_itemsArray, { !((_x select 1) in _excludedItems) }] call BIS_fnc_conditionalSelect;
		};
	};
	case 6:
	{
		_itemsArray = call genObjectsArray;
		_showPicture = false;
	};
	default
	{
		_itemsArray = [];
	};
};

_playerSideNum = switch (playerSide) do
{
	case BLUFOR:      { 1 };
	case OPFOR:       { 0 };
	case INDEPENDENT: { 2 };
	default           { 3 };
};

{
	_weaponClass = _x select 1;

	_parentCfg = switch (true) do
	{
		case (isClass (configFile >> "CfgVehicles" >> _weaponClass)):  { configFile >> "CfgVehicles" };
		case (isClass (configFile >> "CfgWeapons" >> _weaponClass)):   { configFile >> "CfgWeapons" };
		case (isClass (configFile >> "CfgMagazines" >> _weaponClass)): { configFile >> "CfgMagazines" };
		case (isClass (configFile >> "CfgGlasses" >> _weaponClass)):   { configFile >> "CfgGlasses" };
		default { nil };
	};

	_showItem = !("HIDDEN" in (_x select [3,999]));

	// Side-based filtering
	if (!isNil "_parentCfg") then
	{
		switch (configName _parentCfg) do
		{
			case "CfgVehicles":
			{
				if ({_weaponClass isKindOf _x} count ["C_IDAP_UAV_06_backpack_F","B_Static_Designator_01_weapon_F","O_Static_Designator_02_weapon_F"] > 0) exitWith {}; // allow everyone to buy these

				{
					_sideCfg = call _x;

					if (isNumber _sideCfg) then
					{
						_side = getNumber _sideCfg;

						if (_side in [0,1,2] && {_side != _playerSideNum}) then
						{
							_showItem = false;
						};
					};
				}
				forEach
				[
					{ _parentCfg >> _weaponClass >> "side" },
					{ configFile >> "CfgVehicles" >> getText (_parentCfg >> _weaponClass >> "assembleInfo" >> "assembleTo") >> "side" }
				];
			};
			case "CfgWeapons":
			{
				_isUniform = isText (_parentCfg >> _weaponClass >> "ItemInfo" >> "uniformClass");
				_sideCfg = _parentCfg >> _weaponClass >> "ItemInfo" >> "side";

				switch (true) do
				{
					case (_isUniform):
					{
						if !(player isUniformAllowed _weaponClass || // indie exception for NATO jungle ghillie & thermal suit due to BIS not giving a damn
						     (playerSide == INDEPENDENT && {{_weaponClass == _x} count ["U_B_CTRG_Soldier_F","U_B_T_FullGhillie_tna_F"] > 0})) then
						{
							_showItem = false;
						};
					};
					case (isNumber _sideCfg):
					{
						_side = getNumber _sideCfg;

						if (_side in [0,1,2] && {_side != _playerSideNum}) then
						{
							_showItem = false;
						};
					};
				};
			};
		};
	};

	_side = _x param [4, ""];

	if !(_side isEqualType "") then { _side = "" };

	if (!(_side in [str playerSide, ""]) && _side in ["WEST","EAST","GUER","CIV"]) then
	{
		_showItem = false;
	};

	_showItem = !("HIDDEN" in (_x select [3,999]));

	if (_showItem) then
	{
		_listIndex = _itemlist lbAdd format ["%1", if (!isNil "_parentCfg" && _x select 0 == "") then { getText (_parentCfg >> _weaponClass >> "displayName") } else { _x select 0 }];

		if (isNil "_parentCfg") then
		{
			_itemlist lbSetPicture [_listIndex, _x select 3];
		}
		else
		{
			// If BLUFOR ghillie suit, use picture from Independent ghillie suit
			if (_weaponClass == "U_B_GhillieSuit") then
			{
				_weapon = _parentCfg >> "U_I_GhillieSuit";
			}
			else
			{
				_weapon = _parentCfg >> _weaponClass;
			};

			_picture = getText (_weapon >> "picture");

			if (_showPicture) then
			{
				_itemlist lbSetPicture [_listIndex, _picture];
			};

			[_x, _parentCfg, _itemlist, _listIndex] call fn_checkStoreItemDLC;
		};

		_itemlist lbSetData [_listIndex, _weaponClass];
	};
} forEach _itemsArray;

call getInventory;
