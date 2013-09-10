namespace "db" do

  desc "Drop and recreate database"
  task :rebuild => :environment do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
  end

  desc "Dump schema and content"
  task "dump" => :environment do
    rails_env = (Rails.env || 'development')
    app_name = Rails.application.class.parent_name
    config = ActiveRecord::Base.configurations[rails_env]
    host = (config['host'] || 'localhost')
    if config["adapter"] == "postgresql"
      unless config['password'].nil?
        ENV["PGPASSWORD"] = config['password'].to_s
      end
      #puts "pg_dump -Fc --no-acl --no-owner -h #{host} -U #{config['username']} #{config['database']} > #{Rails.root}/db/#{app_name}_#{rails_env}.dump"
      `pg_dump -Fc --no-acl --no-owner -h #{host} -U #{config['username']} #{config['database']} > #{Rails.root}/db/#{app_name}_#{rails_env}.dump`
    end
  end

  desc "Export schema and content"
  task "export_all" => :environment do
    rails_env = (Rails.env || 'development')
    app_name = Rails.application.class.parent_name
    config = ActiveRecord::Base.configurations[rails_env]
    if config["adapter"] == "postgresql"
      unless config['password'].nil?
        ENV["PGPASSWORD"] = config['password'].to_s
      end
      #puts "pg_dump -U #{config['username']} #{config['database']} > #{Rails.root}/db/#{app_name}_#{rails_env}.sql"
      `pg_dump -U #{config['username']} #{config['database']} > #{Rails.root}/db/#{app_name}_#{rails_env}.sql`
    elsif config.adapter == ("mysql" || "mysql2")
      `mysqldump -r #{Rails.root}/db/#{app_name}_#{rails_env}.sql #{config['database']} -u #{config['username']} -p#{config['password'].to_s}`
    end
  end

  desc "Restore dev database from SQL file"
  task "restore" => [:environment, "db:rebuild"] do
    rails_env = (Rails.env || 'development')
    app_name = Rails.application.class.parent_name
    config = ActiveRecord::Base.configurations[rails_env]
    # make sure
    if rails_env != 'development'
      puts "This is very destructive. Are you sure? (Type 'yes' or cancel)."
      unless gets.chomp == "yes"
        puts "Aborted. Close call."
        exit
      end
    end

    file_name = "#{app_name}_#{rails_env}.sql"
    sql_file = "db/#{file_name}"

    if File.exist? sql_file

      if config["adapter"] == "postgresql"
        unless config['password'].nil?
          ENV["PGPASSWORD"] = config['password'].to_s
        end
        `psql #{config['database']} -f #{sql_file}`
      elsif config.adapter == ("mysql" || "mysql2")
        `mysql -u #{config['username']} -p#{config['password'].to_s} --default-character-set=utf8 #{config['database']} < #{sql_file}`
      end

      puts "\nThat should do it. Get to work.\n\n"

    else
      puts "No data file in db/ named '#{file_name}'."
    end

  end

  
  desc "Export model's table passed as parameter in seeds format."
  task :export_seeds, [:model] => :environment do |t, args|
    #unless defined? args[:model].constantize
    
    begin
      args[:model].constantize
    rescue Exception, SyntaxError, NameError => e
      raise("The model '#{args[:model]}' does not exist.")
      exit
    end

    model = args[:model].constantize
    model.order(:id).all.each do |attr|
      puts "#{args[:model]}.create(#{attr.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end

  desc "Ensure auto increment is reset to next available key value."
  task "fix_auto_increment" => :environment do
    ActiveRecord::Base.connection.tables.each do |table|
      unless table == 'schema_migrations'
        result = ActiveRecord::Base.connection.execute("SELECT id FROM #{table} ORDER BY id DESC LIMIT 1")
        if result.any?
          ai_val = result.first['id'].to_i + 1
          puts "Resetting auto increment ID for #{table} to #{ai_val}"
          ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{ai_val}")
        end
      end
    end
  end

end
