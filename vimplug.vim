" =============================================================
" 插件管理配置项
" =============================================================

" $VIM  vim安装路径
" $HOME  用户目录  /home/$User
" $VIMRUNTIME $VIM/vim81

set nocompatible
filetype off " required! turn off

" ####### 分组管理

if !exists('g:plug_groups')
    " let g:plug_groups=['python', 'javascript', 'golang', 'php', 'ruby', 'shell', 'markdown', 'html', 'css', 'less', 'coffeescript', 'tmux', 'json', 'beta']
    let g:plug_groups=['erlang', 'markdown', 'html', 'css', 'tmux', 'beta', 'golang']
endif

" =============================================================
" 使用 vim-plug 管理插件
" =============================================================

call plug#begin('~/.vim/plugged')

" 移动光标到插件名上, 使用'#'快速跳转到每个插件的配置处

" syntastic
if v:version < 800
    Plug 'scrooloose/syntastic'         " 通用语法检查
else
    Plug 'w0rp/ale'                     " 异步语法检查
" Plug 'sheerun/vim-polyglot'             " 语法高亮/缩进语言包集合
endif

" Group dependencies, vim-snippets depends on ultisnips
" 代码片段快速插入 (snippets中,是代码片段资源,需要学习)
" Snippets are separated from the engine. Add this if you want them:
" Plug 'honza/vim-snippets'               " 代码片段集合
Plug 'Raimondi/delimitMate'             " 自动补全括号等

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                 " 异步模糊搜索插件  必须先装fzf插件

" Plug 'vim-scripts/L9'
Plug 'vim-airline/vim-airline'          " 美化导航栏
Plug 'vim-airline/vim-airline-themes'   " 导航栏主题
"更高效的移动 [,, + w/fx/h/j/k/l]
Plug 'easymotion/vim-easymotion'        " 快速跳转工具
" Plug 'rking/ag.vim'                     " 高速文件内容搜索，需要先安装'ag(the_silver_searcher)'命令
Plug 'maralla/completor.vim'            " 智能提醒
Plug 'Yggdroot/indentLine'              " 显示缩进 “线”
Plug 'scrooloose/nerdcommenter'         " 快速注释
Plug 'scrooloose/nerdtree',{ 'on':  'NERDTreeToggle' } " 文件管理树 r 刷新
Plug 'Xuyuanp/nerdtree-git-plugin'      " nerdtree 显示 git 最新修改标志
Plug 'joshdick/onedark.vim'             " 配色方案 onedrak
Plug 'mhinz/vim-signify'
Plug 'airblade/vim-gitgutter'           " 显示git差异  [c ]c 跳转 差异位置
Plug 'tpope/vim-fugitive'               " vim 操作 git 并显示分支

Plug 'luochen1990/rainbow'              " 括号颜色
Plug 'mhinz/vim-startify'               " 初始化界面


if count(g:plug_groups, 'markdown')
    

    "
    " Requirements
    " * MichaelMure/mdr or specified markdown parser
    " *Vim 8.1.1401 ~
    " 按需加载 markdown
    Plug 'skanehira/preview-markdown.vim', {'for' : 'markdown'} 
endif

" go 语言加载项
if count(g:plug_groups, 'golang')
    " 1. vim a.go
    " 2. :GoInstallBinaries
    " vimgo  https://github.com/fatih/vim-go
    "Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " GO语言辅助包
    Plug 'fatih/vim-go', {'for': 'go'}
endif

" go 语言加载项
if count(g:plug_groups, 'erlang')
    Plug 'vim-erlang/vim-erlang-omnicomplete' " 语法提示
    Plug 'vim-erlang/vim-erlang-tags'
    Plug 'ten0s/syntaxerl'                  " erlang语法检查工具
" Plug 'vim-erlang/vim-erlang-compiler' " erlang 同步语法检查工具（保存触发
endif


call plug#end()


" ==== [ 插件: vim=indent=guides ] ======================================
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" ==== [ 插件 scrooloose/nerdcommenter ] ================================
" <leader>cc   加注释
" <leader>cu   解开注释
" <leader>ca 切换注释的样式:/*....*/和//..的切换
" <leader>c<space>  加上/解开注释, 智能判断
let g:NERDSpaceDelims = 1        " 在注释后加空格
let g:NERDToggleCheckAllLines = 1   " 检查选中行是否已注释
" 自定义注释
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' }, 'erlang': {'left' : '%%' } }
let g:NERDDefaultAlign = 'left'         " 设置注释对齐方式 (左对齐) 方便删除
" ctrl + / 快速注释 （ctrl + / 映射为 ctrl + _）
map <C-/> <Plug>NERDCommenterToggle

" 插件 scroloose/nerdtree =====================================
nmap <f2> :NERDTreeToggle<cr>
nmap <C-t> :NERDTreeToggle<CR>
imap <F2> <esc>:NERDTreeToggle<CR>
imap <C-t> <esc>:NERDTreeToggle<CR>

" let NERDTreeShowHidden=1            " 设置显示隐藏文件
let NERDTreeIgnore=[ '\.(swp|svn|pyc)$' ,'\.(png|dll|so|exe)$' , '\.(git|svn)' , '\.(beam)']

" ==== [ 插件 junegunn/fzf ] =======================================
let g:fzf_layout = {'down': '~20%'}
set rtp+=~/.fzf
noremap <leader>f :FZF
" 快速启动Ag rg搜索
noremap <leader>fa :Ag
noremap <leader>fr :Rg

" 快速搜索工作区

" ==== [ 插件 w0rp/ale ] =====================================
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_lint_delay=500                " 延时编译
" let g:ale_maximun_file_size=1048576     " 设置检查文件最大
let g:ale_lint_on_enter=0               " 打开文件不制动编译
" let g:ale_sign_column_always=1
" let g:ale_open_list=1
" 设置使用不同的编译工具检查代码
let g:ale_linters = { 'erlang': ['syntaxerl'], }

" ==== [插件 airline ] =========================================
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
" ==== [ 插件 completor ] ====================================
let g:completor_erlang_omni_trigger = '[\w=]+:$'
let g:completor_complete_options = 'menuone,noselect'

" ==== [ luochen1990/rainbow] ================================
let g:rainbow_active=1

" ==== [ mhinz/vim=signify ] ================================
let g:signify_update_on_bufenter    = 0     " 缓冲区被修改时更新符号
let g:signify_update_on_focusgained = 1     " vim获取焦点时更新符号
nnoremap <leader>gr :SignifyRefresh<CR>
nmap <leader>gj <plug>(signify=next=hunk)
nmap <leader>gk <plug>(signify=prev=hunk)

" ==== [ easymotion/vim=easymotion ] ================================
map <Leader><leader>h <Plug>(easymotion=linebackward)
map <Leader><leader>l <Plug>(easymotion=lineforward)


