echo '' > $1
sh csparse csdb cat '$1' cat . cat 1- >> $1
sh csparse entryname echo '$2' cat . cat 1- >> $1
sh csparse entry echo '"$csdb"' cat '^$entryname\ ' cat 1- >> $1
sh csparse prefix echo '$entry' cat . cat 2 >> $1
sh csparse rprefix echo '$entry' cat . cat 3 >> $1
sh csparse hostname echo '$entry' cat . cat 4 >> $1
sh csparse port echo '$entry' cat . cat 5 >> $1
sh csparse user echo '$entry' cat . cat 6 >> $1
sh csparse pkey echo '"$csdb"' cat '^pk_$entryname\ ' cat 1- >> $1
