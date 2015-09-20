" ctags
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
"let Tlist_Close_On_Select=1
let Tlist_Auto_Update=1 " Update the tag list automatically
set cscopequickfix=s-,c-,d-,i-,t-,e-

" omnicppcomplete
set nocp  
filetype plugin on

" add nodetree
let g:NERDTree_title="[NERDTree]"  
let g:winManagerWindowLayout="NERDTree|TagList"  
  
let g:miniBufExplMapWindowNavVim = 1   
let g:miniBufExplMapWindowNavArrows = 1   
let g:miniBufExplMapCTabSwitchBufs = 1   
let g:miniBufExplModSelTarget = 1  
let g:miniBufExplMoreThanOne=0 

function! NERDTree_Start()  
    exec 'NERDTree'  
endfunction  
  
function! NERDTree_IsValid()  
    return 1  
endfunction  
  
nmap wm :WMToggle<CR>  
