if stridx( '.sql.xml', bufname('%') )
   if search('<storedProcedure') && search('CALL')
      setlocal path+=~/_dev/lib/php/includes/db/databases/uw_acct
      setlocal path+=~/_dev/lib/php/includes/db/databases/uw_bill
      setlocal path+=~/_dev/lib/php/includes/db/databases/uw_dhcp
      setlocal path+=~/_dev/lib/php/includes/db/databases/uw_usage
      setlocal path+=~/_dev/lib/php/includes/db/databases/uw_web
      setlocal suffixesadd+=.sql.xml
   endif
endif
