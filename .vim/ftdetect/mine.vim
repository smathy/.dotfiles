au BufRead,BufNewFile *.rjs,*.rxml  set ft=ruby
au! BufRead,BufNewFile *.haml       set ft=haml

au BufNewFile,BufRead /etc/apache*/*.conf,httpd.include set ft=apache

au BufRead,BufNewFile *.as set ft=actionscript
au BufNewFile,BufRead *.mxml set filetype=mxml

