vince = User.create(:username => 'vince', :email => 'vincepinto@example.com', :password => 'password')
tristan = User.create(:username => 'tristan', :email => 'tristan@example.com', :password => 'password')
reynan = User.create(:username => 'reynan', :email => 'reynan@example.com', :password => 'reynan')

company = Company.create(:name => 'Test Company')

Role.create(:name => 'client', :user => vince, :company => company)

Role.create(:name => 'admin', :user => reynan, :company => company)

Role.create(:name => 'client', :user => tristan, :company => company)

