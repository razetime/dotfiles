# Dilbert kinda sucks, so cat.
set-option -add global ui_options terminal_assistant=cat
hook global ModuleLoaded x11 %{
        set global termcmd 'xterm -e'
}
# For clipboard
hook global RegisterModified '"' %{ nop %sh{
  printf %s "$kak_main_reg_dquote" | xsel --input --clipboard
}}
hook global BufSetOption filetype=java %{
    set-option buffer formatcmd "java ~/Software/google-java-format-1.14.0-all-deps.jar %val{buffile}"
}

set global tabstop 2
set global indentwidth 2        

# for K plugin
declare-option str k_exec "~/Software/k/k ~/Software/k/repl.k"
map global normal <c-k> ": enter-user-mode k<ret>"
