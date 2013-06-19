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
		# 3rd param is to turn rollback On/Off
		# If false insert will commit everytime a successful row is inserted into the table causing partial inserts
		
		query.insert("TABLE_NAME", ["'#{value[0]}', '#{value[1]}', '#{value[2]}'"], true || false )

	#MERGE
	
		# Merges data from one table to another
		# First specify the table you want to perform the merge on
		# Second specify the table you are getting the data from temp table
		# Third the columns to link on as an array ["table.col1 = temp_table.col1"]
		# Values for when match exists as an array ["table.col2 = temp_table.col2, table.col3 = temp_table.col3"]
		# Insert Columns from the final table for when match doesnt exist as an array ["table.col1, table.col2"]
		# Insert Values from the temp table for when match doesnt exist as an array ["temp_table.col1, temp_table.col2"]

		query.merge("SCHEMA.TABLE_NAME table_name", "SCHEMA.TEMP_TABLE_NAME temp_table", ["table_name.orderid = temp_table.orderid"], ["table_name.first_name = temp_table.first_name, table_name.last_name = temp_table.last_name"], ["table_name.orderid, table_name.first_name, table_name.last_name"], ["temp_table.orderid, temp_table.first_name, temp_table.last_name"])
	
	#ROLLBACK / COMMIT w INSERT
		
		# For inserting into a table you could produce errors and perform partial inserts.
		# To prevent this the rollback feature allows for all successful inserts to 
		# revert back to before the inserts started.  To call this feature simply add a 3rd param == true
		# Call inside your rescue the rollback and any logging
		# Then specify outside your rescue Error handling the commit.
		
		begin
			#your values inserting
			query.insert("TABLE_NAME", ["'#{value[0]}', '#{value[1]}', '#{value[2]}'"], true)
		rescue Exception => e
			p "FAILED ROLLBACK"
			query.rollback
			# Log the error message somewhere
		end

		query.commit

	#APPEND

		#Similar to Insert except Appends
		query.append("TABLE_NAME", ["'#{value[0]}', '#{value[1]}', '#{value[2]}'"])

	#UPDATE

		#Updates the values specified where columns = values
		#4th param indicates if you want to omitt the where clause or keep it
		$query.update("TABLE_NAME", ["column_one = 'John Smith'"], "column_one = 'Mark Smith'", false)
		$query.update("TABLE_NAME", ["column_one = 'John Smith'"], '', true)
		
	#TRUNCATE

		#Truncates specified table
		query.truncate("TABLE_NAME")

	#DELETE

		#Deletes values from specified table.  Allows you to specify specific rows
		$query.delete("reportingonly.oracle_query_test", "column_name = 'column_value'")

		#Deletes all rows
		$query.delete("reportingonly.oracle_query_test", '', "all")

	#DROP

		#Drops a table 
		$query.drop("table TABLE_NAME", "table")

		#Drops Database (NOTE: Be careful using the database option. Make sure you want to drop your entire database first)
		$query.drop("database TABLE_NAME", "database")

	#CREATE

		#Creates a new specified table
		$query.create("TABLE_NAME", [["column_one",'varchar (20 BYTE)'], ["column_two", 'NUMBER']])

	#PROCEDURES
		
		#Runs any given defined procedure
		$query.procedure("MYPROCEDURE()")

