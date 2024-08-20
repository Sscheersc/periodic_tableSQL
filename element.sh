#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ ! -z $1 ]]
then
	SELECTED_ELEMENT=$($PSQL "SELECT atomic_number,symbol,name,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE (CAST(atomic_number AS TEXT) = '$1') OR (symbol = '$1') OR (name = '$1')")
	if [[ -z $SELECTED_ELEMENT ]]
	then
		echo -e "I could not find that element in the database."
	else
		echo "$SELECTED_ELEMENT" | while IFS=" | " read ATOMIC_NUMBER SYMBOL NAME TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
		do
			echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
		done
	fi
else
	echo -e "Please provide an element as an argument."
fi


