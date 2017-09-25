" Vimrc file Thomas Lutz

set nocompatible                                            " use vim defaults

set number                                                  " show line numbers
set mouse=a                                                 " activate mouse
set hlsearch                                                " highlight searches
set bg=dark                                                 " improve for dark background

set ls=2                                                    " always show status line
set tabstop=4                                               " numbers of spaces of tab character
set shiftwidth=4                                            " numbers of spaces to (auto)indent
set expandtab                                               " replace tab with spaces
set scrolloff=3                                             " keep 3 lines when scrolling

"set rtp+=/usr/share/powerline/bindings/vim                  " set powerline bindings
"set laststatus=2                                            " powerline related
"set showtabline=1                                           " powerline related
"set noshowmode                                              " powerline related
set t_Co=256                                                " enable 256 colors

set list                                                    " show white spaces
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<     " define white spaces

set nobackup                                                " do not keep a backup file
set visualbell                                              " turn on visual bell
set showcmd                                                 " display incomplete commands
set incsearch                                               " do incremental searching
set ruler                                                   " show the cursor position all the time
set ignorecase                                              " ignore case when searching
"set noignorecase                                            " don't ignore case
set title                                                   " show title in console title bar
set ttyfast                                                 " smoother changes

set ttymouse=xterm2                                         " correct mouse for linux screen command

set dictionary+=/usr/share/dict/words                       " set default dictionary
set dictionary+=/usr/share/dict/ngerman                     " set add German dictionary

"set spell                                                   " activate spell checker

"set autoindent                                              " always set autoindenting on
set noautoindent
"set smartindent                                             " smart indent
set nosmartindent
"set cindent                                                 " cindent
set nocindent

set sm                                                      " show matching braces

syntax on                                                   " syntax highlighing
colorscheme elflord                                         " use elflord color scheme

autocmd BufEnter * cd %:p:h                                 " auto switch to folder where editing file

" Restore cursor position
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" FileType cpp,c,java,sh,pl,php,phtml,asp  set autoindent
"au FileType cpp,c,java,sh,pl,php,phtml,asp,xml,javascript  set smartindent
nnoremap <C-p> :set invpaste paste?<CR>
set pastetoggle=<C-p>
set showmode
"au FileType cpp,c,java,sh,pl,php,phtml,asp  set cindent

" Automatically chmod +x Shell and Perl scripts
au BufWritePost   *.sh             !chmod u+x %
au BufWritePost   *.pl             !chmod u+x %

" File formats
au BufNewFile,BufRead  *.phtml          set syntax=php
au BufNewFile,BufRead  *.pls            set syntax=dosini
au BufNewFile,BufRead  modprobe.conf    set syntax=modconf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" execute file editing with :make
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set makeprg=bash\ %                                         " sets default make to bash
"set makeprg=python\ %                                       " sets default make to python
set autowrite                                               " saves file before executing make command

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto completion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" set auto-highlighting of matching brackets for php only
autocmd FileType php DoMatchParen
autocmd FileType php hi MatchParen ctermbg=blue guibg=lightblue
