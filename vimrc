"**** SUPRAVIM ****"
set nocompatible
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
"--------------- jeu de couleur ---------------"
colorscheme gruvbox
set background=dark
set t_Co=256
" 1: gruvbox
" 2: molokai
" 3: dracula
" 4: atom
" 5: iceberg
" 6: onedark
" 7: onehalf
" 8: onelight

" icons_disabled

"-------------- Save Undo  ------------"
if !isdirectory($HOME."/.cache/vim/undo")
	call mkdir($HOME."/.cache/vim/", "", 0770)
	call mkdir($HOME."/.cache/vim/undo", "", 0770)
endif
set undodir=~/.cache/vim/undo
set undofile

" -------------  DBG integration  --------------"

packadd! termdebug
let g:termdebug_wide=1

"-------------- Auto Pairs ---------------------"
imap <silent><CR>				<CR><Plug>AutoPairsReturn

"--------------- Onglets ---------------------"
noremap <c-n>	<esc>:tabnew 
noremap <C-Right>				:tabnext<CR>
noremap <C-Left>				:tabprevious<CR>
inoremap <C-Right>				<esc>:tabnext<CR>
inoremap <C-Left>				<esc>:tabprevious<CR>

"--------------- Les racourcis ---------------"
noremap <C-Up>          <Esc>:call Ctags()<CR>g<C-}>
noremap <C-Down>        <Esc><C-T>
inoremap <C-Up>         <Esc>:call Ctags()<CR>g<C-}>i
inoremap <C-Down>       <Esc><C-T>i

inoremap <c-q>				<esc>:call Quit()<CR>
inoremap <c-s>				<esc>:call Save()<CR>
noremap <c-q>				<esc>:call Quit()<CR>
noremap <c-s>				<esc>:call Save()<CR>
map <C-F5> 					:Termdebug -n <CR>
map <F5> 					:call CompileRun()<CR>
imap <F5>				 	<Esc>:call CompileRun()<CR>
map <F6> 					:call Make("run2")<CR>
imap <F6>				 	<Esc>:call Make("run2")<CR>
map <F7> 					:call Make("run3")<CR>
imap <F7>				 	<Esc>:call Make("run3")<CR>
noremap <C-d>				:vs 
noremap <S-d>				:split 
noremap <F3>				<Esc>:call ToggleNorm()<CR>
inoremap <F3>				<Esc>:call ToggleNorm()<CR>i
noremap <S-Right>			<C-w><Right><Esc>:AirlineRefresh<CR>
noremap <S-Left>			<C-w><Left><Esc>:AirlineRefresh<CR>
noremap <S-Up>				<C-w><Up><Esc>:AirlineRefresh<CR>
noremap <S-Down>			<C-w><Down><Esc>:AirlineRefresh<CR>

inoremap <TAB>				<TAB>
imap <C-g>					<esc>:NERDTreeTabsToggle<CR>
map <C-g>					:NERDTreeTabsToggle<CR>
map <S-T> <Esc>:term ++rows=15<CR>

"---------------      Terminal        ---------------"
tnoremap <C-q> q<CR>
tnoremap <F3> clear -x ; norminette<CR>
tnoremap <F5> clear -x; if [ -f Makefile ] \|\| [ -f ../Makefile ]; then [ -f Makefile ] && make all && make run; [ -f ../Makefile ] && make all -C ../ && make run -C ../; else gcc *.c; ./a.out; fi; <CR>
"*cflags* tnoremap <F5> clear -x; if [ -f Makefile ] \|\| [ -f ../Makefile ]; then [ -f Makefile ] && make all && make run; [ -f ../Makefile ] && make all -C ../ && make run -C ../; else gcc -Wall -Wextra -Werror *.c; ./a.out; fi; <CR>
tnoremap <F6> clear -x; if [ -f Makefile ] \|\| [ -f ../Makefile ]; then [ -f Makefile ] && make all && make run2; [ -f ../Makefile ] && make all -C ../ && make run2 -C ../; else gcc *.c; ./a.out; fi; <CR>
"*cflags* tnoremap <F6> clear -x; if [ -f Makefile ] \|\| [ -f ../Makefile ]; then [ -f Makefile ] && make all && make run2; [ -f ../Makefile ] && make all -C ../ && make run2 -C ../; else gcc -Wall -Wextra -Werror *.c; ./a.out; fi; <CR>

tnoremap <S-Right>		<C-W>N<C-w><Right><Esc>:AirlineRefresh<CR>
tnoremap <S-Left>		<C-W>N<C-w><Left><Esc>:AirlineRefresh<CR>
tnoremap <S-Up>			<C-W>N<C-w><Up><Esc>:AirlineRefresh<CR>
tnoremap <S-Down>		<C-W>N<C-w><Down><Esc>:AirlineRefresh<CR>

"--------------- utilitaires basiques ---------------"
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
set encoding=utf-8
set splitbelow
set splitright
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
let g:UltiSnipsExpandTrigger="<Tab>"
set fillchars=vert:│
" set noswapfile
"---------- Qui utilise la scrollbar -----------"
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

"------------------ Snipets --------------------"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

"--------------- CLANG COMPLETER ---------------"
set noinfercase
set completeopt-=preview
set completeopt+=menuone,noselect
let g:mucomplete#enable_auto_at_startup = 1

"--------------- SYNTASTIC ---------------"
let current_compiler = "clang"
let g:rainbow_active = 1

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++98 -Wall -Wextra'
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_c_remove_include_errors = 1
let g:syntastic_c_include_dirs = ['../../../include','../../include','../include','./include', '../../../includes', '../../includes', '../includes', './includes', './libft', '../libft', '../../libft', '../../../libft', './libft/include', '../libft/include', '../../libft/include']

"--------------- PL NERDTREE ---------------"
let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeIgnore = ['\.png$\','\.jpg$','\.o$']
let g:NERDTreeWinSize = 27
"---------------- AUTO LOAD---------------"
func! AirFresh()
	exec "AirlineRefresh"
endfunc                                        

autocmd InsertEnter * call AirFresh()
autocmd InsertLeave * call AirFresh()
autocmd TabLeave * call AirFresh()

autocmd VimEnter * call ReBase()
func ReBase()
	let w = expand("%:p:h")
	echo w
	if isdirectory(w)
		exec "cd" "%:p:h"
	endif
endfunc

"--------------- FONCTION ---------------"

function Save()
	w!
	NERDTreeRefreshRoot
	AirlineRefresh
endfunction

function Quit()
	q!
endfunction

imap <C-F5>		<esc>:Gdbs<CR>
map <C-F5>		<esc>:Gdbs<CR>

command -nargs=0 -bar Gdbs :call Gdbf()
func! Gdbf()
	if &filetype != 'c' && &filetype != 'cpp' && &filetype != 'vala' && &filetype != 'hpp'
		echo "Tu veux débugguer quoi là ?"
	else
		set splitbelow nosplitbelow
		set splitright nosplitright
		silent call Compile()
		exec ":NERDTreeTabsClose"
		if !filereadable("Makefile")
			exec ":Termdebug -n ./a.out"
		else
			exec ":Termdebug -n"
		endif
	endif
	set splitbelow
	set splitright
endfunc               

command -nargs=+ -bar MakeHeader :call FctsToHeader( split('<args>') )

func! FctsToHeader(...)
	for files_input in a:000[0]
		let $f=files_input
		exec ":r !IFS=$'\\n'; for fct in $(cat "files_input" | grep -Eo \"^[a-z].*)$\" | grep -v \"[^*a-z\_]main(\" | grep -v \"^static\"); do echo \"$fct;\"; done"
	endfor
endfunc                                  

func! Norminette()
	call Save()
	silent exec "!clear -x"
	exec "!echo Norminette de % && norminette \"%\""
endfunc

command -nargs=+ -bar Make :call Make( '<args>' )

func! Make(rules)
	silent exec "!clear -x"
	let $rulesmake = a:rules
	! vala $HOME/.local/bin/SupraVim/bin/make.vala --pkg=posix --run-args=$rulesmake
endfunc

func! VerifMake()
	let $rulesmake = 'valanocompileabcsupra'
	! vala $HOME/.local/bin/SupraVim/bin/make.vala --pkg=posix --run-args=$rulesmake
endfunc

func! CompileRun()
	if &filetype == 'nerdtree' || &filetype == 'vim'
		echo "Fenetre non compilable"
		return
	endif
	w!
	exec "cd" "%:p:h"
	silent call VerifMake()
	let err = v:shell_error
	if err != 42
		call Make('run')
	else
		let ext = expand('%:e')
		if ext == 'c' || ext == 'h'
			exec "!gcc -g \"%:p:h/\"*.c -o a.out && valgrind --leak-check=full --show-leak-kinds=all -q ./a.out"
			"*cflags* 			exec "!gcc -g -Wall -Wextra -Werror \"%:p:h/\"*.c -o a.out && valgrind --leak-check=full --show-leak-kinds=all -q ./a.out"
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
endfunc

func! Compile()
	w!
	exec "cd" "%:p:h"
	silent exec "!clear -x"

	let err = Make('all')
	if err != 0
		let ext = expand('%:e')
		if ext == 'c' || ext == 'h'
			exec "!gcc -g \"%:p:h/\"*.c -o a.out"
			"*cflags* 		exec "!gcc -g -Wall -Wextra -Werror \"%:p:h/\"*.c -o a.out"
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
endfunc

" -------------- Ctags ----------------"

command -nargs=0 -bar Ctags :call Ctags()

set tags=$HOME/.local/bin/tags
func! Ctags()
	let ret = system("vala $HOME/.local/bin/SupraVim/bin/tags.vala --pkg=posix --run-args=" . expand('%:e'))
endfunc

" -------------- SupraNorm ----------------"

highlight DapBreakpoint ctermfg=135

sign define NormLinter text=\ ✖ texthl=DapBreakpoint
let g:syntastic_error_symbol='\ ✖'
let g:syntastic_warning_symbol='\ ✖'

let g:norm_activate = 1
"*norme* let g:norm_activate = 0

function ToggleNorm()
	let g:norm_activate = !g:norm_activate
	silent exe ":w!"
	if g:norm_activate == 1
		silent! echo ""
		echo "[SupraNorm enabled]"
	else
		silent! echo ""
		echo "[SupraNorm disabled]"
	endif
endfunction

function GetErrors(filename)
	let norm_errors = system("norminette \"" .a:filename ."\"")
	let norm_errors = norm_errors->split("\n")
	let regex = 'Error: \([A-Z_]*\)\s*(line:\s*\(\d*\), col:\s*\(\d*\)):\t\(.*\)'
	let errors = []
	for s in norm_errors
		if s =~# regex
			let groups = matchlist(s, regex)
			let groups = [groups[1], groups[2], groups[3], groups[4]]
			call add(errors, groups)
		endif
	endfor
	return errors
endfunction

function HighlightNorm(filename)
	call clearmatches("NormErrors")
	if g:norm_activate == 1
		let g:errors = GetErrors(a:filename)
	endif
	hi def link NormErrors Underlined
	sign unplace *
	if g:norm_activate == 1
		for error in g:errors
			if error[3] == "Missing or invalid 42 header"	"HEADER
				continue									"HEADER
			endif											"HEADER
			exe ":sign place 2 line=".error[1] " name=NormLinter file=" .a:filename
		endfor
	endif
endfunction

function DisplayErrorMsg()
	if g:norm_activate == 1
		for error in g:errors
			if line(".") == error[1]
				echo "[Norminette]: "error[3]
				break
			else
				echo ""
			endif
		endfor
	endif
endfunction

function GetErrorDict(filename)
	let errors = GetErrors(a:filename)
	let error_dict = {}
	for error in errors
		eval error_dict->extend({error[1] : error[3]})
	endfor
	return error_dict
endfunction

function! s:empty_message(timer)
	echo ""
endfunction

command Norm call HighlightNorm(expand("%"))
autocmd CursorMoved *.c,*.h call DisplayErrorMsg()
autocmd BufEnter,BufWritePost *.c,*.h Norm
autocmd BufLeave *.c,*.h call clearmatches("NormErrors")

" -------------- COLORS FILE ----------------"
function! NERDTreeHighlightFile(extension, fg, bg)
	exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg
	exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('.c', 'blue', 'none')
call NERDTreeHighlightFile('h', 'green', 'none')
call NERDTreeHighlightFile('.cpp', 'blue', 'none')
call NERDTreeHighlightFile('.hpp', 'green', 'none')
call NERDTreeHighlightFile('vala', 'magenta', 'none')
call NERDTreeHighlightFile('Makefile', 'red', 'none')

augroup nerdtreeconcealbrackets
	autocmd!
	autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=ALL
	autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=ALL
augroup END

" ----------------- AIR LINE ------------------"
let g:airline_section_z = airline#section#create(['%p/100%%', ' Line: %l', 'hunks', ' Col:%c', ' SupraVim'])
if expand('%:e') == ''
	let g:airline_section_warning = airline#section#create(['SupraVim'])
	let g:airline_section_z = airline#section#create(['%p/100%%', ' Line: %l', 'hunks', ' Col:%c'])
	let g:airline_section_b = airline#section#create([' im'])
endif
let g:airline_section_b = airline#section#create([' im'])
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
" Activer le plugin airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tabs_label = 'Tabs'
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" ----------------- POPUP ------------------"
autocmd InsertEnter * call CreatePop()
autocmd VimEnter * call CreatePopit()
hi MyPopupColor ctermfg=cyan 

autocmd VimLeave * call RemovePopit()

func! CreatePopit()
	let s = system("supravim --version cached > /tmp/xdfe-". g:file_tmp ."&")
endfunc

func! RemovePopit()
	let s = system("rm -f /tmp/xdfe-". g:file_tmp)
endfunc

let g:file_tmp = system("strings -n 1 < /dev/urandom | grep -o '[[:alpha:][:digit:]]' | head -c15 | tr -d '\n'")
let g:step=0
func! CreatePop()
	if g:step == 1
		return
	endif
	let g:step=1

	let s = system("cat /tmp/xdfe-". g:file_tmp . " ; rm /tmp/xdfe-" . g:file_tmp)
	if s == ""
		return
	endif
	call popup_create([ "Supravim update", s ], #{ 
				\ line: 1, 
				\ col: 500,
				\ pos: 'topright',
				\ time: 5000, 
				\ tabpage: -1, 
				\ zindex: 300, 
				\ drag: 1, 
				\ highlight: 'MyPopupColor',
				\ border: [], 
				\ close: 'click', 
				\ padding: [0,1,0,1], 
				\ }) 
endfunc                                                   

if executable('clangd')
	au User lsp_setup call lsp#register_server({
				\ 'name': 'clangd',
				\ 'cmd': {server_info->['clangd', '--clang-tidy', '-j', '8']},
				\ 'allowlist': ['cpp', 'c'],
				\ })
endif

if executable('vala-language-server')
	au User lsp_setup call lsp#register_server({
				\ 'name': 'vala-language-server',
				\ 'cmd': {server_info->['vala-language-server']},
				\ 'allowlist': ['vala'],
				\ })
endif


function! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete
	nmap <buffer> gd <plug>(lsp-definition)
	nmap <buffer> gs <plug>(lsp-document-symbol-search)
	nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
	nmap <buffer> gr <plug>(lsp-references)
	nmap <buffer> gi <plug>(lsp-implementation)
	nmap <buffer> gt <plug>(lsp-type-definition)
	nmap <buffer> <leader>rn <plug>(lsp-rename)
	nmap <buffer> [g <plug>(lsp-previous-diagnostic)
	nmap <buffer> ]g <plug>(lsp-next-diagnostic)
	nmap <buffer> K <plug>(lsp-hover)

	let g:lsp_format_sync_timeout = 1000

endfunction

augroup lsp_install
	au!
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

let g:lsp_log_file = '/tmp/lsp_supravim-' . expand('$USER') . '.log'
let lsp_diagnostics_enabled=0
let g:lsp_diagnostics_signs_enabled = 0
let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_diagnostics_signs_delay = 1
let g:lsp_diagnostics_signs_priority = 0
let g:lsp_diagnostics_signs_insert_mode_enabled = 0
let g:lsp_tagfunc_source_methods = []
let g:vsnip_snippet_dir='$HOME/.local/bin/SupraVim/snippets'

