program_managers = [ User.find(1), User.find(2) ]

program = Program.first
program_managers.each do |pm|
  program.program_managers.create(user: pm)
end

users = [ User.find(3), User.find(4), User.find(5) ]
program.users << users
