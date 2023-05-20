vim9script
#**** SUPRAVIM ****"
set nocompatible
filetype off

pathogen#infect()
pathogen#helptags()

filetype plugin indent on
#--------------- jeu de couleur ---------------"
colorscheme onehalf
set background=dark
set t_Co=256

# icons_enabled

#-------------- Save Undo  ------------"
if !isdirectory($HOME .. "/.cache/vim/undo")
	mkdir($HOME .. "/.cache/vim/", "", 0770)
	mkdir($HOME .. "/.cache/vim/undo", "", 0770)
endif

set undodir=~/.cache/vim/undo
set undofile

# -------------  DBG integration  --------------"

packadd! termdebug
g:termdebug_wide = 1

#-------------- Auto Pairs ---------------------"
imap <silent><CR>				<CR><Plug>AutoPairsReturn

#--------------- Onglets ---------------------"
noremap <c-n>					<esc>:tabnew 
noremap <C-Right>				:tabnext<CR>
noremap <C-Left>				:tabprevious<CR>
inoremap <C-Right>				<esc>:tabnext<CR>
inoremap <C-Left>				<esc>:tabprevious<CR>

#--------------- Les racourcis ---------------"
noremap <C-Up>		<Esc>:call Ctags()<CR>g<C-}>
noremap <C-Down>	<Esc><C-T>
inoremap <C-Up>		<Esc>:call Ctags()<CR>g<C-}>i
inoremap <C-Down>	<Esc><C-T>i
inoremap <c-q>		<esc>:call Quit()<CR>
inoremap <c-s>		<esc>:call Save()<CR>
noremap <c-q>		<esc>:call Quit()<CR>
noremap <c-s>		<esc>:call Save()<CR>
map <C-F5> 			:Termdebug -n <CR>
map <F5> 			:call CompileRun()<CR>
imap <F5>			<Esc>:call CompileRun()<CR>
map <F6>			:call Make("run2")<CR>
imap <F6>			<Esc>:call Make("run2")<CR>
map <F7> 			:call Make("run3")<CR>
imap <F7>			<Esc>:call Make("run3")<CR>
noremap <C-d>		:vs 
noremap <S-d>		:split 
noremap <F3>		<Esc>:call ToggleNorm()<CR>
inoremap <F3>		<Esc>:call ToggleNorm()<CR>i
noremap <S-Right>	<C-w><Right><Esc>:AirlineRefresh<CR>
noremap <S-Left>	<C-w><Left><Esc>:AirlineRefresh<CR>
noremap <S-Up>		<C-w><Up><Esc>:AirlineRefresh<CR>
noremap <S-Down>	<C-w><Down><Esc>:AirlineRefresh<CR>
inoremap <TAB>		<TAB>
imap <C-g>			<esc>:NERDTreeTabsToggle<CR>
map <C-g>			:NERDTreeTabsToggle<CR>
map <S-T> <Esc>:term ++rows=15<CR>
map <S-Tab>			<<
map <Tab>			>>

#---------------      Terminal        ---------------"
tnoremap <C-q> q<CR>
tnoremap <F3> clear -x ; norminette<CR>
tnoremap <F5> supramake run<CR>
tnoremap <F6> supramake run2<CR>
tnoremap <F7> supramake run3<CR>
tnoremap <esc>	<c-\><c-n>

tnoremap <S-Right>		<C-W>N<C-w><Right><Esc>:AirlineRefresh<CR>
tnoremap <S-Left>		<C-W>N<C-w><Left><Esc>:AirlineRefresh<CR>
tnoremap <S-Up>			<C-W>N<C-w><Up><Esc>:AirlineRefresh<CR>
tnoremap <S-Down>		<C-W>N<C-w><Down><Esc>:AirlineRefresh<CR>

#--------------- utilitaires basiques ---------------"
syntax on
set mouse=a
set cursorline
set nu
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent
set shiftround
set showmode
set backspace=indent,eol,start
set pumheight=50
set timeoutlen=135
set encoding=utf-8
set splitbelow
set splitright
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
g:UltiSnipsExpandTrigger = "<Tab>"
set fillchars=vert:│
auto BufEnter,VimEnter *.tpp set filetype=cpp
# set noswapfile

#------------------ Snipets --------------------"
g:UltiSnipsExpandTrigger = "<tab>"
g:UltiSnipsJumpForwardTrigger = "<tab>"
g:UltiSnipsJumpBackwardTrigger = "<S-tab>"

#--------------- CLANG COMPLETER ---------------"
set noinfercase
set completeopt-=preview
set completeopt+=menuone,noselect
g:mucomplete#enable_auto_at_startup = 1

#--------------- SYNTASTIC ---------------"
var current_compiler = "clang"
g:rainbow_active = 1
g:syntastic_error_symbol = '\ ✖'
g:syntastic_warning_symbol = '\ ✖'
g:syntastic_cpp_compiler = 'clang++'
g:syntastic_cpp_compiler_options = ' -Wall -Wextra'
g:syntastic_check_on_open = 1
g:syntastic_enable_signs = 1
g:syntastic_cpp_check_header = 1
g:syntastic_cpp_remove_include_errors = 1
g:syntastic_c_remove_include_errors = 1
g:syntastic_c_include_dirs = ['../../../include', '../../include', '../include', './include', '../../../includes', '../../includes', '../includes', './includes', './libft', '../libft', '../../libft', '../../../libft', './libft/include', '../libft/include', '../../libft/include']

#--------------- PL NERDTREE ---------------"
g:nerdtree_tabs_open_on_console_startup = 1
g:NERDTreeIgnore = ['\.png$\', '\.jpg$', '\.o$']
g:NERDTreeWinSize = 27

#---------------- AUTO LOAD---------------"
def AirFresh()
	exec "AirlineRefresh"
enddef

autocmd InsertEnter * AirFresh()
autocmd InsertLeave * AirFresh()
autocmd TabLeave * AirFresh()

autocmd VimEnter * ReBase()
def ReBase()
	var w = expand("%:p:h")
	if isdirectory(w)
		exec "cd" "%:p:h"
	endif
enddef

#--------------- FONCTION ---------------"

def g:Save()
	silent w!
	echo "saving ..."
	silent NERDTreeRefreshRoot
	redraw
	echo "save ! " .. expand('%c')
enddef

def g:Quit()
	q!
enddef


command -nargs=+ -bar MakeHeader :call FctsToHeader( split('<args>') )

#TODO
def FctsToHeader(...itemlist: list<string>)
	for files_input in itemlist
		var f = files_input
		exec ":r !IFS=$'\\n'; for fct in $(cat "files_input" | grep -Eo \"^[a-z].*)$\" | grep -v \"[^*a-z\_]main(\" | grep -v \"^static\"); do echo \"$fct;\"; done"
	endfor
enddef

command -nargs=+ -bar Make :call Make( '<args>' )

def g:Make(rules: string)
	silent exec "!clear -x"
	 setenv('rulesmake', rules)
	! supramake $rulesmake
enddef

def VerifMake()
	setenv('rulesmake', 'valanocompileabcsupra')
	! supramake $rulesmake
enddef

def g:CompileRun()
	if &filetype == 'nerdtree' || &filetype == 'vim'
		echo "Fenetre non compilable"
		return
	endif
	w!
	exec "cd" "%:p:h"
	silent VerifMake()
	var err = v:shell_error
	if err != 42
		g:Make('run')
	else
		!clear -x
		var ext = expand('%:e')
		if ext == 'c' || ext == 'h'
			exec "!gcc -g \"%:p:h/\"*.c -o a.out && valgrind --leak-check=full --show-leak-kinds=all -q ./a.out"
		#*cflags* 			exec "!gcc -g -Wall -Wextra -Werror \"%:p:h/\"*.c -o a.out && valgrind --leak-check=full --show-leak-kinds=all -q ./a.out"
		elseif ext == 'cpp' || ext == 'hpp'
			exec "!g++ -g \"%:p:h/\"*.cpp -o a.out && valgrind --leak-check=full --show-leak-kinds=all -q ./a.out"
		elseif ext == 'sh'
			exec "!time bash %"
		elseif ext == 'py'
			exec "!time python3 %"
		elseif ext == 'vala' || ext == 'vapi'
			exec "!valac %:p:h/*.vala --pkg=posix -o a.out && ./a.out"
		endif
	endif
	exec "redraw!"
enddef

def g:Compile()
	w!
	exec "cd" "%:p:h"
	silent exec "!clear -x"

	g:Make('all')
	var err = v:shell_error
	if err != 0
		var ext = expand('%:e')
		if ext == 'c' || ext == 'h'
			exec "!gcc -g \"%:p:h/\"*.c -o a.out"
		#*cflags* 		exec "!gcc -g -Wall -Wextra -Werror \"%:p:h/\"*.c -o a.out"
		elseif ext == 'cpp' || ext == 'hpp'
			exec "!g++ -g \"%:p:h/\"*.cpp -o a.out ; ./a.out"
		elseif ext == 'sh'
			exec "!time bash %"
		elseif ext == 'py'
			exec "!time python3 %"
		elseif ext == 'vala' || ext == 'vapi'
			exec "!valac %:p:h/*.vala --pkg=posix -o a.out"
		endif
	endif
	exec "redraw!"
enddef

imap <C-F5>		<esc>:Gdbs<CR>
map <C-F5>		<esc>:Gdbs<CR>

command -nargs=0 -bar Gdbs :call Gdbf()

def g:Gdbf()
	if &filetype != 'c' && &filetype != 'cpp' && &filetype != 'vala' && &filetype != 'hpp'
		echo "Tu veux débugguer quoi là ?"
	else
		set splitbelow nosplitbelow
		set splitright nosplitright
		silent g:Compile()
		exec ":NERDTreeTabsClose"
		if !filereadable("Makefile")
			exec ":Termdebug -n ./a.out"
		else
			exec ":Termdebug -n"
		endif
	endif
	set splitbelow
	set splitright
enddef               
# -------------- Ctags ----------------"

command -nargs=0 -bar Ctags :call Ctags()

set tags=$HOME/.local/bin/tags

def g:Ctags()
	system("vala $HOME/.local/bin/SupraVim/bin/tags.vala --pkg=posix --run-args=" .. expand('%:e'))
enddef

# -------------- SupraNorm ----------------"
highlight DapBreakpoint ctermfg=135
sign define NormLinter text=\ ✖ texthl=DapBreakpoint

g:norm_activate = true

def g:ToggleNorm()
	g:norm_activate = !g:norm_activate
	silent w!
	if g:norm_activate == true
		silent! echo ""
		echo "[SupraNorm enabled]"
	else
		silent! echo ""
		echo "[SupraNorm disabled]"
	endif
enddef

def GetErrors(filename: string): list<any>
	var retsys = system("norminette \"" .. filename .. "\"")
	var norm_errors = retsys->split("\n")
	var regex = 'Error: \([A-Z_]*\)\s*(line:\s*\(\d*\), col:\s*\(\d*\)):\t\(.*\)'
	var errors = []
	for s in norm_errors
		if s =~# regex
			var groups = matchlist(s, regex)
			groups = [groups[1], groups[2], groups[3], groups[4]]
			add(errors, groups)
		endif
	endfor
	return errors
enddef

g:errors = []

def HighlightNorm(filename: string)
	if g:norm_activate == true
		g:errors = GetErrors(filename)
	endif
	hi def link NormErrors Underlined
	sign unplace *
		if g:norm_activate == true
	for error in g:errors
		if error[3] == "Missing or invalid 42 header"	#HEADER
			continue									#HEADER
			endif										#HEADER
			exe ":sign place 2 line=" .. error[1] " name=NormLinter file=" .. filename
	endfor
		endif
enddef

def DisplayErrorMsg()
	if g:norm_activate == true
		for error in g:errors
			if line(".") == str2nr(error[1])
				echo "[Norminette]: " .. error[3]
				break
			else
				echo ""
			endif
		endfor
	endif
enddef

def GetErrorDict(filename: string): list<string>
	var errors = GetErrors(filename)
	var error_dict = {}
	for error in errors
		eval error_dict->extend({error[1] : error[3]})
	endfor
	return errors
enddef

command Norm HighlightNorm(expand("%"))
autocmd CursorMoved *.c,*.h DisplayErrorMsg()
autocmd BufEnter,BufWritePost *.c,*.h Norm
# autocmd BufLeave *.c,*.h call clearmatches("NormErrors")

# -------------- COLORS FILE ----------------"
def NERDTreeHighlightFile(extension: string, fg: string, bg: string)
	exec 'autocmd filetype nerdtree highlight ' .. extension .. ' ctermbg=' .. bg .. ' ctermfg=' .. fg
	exec 'autocmd filetype nerdtree syn match ' .. extension .. ' #^\s\+.*' .. extension .. '$#'
enddef

NERDTreeHighlightFile('.c', 'blue', 'none')
NERDTreeHighlightFile('h', 'green', 'none')
NERDTreeHighlightFile('.cpp', 'blue', 'none')
NERDTreeHighlightFile('.hpp', 'green', 'none')
NERDTreeHighlightFile('vala', 'magenta', 'none')
NERDTreeHighlightFile('vapi', 'darkmagenta', 'none')
NERDTreeHighlightFile('py', 'yellow', 'none')
NERDTreeHighlightFile('java', 'red', 'none')
NERDTreeHighlightFile('sh', 'green', 'none')
NERDTreeHighlightFile('go', 'cyan', 'none')
NERDTreeHighlightFile('Makefile', 'red', 'none')

augroup nerdtreeconcealbrackets
	autocmd!
	autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=ALL
	autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=ALL
augroup END

# ----------------- AIR LINE ------------------"
g:airline_section_z = airline#section#create(['%p/100%%', ' Line: %l', 'hunks', ' Col:%c', ' SupraVim'])
if expand('%:e') == ''
	g:airline_section_warning = airline#section#create(['SupraVim'])
	g:airline_section_z = airline#section#create(['%p/100%%', ' Line: %l', 'hunks', ' Col:%c'])
	g:airline_section_b = airline#section#create([' im'])
endif
g:airline_section_b = airline#section#create([' im'])
g:airline_left_sep = ''
g:airline_left_alt_sep = ''
g:airline_right_sep = ''
g:airline_right_alt_sep = ''
g:airline#extensions#tabline#enabled = 1
g:airline#extensions#tabline#show_buffers = 0
g:airline#extensions#tabline#tabs_label = 'Tabs'
g:airline#extensions#tabline#buffer_nr_show = 0
g:airline#extensions#tabline#tab_nr_type = 1
g:airline#extensions#tabline#left_sep = ''
g:airline#extensions#tabline#left_alt_sep = ''
g:airline#extensions#tabline#right_sep = ''
g:airline#extensions#tabline#right_alt_sep = ''

# ----------------- POPUP ------------------ #
autocmd InsertEnter * CreatePop()
autocmd VimEnter * CreatePopit()
hi MyPopupColor ctermfg=cyan

autocmd VimLeave * RemovePopit()

def CreatePopit()
	var s = system("supravim --version cached > /tmp/xdfe-" .. g:file_tmp .. "&")
enddef

def RemovePopit()
	var s = system("rm -f /tmp/xdfe-" .. g:file_tmp)
enddef

g:file_tmp = system("strings -n 1 < /dev/urandom | grep -o '[[:alpha:][:digit:]]' | head -c15 | tr -d '\n'")
g:step = false

def CreatePop()
    if g:step == true
        return
    endif
    g:step = true
    var s = system("cat /tmp/xdfe-" .. g:file_tmp .. " ; rm /tmp/xdfe-" .. g:file_tmp)                                                                                                                                                                
    if s == ""
        return
    endif
    popup_create([ strpart("       ", 0, len(s) / 2 - 7) .. "Supravim update", s ], {line: 1, col: 500, pos: 'topright', time: 5000, tabpage: -1, zindex: 300, drag: 1, highlight: 'MyPopupColor', border: [], close: 'click', padding: [0, 1, 0, 1], })
enddef

if executable('clangd')
	au User lsp_setup call lsp#register_server({
				\ name: 'clangd',                                              
				\ cmd: (server_info) => ['clangd', '--clang-tidy', '-j', '8'],
				\ allowlist: ['cpp', 'c'],
				\ })
endif

if executable('vala-language-server')
	au User lsp_setup call lsp#register_server({
				\ name: 'vala-language-server',                                              
				\ cmd: (server_info) => ['vala-language-server'],
				\ allowlist: ['vala'],
				\ })
endif


def g:InstallclangD(where: string)
	if (where == 'user')
		terminal supravim server user
	else
		terminal supravim server
	endif
enddef

command -nargs=+ -bar InstallClangd :call g:InstallclangD( '<args>' )

imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

g:lsp_log_file = '/tmp/lsp_supravim-' .. expand('$USER') .. '.log'
g:lsp_diagnostics_enabled = 0
g:lsp_diagnostics_signs_enabled = 0
g:lsp_document_code_action_signs_enabled = 0
g:lsp_diagnostics_signs_delay = 1
g:lsp_diagnostics_signs_priority = 0
g:lsp_diagnostics_signs_insert_mode_enabled = 0
g:lsp_tagfunc_source_methods = []
g:vsnip_snippet_dir = '$HOME/.local/bin/SupraVim/snippets'
