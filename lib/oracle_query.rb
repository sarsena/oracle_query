require 'oci8'

class Oracle
  def initialize (username, password, db_connection)
    @oci = OCI8.new(username, password, db_connection)
  end

  def select (query, var)
    variable = var
    @variable = []
    @oci.exec(query) do |result|
      @variable.push(result)
    end
    eval("$#{variable} = @variable")
  end

  #Set table name and values ["name = 'John', employee_id = 39994"]
  def insert (table, values)
    @oci.exec("INSERT INTO #{table} VALUES(#{values[0]})")
    @oci.commit
  end

  #Set table name and values ["name = 'John', employee_id = 39994"]
  def append (table, values)
    @oci.exec("INSERT /*+ append */ INTO #{table} VALUES(#{values[0]})")
    @oci.commit
  end  

  #set Table name to truncate
  def truncate (table)
    @oci.exec("TRUNCATE TABLE #{table}")
    @oci.commit
  end

  #set Table name, Values to update ["name = 'John', id = 30"], where columns = values
  def update (table, values, where)
    @oci.exec("UPDATE #{table} SET #{values[0]} WHERE #{where}")
    @oci.commit
  end

  #Set table to name of table you wish to delete
  #Set values for where column = values
  #Set type to all if you want to remove all otherewise pass nil
  def delete (table, values = '', type = '')
    if type == "all"
      @oci.exec("DELETE FROM #{table}")
      @oci.commit
    else
      @oci.exec("DELETE FROM #{table} WHERE #{values}")
      @oci.commit
    end
  end

  #Set Object to either a table or database
  #Set the value based on if its a table your droping or database
  def drop (object, type)
    if type == 'table'
      @oci.exec("DROP #{object}")
      @oci.commit
    end
    if type == 'database'
      @oci.exec("DROP DATABASE #{object}")
      @oci.commit
    end
  end

  #Set table = TABLE_NAME; 
  #Set Values as an array [['column_name1', 'data_type'], ['column_name2', 'data_type'], ['column_name3', 'data_type']]
  def create(table, values)
    data_set = []
    values.each{ |data| 
      data = data.join(" ") 
      data_set.push(data)
    }
    data_set = data_set.join(", ")
    @oci.exec("CREATE TABLE #{table} (#{data_set})")
    @oci.commit
  end

end