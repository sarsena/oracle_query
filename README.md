The Oracle Query Ruby gem utilizes the existing ruby-oci8 gem to help create the oracle 
ruby connection and makes Oracle querying with Ruby cleaner and simplified.

You can Select, Insert, Truncate by passing in the appropriate parameters.
Select you will get in return an array of values which you specify in the parameters.
Insert will simply insert an array of values into the specified table.
Truncate will truncate the specified table.

## Usage
	#CONFIG
	
		query =	Oracle.new(username, password, db_connection)
	
	#SELECT

		# Query the selected table and return the results in a variable you specifiy
		# Example in this case $my_array
		query.select("SELECT * from TABLE_NAME", "my_array")

		$my_array.each { |result| 
			p result
		}

	#INSERT

		# Insert into specified table the array of values
		query.insert("TABLE_NAME", ["'#{value[0]}', '#{value[1]}', '#{value[2]}'"])

	#TRUNCATE

		# Truncates specified table
		query.truncate("TABLE_NAME")

