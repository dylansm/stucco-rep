
[
  {email: "dylan@whoisowenjones.com", first_name: "Dylan", last_name: "Smith", 
     encrypted_password: "$2a$10$P7RHrSrfkKo/LXXSLFOa3e55McrcHH9Ket1/P3bCzv4sJtP9G2g7y", admin: true,
     avatar_file_name: "IMG_0293.JPG", avatar_content_type: "image/jpeg", avatar_file_size: 2131577, avatar_updated_at: "2013-07-01 16:20:09"
  },
  {email: "vince@whoisowenjones.com", first_name: "Vince", last_name: "Ready", 
     encrypted_password: "$2a$10$btEN1wy3rfw7IjslcyiBzuLaKqCXCJ4uIM/5eswe48U33KKuiJciG", admin: true,
     avatar_file_name: "Passport-photo.jpg", avatar_content_type: "image/jpeg", avatar_file_size: 24460, avatar_updated_at: "2013-07-01 16:19:41"
  },
  {email: "paul@kingbirdcreative.com", first_name: "Paul", last_name: "Terhaar", admin: true,
     encrypted_password: "$2a$10$v8c8mHrmx/YvkPIDzeFesOBGBSLTi96mSX43hULiaYZiodoMZhVMa"
  },
  {email: "idahotallpaul@gmail.com", first_name: "Paul", last_name: "Terhaar",
     encrypted_password: "$2a$10$v8c8mHrmx/YvkPIDzeFesOBGBSLTi96mSX43hULiaYZiodoMZhVMa"
  },
  {email: "foliomedia2@yahoo.com", first_name: "Michael", last_name: "Hfuhruhurr", 
     encrypted_password: "$2a$10$TwVWBd5ilT7kmwhXI3gMmuB1CfLOku/hGgQIne1avyKpA0Byzj496",
     avatar_file_name: "IMG_0183.JPG", avatar_content_type: "image/jpeg", avatar_file_size: 526949, avatar_updated_at: "2013-07-01 16:18:12"
  },
  {email: "hello@nightlang.org", first_name: "John", last_name: "Tongue", 
     encrypted_password: "$2a$10$v8c8mHrmx/YvkPIDzeFesOBGBSLTi96mSX43hULiaYZiodoMZhVMa",
     avatar_file_name: "IMG_0244.JPG", avatar_content_type: "image/jpeg", avatar_file_size: 2270075, avatar_updated_at: "2013-07-01 16:19:09"
  },
  {email: "vready@gmail.com", first_name: "Vince", last_name: "Ready", 
     encrypted_password: "$2a$10$3NJlsyoiGbjoqLe2HE8MzOz/q6gknBsNbClndSTPyufBH2h5smFIO",
     avatar_file_name: "Passport-photo.jpg", avatar_content_type: "image/jpeg", avatar_file_size: 24460, avatar_updated_at: "2013-07-01 16:18:35"
  }
].each do |u|
  user = User.new(u)
  user.skip_email_notification!

  user.build_user_application

  user.save
end
