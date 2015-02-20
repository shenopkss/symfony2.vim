
"controller跳转view
function! GotoView()
    execute "normal!" . '?\vfunction \w+Action\(.*\)' . "\<CR>"
    "execute "normal!" . '/\vrender\([''"](\w+)' . "\<CR>"
    execute "normal!" . '/\v:\w+:\w+\.html\.twig' . "\<CR>"
    execute "normal! lv7why"
    "normal! /render(['"]\(\w\+\):\(\w\+\):\(\w\+\.html\.twig\)
    let action =  @@
    let action = join(split(action, ":"), "/")
    let sourcePath = expand('%') 
    echo sourcePath
    let plist = split(sourcePath, "/")[0:-2]
    let path = join(plist, "/")

    execute "normal! " . ':e ' . path . '/../Resources/views/' . action . "\<CR>"
    let @@ = ""

endfunction

"routername goto action
function! GotoAction()
    let symfony_root = '/Users/shenopkss/Project/uco/oms/'
    execute "normal! ^"
    execute "normal! " . '/\vpath\(\s*[''"]' . "\<CR>"
    execute "normal! " . '2wyi'''
    let router =  @@
    "echo router
    let router_conf = system('php app/console router:debug ' . router . ' | grep _controller | awk ''{print $3}'' | sed ''s/\\/\//g''')
    "echo router_conf
    let routerArr = split(router_conf, "::")
    if len(routerArr) == 2
        execute "normal! " . ':e ' . symfony_root . "src/" . routerArr[0]  . '.php'  . "\<CR>"
        execute "normal!" . '/\vfunction\s+'. routerArr[1] . "\<CR>"
    endif
endfunction

noremap <Leader>gv :call GotoView()<CR>
noremap <Leader>ga :call GotoAction()<CR>


