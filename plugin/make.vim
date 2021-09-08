if exists("loaded_make")
    finish
endif
let loaded_make = 1

let s:save_cpoptions = &cpoptions
set cpoptions&vim

function! s:RootBuild()
    " Change directory to the root of the repository
    let [vcs, root, branch] = vcvars#CVcVars()
    execute('cd '.l:root)

    " Call make after setting compiler appropriately
    if filereadable("Makefile")
        echom "make"
        compiler! gcc
        make
    endif
    if filereadable("build.xml")
        compiler! ant
        make
    endif
endfunction

noremap <unique> <script> <Plug>RootBuild <SID>RootBuild
noremap <SID>RootBuild :call <SID>RootBuild()<cr>
noremenu <script> Plugin.RootBuild <SID>RootBuild
command! -nargs=0 RootBuild call s:RootBuild()

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
