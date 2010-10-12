set iskeyword=@,48-57,_,192-255,:
set keywordprg=man\ -s
iab <buffer> snew sub new {<CR>my $proto = shift;<CR><CR>my $class = ref $proto \|\| $proto;<CR><CR>my $self = {<ESC>mxa };<CR><CR>bless $self => $class;<CR><BS>}<CR><ESC>`xa
