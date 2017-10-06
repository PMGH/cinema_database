require('pg')


class SqlRunner

  def self.run(sql, tag, values)
    begin
      # connect
      db = PG.connect({ dbname: 'cinema', host: 'localhost' })
      # prepare
      db.prepare(tag, sql)
      # execute
      results = db.exec_prepared(tag, values)
    ensure
      # close connection
      db.close()
    end
    # return
    return results if results
  end

end
