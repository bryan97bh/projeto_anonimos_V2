disableSerialization;
_dsp = uiNamespace getVariable [ "RscDisplayServerInfoMenu2", displayNull ];
if not ( isNull _dsp ) then
   {
      {
         _ctrl = _x;
         _ctrl ctrlSetFade 1;
         _ctrl ctrlCommit 0;
         playSound [ "ReadOutHideClick1", true ];
         uiSleep 0;
      } forEach ( allControls _dsp );
      closeDialog 0;
   };
