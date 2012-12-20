require 'oci8'

class Oracle
  def initialize (username, password, db)
    @oci = OCI8.new(username, password, db)
  end

  def select (query, var)
    variable = var
    @variable = []
    @oci.exec(query) do |result|
      @variable.push(result)
    end
    eval("$#{variable} = @variable")
  end

  def insert (table = '', values = [])
    @oci.exec("INSERT INTO #{table} VALUES(#{values[0]})")
    @oci.commit
  end

  def truncate (table = '')
    @oci.exec("TRUNCATE TABLE #{table}")
    @oci.commit
  end
end