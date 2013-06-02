# admins
#User.create(email:"dylan@whoisowenjones.com", first_name: "Dylan", last_name: "Smith", encrypted_password: "$2a$10$P7RHrSrfkKo/LXXSLFOa3e55McrcHH9Ket1/P3bCzv4sJtP9G2g7y", admin: true)
#User.create(email: "vince@whoisowenjones.com", first_name: "Vince", last_name: "Ready", encrypted_password: "$2a$10$btEN1wy3rfw7IjslcyiBzuLaKqCXCJ4uIM/5eswe48U33KKuiJciG", admin: true)

# users
#User.create(email:"foliomedia2@yahoo.com", first_name: "Michael", last_name: "Hfuhruhurr", encrypted_password: "$2a$10$TwVWBd5ilT7kmwhXI3gMmuB1CfLOku/hGgQIne1avyKpA0Byzj496", skip_email_notification: true)
#User.create(email:"hello@nightlang.org", first_name: "John", last_name: "Tongue", encrypted_password: "$2a$10$v8c8mHrmx/YvkPIDzeFesOBGBSLTi96mSX43hULiaYZiodoMZhVMa")
#User.create(email:"vready@gmail.com", first_name: "Vince", last_name: "Ready", encrypted_password: "$2a$10$3NJlsyoiGbjoqLe2HE8MzOz/q6gknBsNbClndSTPyufBH2h5smFIO")

[
  {email: "dylan@whoisowenjones.com", first_name: "Dylan", last_name: "Smith", encrypted_password: "$2a$10$P7RHrSrfkKo/LXXSLFOa3e55McrcHH9Ket1/P3bCzv4sJtP9G2g7y", admin: true},
  {email: "vince@whoisowenjones.com", first_name: "Vince", last_name: "Ready", encrypted_password: "$2a$10$btEN1wy3rfw7IjslcyiBzuLaKqCXCJ4uIM/5eswe48U33KKuiJciG", admin: true},
  {email: "foliomedia2@yahoo.com", first_name: "Michael", last_name: "Hfuhruhurr", encrypted_password: "$2a$10$TwVWBd5ilT7kmwhXI3gMmuB1CfLOku/hGgQIne1avyKpA0Byzj496"},
  {email: "hello@nightlang.org", first_name: "John", last_name: "Tongue", encrypted_password: "$2a$10$v8c8mHrmx/YvkPIDzeFesOBGBSLTi96mSX43hULiaYZiodoMZhVMa"},
  {email: "vready@gmail.com", first_name: "Vince", last_name: "Ready", encrypted_password: "$2a$10$3NJlsyoiGbjoqLe2HE8MzOz/q6gknBsNbClndSTPyufBH2h5smFIO"},
].each do |u|
  user = User.new(u)
  user.skip_email_notification!
  user.save
end
