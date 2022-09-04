source $VIMRUNTIME/vimrc_example.vim

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

" ============= General Configuration ============
set nobackup                          " do not keep a backup file
set noundofile                        " do not keep an undo file
set guioptions-=m                     " remove menu bar
set guioptions-=T                     " remove toolbar

set encoding=utf-8                    " 编码
set langmenu=zh_CN.UTF-8

source $VIMRUNTIME/delmenu.vim        " 解决菜单乱码
source $VIMRUNTIME/menu.vim

language messages zh_CN.utf-8         " 设置中文提示
set helplang=cn                       " 设置中文帮助

set guifont=Powerline_Consolas:h14    " 设置字体
set number                            " 设置行号
set cursorline                        " 突出显示当前行

set tabstop=4        " 设置Tab长度,默认为8
set softtabstop=4    " 退格键退回缩进空格的长度
set shiftwidth=4     " 表示每一级缩进的长度
set expandtab        " 设置缩进用空格表示
%retab!
set autoindent       " 自动缩进

syntax on            " 语法高亮
set t_Co=256
colorscheme molokai  " 主题

" =================== Vundle ====================
" Vundle 配置
set nocompatible       " required 关闭vi兼容模式
filetype off           " required

" set the runtime path to include Vundle and initialize
set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
let path='$VIM/vimfiles/bundle'
call vundle#begin(path)

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Add all your plugins here
" 以下用来支持不同格式的插件安装
" 请将安装插件的命令放在 vundle#begin() 和 vundle#end() 之间
" 格式为 Plugin '用户名/插件仓库名'
Plugin 'vim-airline/vim-airline'
  " 使用powerline的字体
  let g:airline_powerline_fonts = 1
  " 设置主题
  let g:airline_theme="dark"
  " 开启tabline
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#buffer_nr_show = 1
  " 关闭状态显示空白符号计数
  let g:airline#extensions#whitespace#enabled = 0
  let g:airline#extensions#whitespace#symbol = '!'
  " 映射切换buffer的键位
  nnoremap <C-N> :bn<CR>
  nnoremap <C-P> :bp<CR>
  nnoremap <C-D> :bd<CR>
  " 设置为双字宽显示
  set ambiwidth=double
  " 总是显示状态栏
  let laststatus = 2

Plugin 'scrooloose/nerdcommenter'
  let g:NERDSpaceDelims=1
  let mapleader=","
  set timeout timeoutlen=1500

Plugin 'scrooloose/nerdtree'
  map <C-T> :NERDTreeToggle<CR>

Plugin 'Valloric/YouCompleteMe'

Plugin 'jiangmiao/auto-pairs'

" All of your Plugins must be added before the following line
call vundle#end()          " required
filetype plugin indent on  " required 加载vim自带和插件相应的语法和文件类型相关脚本
