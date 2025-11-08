echo '' > $1
sh csparse csdb cat '$1' cat . cat 1- >> $1
sh csparse entryname echo '$2' cat . cat 1- >> $1
sh csparse entry echo '"$csdb"' cat '^$entryname\ ' cat 1- >> $1
sh csparse prefix echo '$entry' cat . cat 2 >> $1
sh csparse sprefix echo '"$csdb"' cat '^cfg_sprefix\ ' cat 2- >> $1
sh csparse pprefix echo '"$csdb"' cat '^cfg_pprefix\ ' cat 2- >> $1
sh csparse rprefix echo '$entry' cat . cat 3 >> $1
sh csparse hostname echo '$entry' cat . cat 4 >> $1
sh csparse port echo '$entry' cat . cat 5 >> $1
sh csparse user echo '$entry' cat . cat 6 >> $1
sh csparse pkey echo '"$csdb"' cat '^pk_$entryname\ ' cat 1- >> $1
sh csparse cscmd echo '"$3"' cat . cat 1- >> $1
sh csparse fwdrule echo '$3' cat . cat 1- >> $1
sh csparse keyfile echo '$3' cat . cat 1- >> $1
sh csparse pathbase echo '$4' cat . cat 1- >> $1
sh csparse fsource echo '$3' cat . cat 1- >> $1
sh csparse fdest echo '$4' cat . cat 1- >> $1
sh csparse xline echo '$3' cat . cat 1- >> $1
sh csparse dpyname echo '$3' cat . cat 1- >> $1
sh csparse lport echo '$3' cat . cat 1- >> $1
sh csparse entryline echo '"$csdb"' 'grep -n .' \''^[0-9]*:'\''$entryname\ ' 'cut -d: -f1' 1- >> $1
sh csparse pkeyformat echo '"$csdb"' cat '^cfg_pkeyformat\ ' cat 2- >> $1
sh csparse keystring cat '$3' cat . cat 1- >> $1
sh csparse dbfile echo '$1' cat . cat 1- >> $1
