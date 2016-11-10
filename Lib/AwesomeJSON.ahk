; ############################################################
; CREDITS: cocobelgica@gmail.com - https://github.com/cocobelgica/AutoHotkey-JSON
; ############################################################

#include <JSON>
#include <ObjTree>

class AwesomeJSON{	
	/*
		Class: AwesomeJSON
		Class to handle an JSON-File as input for generation of awesomeAHK-list 
		
		Authors:
	<hoppfrosch at hoppfrosch@gmx.de>: Original
		
		About: License
		This program is free software. It comes without any warranty, to the extent permitted by applicable law. You can redistribute it and/or modify it under the terms 		of the Do What The Fuck You Want To Public License, Version 2, as published by Sam Hocevar. See <WTFPL at http://www.wtfpl.net/> for more details.
	*/
	_version := "0.1.0"
	_debug := 0
	-data := Object()
	
	__New(sFile := "", _debug=0) { ; Loads ths file into memory.
		this._debug := _debug
		if (this.debug) ; _DBG_
			OutputDebug % ">[" A_ThisFunc "(sFile=(" sFile "))] (version: " this._version ")" ; _DBG_
		
		;if (FileExist(sFile) == false) {
		;	Throw Exception("Ini-File does not exist")
		;}

		file := FileOpen(sFile, "r")
		Contents := file.Read()
		this._data := JSON.Load( Contents )
		
		this.validate()
		
		if (this.debug) ; _DBG_
			OutputDebug % "<[" A_ThisFunc "(sFile=(" sFile "))] (version: " this._version ")" ; _DBG_
		return this
	}
	
	validate() {
		bSuccess := 0
		if (this.debug) ; _DBG_
			OutputDebug % ">[" A_ThisFunc "()]" ; _DBG_

		if (this.debug) ; _DBG_
			OutputDebug % "-[" A_ThisFunc "()] >>>> ToDo: Validation of Input-Data" ; _DBG_
		
		if (this.debug) ; _DBG_
			OutputDebug % "<[" A_ThisFunc "()] --> " bSuccess ; _DBG_
		
		return bSuccess
	}
	
	; ##################### Start of Properties (AHK >1.1.16.x) ############################################################
	debug[] {
		/* ------------------------------------------------------------------------------- 
			Property: debug [get/set]
			Debug flag for debugging the object
			
			Value:
			flag - *true* or *false*
		*/
		get {
			return this._debug
		}
		set {
			mode := value<1?0:1
			this._debug := mode
			return this._debug
		}
	}
	keyNamesRequired[] {
		/* ------------------------------------------------------------------------------- 
			Property: keyNamesRequired [get]
			Returns an array with the names of all required keys
		*/
		get {
			Array := Object()
			Array.Insert("name")
			Array.Insert("source")
			Array.Insert("category")
			Array.Insert("description")
			return Array
		}
	}
	keyNamesOptional[] {
		/* ------------------------------------------------------------------------------- 
			Property: keyNamesOptional [get]
			Returns an array with the names of all optinal keys
		*/
		get {
			Array := Object()
			Array.Insert("author")
			Array.Insert("homepage")
			Array.Insert("ahk")
			Array.Insert("type")
			Array.Insert("tags")
			Array.Insert("license")
			return Array
		}
	}
}