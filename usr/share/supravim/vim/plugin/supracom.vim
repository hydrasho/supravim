vim9script
noremap <c-_>	:call Commentary()<CR>

def Comment(char: string, line: string)
	var new_content = substitute(line, '\(\s*\)\(.*\)$', '\1' .. char .. ' \2', '')
	setline('.', new_content)
enddef

def UnComment(char: string, line: string)
	var new_content = substitute(line, char .. '\s*', '', '')
	setline('.', new_content)
enddef

def g:Commentary()
	var e = expand('%:e')
	var line = getline('.')


	if e == 's' || e == 'asm'
		if line =~ '^\s*[;].*$'
			UnComment(';', line)
		else
			Comment(';', line)
		endif
	elseif e == 'cpp' || e == 'cs' || e == 'vala' || e == 'vapi' || e == 'hpp' || e == 'tpp' || e == 'h' || e == 'c' || e == 'vue' || e == 'js' || e == 'ts' || e == 'blp'
		if line =~ '^\s*[/][/].*$'
			UnComment('//', line)
		else
			Comment('//', line)
		endif
	else
		if line =~ '^\s*[#].*$'
			UnComment('#', line)
		else
			Comment('#', line)
		endif
	endif
enddef
