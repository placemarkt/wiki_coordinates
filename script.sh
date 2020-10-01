## Remove drafts and errored articles
sed -i 'Draft:d' coords.csv
sed -i 'ERROR:d' coords.csv

## Get coordinates into format to be read in SQL statement
awk -F '|' -v OFS='|' '{$3="ST_GeomFromText('\''POINT("$3")'\'',4326)"; print $1,$2,$3}' coords.csv >> formatted_coords.csv
## Get rid of empty coordinates
sed -i '/()/d' coords2.sql
## Build SQL statement
awk -F '|' '{printf "(%s, \$\$%s\$\$, %s, \x27wikipedia\x27),\n", $1, $2, $3}' formatted_coords.csv >> coords.sql

