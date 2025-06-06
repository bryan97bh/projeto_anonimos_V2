// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
#define groupManagementDialog 55510
#define groupManagementPlayerList 55511
#define groupManagementGroupList 55512
#define groupManagementPromoteButton 55513
#define groupManagementInviteButton 55514
#define groupManagementKickButton 55515
#define groupManagementDisbandButton 55516
#define groupManagementLeaveButton 55517
#define groupManagementNameButton 55521
#define groupManagementNameInput_IDC 55522

class GroupManagement {

	idd = groupManagementDialog;
	movingEnable = true;
	enableSimulation = true;

	#define Atm_TEXT_SIZE (0.04 * TEXT_SCALE)

    class AtmLabelText : w_RscText {
        sizeEx = Atm_TEXT_SIZE;
    };

	class controlsBackground {

		class MainBG : w_RscPicture {
			idc = -1;
			text = "client\ui\ui_background_controlers_ca.paa";
			moving = true;
			x = 0.0; y = 0.1;
			w = 1.0; h = 0.65;
		};

		class MainTitle : w_RscText {
			idc = -1;
			text = "GRUPOS";
			sizeEx = 0.04;
			shadow = 2;
			x = 0.260; y = 0.112;
			w = 0.3; h = 0.05;
		};

		class InviteTitleText : w_RscText {
			idc = -1;
			text = "JOGADORES";
			sizeEx = 0.025;
			shadow = 2;
			x = 0.0875; y = 0.155;
			w = 0.3; h = 0.050;
		};

		class GroupTitleText : w_RscText {
			idc = -1;
			text = "Seu Grupo";
			sizeEx = 0.025;
			shadow = 2;
			x = 0.5575; y = 0.155;
			w = 0.3; h = 0.050;
		};
	};

	class controls {

		class PlayerListBox : w_Rsclist {
			idc = groupManagementPlayerList;
			x = 0.020; y = 0.200;
			w = 0.235; h = 0.425;
		};

		class GroupListBox : w_Rsclist {
			idc = groupManagementGroupList;
			x = 0.490; y = 0.200;
			w = 0.235; h = 0.425;
		};

		class CloseButton : w_RscButton {
			idc = -1;
			text = "FECHAR";
			onButtonClick = "closeDialog 0;";
			x = 0.02; y = 0.68;
			w = 0.125; h = 0.033 * safezoneH;
			color[] = {0.95,0.1,0.1,1};
		};

		//class CreateGroupButton : w_RscButton {
		//	idc = groupManagementCreateButton;
		//	text = "Create Group";
		//	onButtonClick = "[] execVM 'client\systems\groups\createGroup.sqf'";
		//	x = 0.3075; y = 0.200;
		//	w = 0.125; h = 0.033 * safezoneH;
		//	color[] = {0.1,0.95,0.1,1};
		//};

		class PromotePlayerButton : w_RscButton {
			idc = groupManagementPromoteButton;
			text = "Promover";
			onButtonClick = "[] execVM 'client\systems\groups\promotePlayer.sqf'";
			x = 0.3075; y = 0.200;
			w = 0.125; h = 0.033 * safezoneH;
			color[] = {0.1,0.95,0.1,1};
		};

		class InviteButton : w_RscButton {
			idc = groupManagementInviteButton;
			text = "Convidar";
			onButtonClick = "[] execVM 'client\systems\groups\inviteToGroup.sqf'";
			x = 0.3075; y = 0.250;
			w = 0.125; h = 0.033 * safezoneH;
			color[] = {0.1,0.95,0.1,1};
		};

		class KickButton : w_RscButton {
			idc = groupManagementKickButton;
			text = "Expulsar";
			onButtonClick = "[] execVM 'client\systems\groups\kickFromGroup.sqf'";
			x = 0.3075; y = 0.300;
			w = 0.125; h = 0.033 * safezoneH;
			color[] = {0.95,0.1,0.1,1};
		};

		class DisbandButton : w_RscButton {
			idc = groupManagementDisbandButton;
			text = "Dispensar";
			onButtonClick = "[] execVM 'client\systems\groups\disbandGroup.sqf'";
			x = 0.3075; y = 0.350;
			w = 0.125; h = 0.033 * safezoneH;
			color[] = {0.95,0.1,0.1,1};
		};

		class LeaveButton : w_RscButton {
			idc = groupManagementLeaveButton;
			text = "Sair do Grupo";
			onButtonClick = "[] execVM 'client\systems\groups\leaveGroup.sqf'";
			x = 0.3075; y = 0.350;
			w = 0.125; h = 0.033 * safezoneH;
			color[] = {0.95,0.1,0.1,1};
		};

class NameInput : RscEdit
        {
            idc = groupManagementNameInput_IDC;
            text = "";
            sizeEx = Atm_TEXT_SIZE;
            x = 0.17; y = 0.662;
            w = 0.200; h = 0.033 * safezoneH;
        };

        class NameButton : w_RscButton {
            idc = groupManagementNameButton;
            text = "Mudar nome do grupo";
            onButtonClick = "[] execVM 'client\systems\groups\NameGroup.sqf'";
            x = 0.38; y = 0.662;
            w = 0.225; h = 0.033 * safezoneH;
        };
	};

};

