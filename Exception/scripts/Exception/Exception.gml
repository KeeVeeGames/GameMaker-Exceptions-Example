globalvar __YYGMLException_static

try {
	var temp = "string" + 0;
} catch(exception) {
	__YYGMLException_static = static_get(exception);
}

/// @ignore
/// @description						Base class for exceptions
function Exception() constructor {
	static_set(self, __YYGMLException_static);		// inherit from system YYGMLException
	
	message = instanceof(self) + "\r\n";
	longMessage = message;
	script = "";
	line = -1;
	stacktrace = [];
	
	// TODO: Check callstack format on different target platfroms
	// TODO: Replace string functions with buffer mutations?
	var stack = debug_get_callstack();
	
	for (var i = 2, length = array_length(stack) - 1; i < length; i++) {
		var stackline = stack[i];
		var colonPos = string_pos(":", stackline);
		
		if (i == 2) {
			script = string_copy(stackline, 1, colonPos - 1);
			line = real(string_copy(stackline, colonPos + 1, string_length(stackline) - colonPos));
		}
		
		stackline = string_replace(stackline, ":", " (line : ");
		stackline += ")";
		
		array_push(stacktrace, stackline);
	}
	
	toString = function() {
		return message;
	}
}