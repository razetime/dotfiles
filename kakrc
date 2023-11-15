set global ui_options terminal_assistant=cat 
set global tabstop 2 
set global indentwidth 2 
set global autowrap_column 80 
add-highlighter global/ column '%opt{autowrap_column}' default,bright-black 
# For clipboard 
hook global RegisterModified '"' %{ nop %sh{ 
  printf %s "$kak_main_reg_dquote" | xsel --input --clipboard 
}} 

