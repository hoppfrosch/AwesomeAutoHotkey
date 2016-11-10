; ############################################################
; CREDITS: cocobelgica@gmail.com - https://github.com/cocobelgica/AutoHotkey-JSON
; ############################################################

#include <JSON>
#include <ObjTree>

class AwesomeJSON{	
	; ***********************************************************************************
	; SubClass
	; Converts the input data into markdown
	class asMarkdown {
		_version := "0.1.0"
		
		__New(myParent) {
		  	this.parent := myParent
		  	if (this.parent.debug) ; _DBG_
				OutputDebug % "*[" A_ThisFunc "(parent=(" myParent "))] (version: " this._version ")" ; _DBG_

			return this
		}

		; produces a markdown link
		link(name, url) {
			if (name) {
		  		if( url) {
		  			return "[" name "](" url ")"
		  		}
	  			else {
	  				return name
				}
			}
			return
		}
		
		; ##################### Start of Properties ############################################################################
	  	author[] {
	  		/* ------------------------------------------------------------------------------- 
			Property: author [get]
			Author as markdown

			*/
	  		get {
				ret := this.link(this.parent._data.author.name, this.parent._data.author.url)
		  		if (!ret) {
		  			ret := "*Author missing*"
				}
				
				if (this.parent.debug) ; _DBG_
					OutputDebug % "*[" A_ThisFunc "()] --> " ret ; _DBG_
				
				return ret
			}
  		}
  		component[] {
	  		/* ------------------------------------------------------------------------------- 
			Property: component [get]
			component as markdown
			*/
	  		get {
				ret := this.link(this.parent._data.name, this.parent._data.source)
		  		if (!ret) {
		  			ret := this.parent._data.name
				}
				
				if (this.parent.debug) ; _DBG_
					OutputDebug % "*[" A_ThisFunc "()] --> " ret ; _DBG_
				
				return ret
			}
		}
		desc[] {
			/* ------------------------------------------------------------------------------- 
			Property: description [get]
			description as markdown
			*/
	  		get {
				ret := this.parent._data.description
		  		if (!ret) {
		  			ret := "*Description missing*"
				}
				
				if (this.parent.debug) ; _DBG_
					OutputDebug % "*[" A_ThisFunc "()] --> " ret ; _DBG_
				
				return ret
			}
		}
		links[] {
			/* ------------------------------------------------------------------------------- 
			Property: links [get]
			links as markdown
			*/
	  		get {
	  			ret := ""
	  			arr := Object()
	  			arr := this.parent._data.links
	  			; WinWaitClose % "ahk_id " ObjTree(arr, "Links")
	  			for index, element in arr { ; Recommended approach in most cases
	  				if (index > 1) {
	  				ret := ret . ", "
	  				}
					ret := ret . this.link(element.text, element.url)
				}
				
				if (this.parent.debug) ; _DBG_
					OutputDebug % "*[" A_ThisFunc "()] --> " ret ; _DBG_
				
				return ret
			}
		}
		longtext[] {
	  		/* ------------------------------------------------------------------------------- 
			Property: longtext [get]
			Complete component description as markdown
			*/
	  		get {
	  			if (this.parent.debug) ; _DBG_
					OutputDebug % ">[" A_ThisFunc "()]" ; _DBG_
				
				ret := ""
				ret := ret . this.component
				ret := ret . " - "
				ret := ret . "by " . this.author
				ret := ret . " - "
				ret := ret . this.desc
				links := this.links
				if (this.links != "") {
					ret := ret . " - "
					ret := ret . "Links: " . this.links
				}

				if (this.parent.debug) ; _DBG_
					OutputDebug % "<[" A_ThisFunc "()] --> " ret ; _DBG_
				
				return ret
			}
		}
  		
  		
	} ; end of nested class <asMarkdown> 

	; ***********************************************************************************
	/*
		Class: AwesomeJSON
		Class to handle an JSON-File as input for generation of awesomeAHK-list entry
		
		Authors:
	<hoppfrosch at hoppfrosch@gmx.de>: Original
		
		About: License
		This program is free software. It comes without any warranty, to the extent permitted by applicable law. You can redistribute it and/or modify it under the terms 		of the Do What The Fuck You Want To Public License, Version 2, as published by Sam Hocevar. See <WTFPL at http://www.wtfpl.net/> for more details.
	*/
	_version := "0.1.1"
	_debug := 0
	-data := Object()
	md := Object()
	
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

		this.md := new this.asMarkdown(this)
		
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
	
	; ##################### Start of Properties ############################################################################
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