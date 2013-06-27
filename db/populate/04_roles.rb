program = Program.first

users = User.find([1,2,3,4,5,6,7])
program.users << users
users.each { |u| u.update_column(:current_program_id, program.id) }
