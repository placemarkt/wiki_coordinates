## Remove drafts and errored articles
sed -i 'Draft:d' coords.csv
sed -i 'ERROR:d' coords.csv

## Format CSV
csvformat -d"," -U2 -S < 2coords.csv > formatted.csv
awk -vFPAT='([^,]*)|("[^"]+")' -v OFS=',' '{gsub(/"/, "", $3); gsub(/"/, "", $4); $3="SRID=4326; POINT("$3" "$4")"; print $2,$3,"\"wikipedia\"",$5}' < formatted.csv > geo.csv

# Run the following in your postgres db
# COPY points_of_interest (name, coordinates, source, description) from 'FILEPATH_TO_CSV' WITH (DELIMITER ',', FORMAT csv);
