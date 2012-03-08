vince = User.create(:username => 'vince', :email => 'vincepinto@example.com', :password => 'password')
tristan = User.create(:username => 'tristan', :email => 'tristan@example.com', :password => 'password')
reynan = User.create(:username => 'reynan', :email => 'reynan@example.com', :password => 'reynan')

Role.create(:name => 'admin', :user => reynan)

company = Company.create(:name => 'Test Company')

restaurant = FactoryGirl.create(:restaurant, :company => company)
branch = FactoryGirl.create(:branch, :restaurant => restaurant)

Role.create(:name => 'client', :user => vince, :company => company)
Role.create(:name => 'client', :user => tristan, :company => company)

category = FactoryGirl.create(:category, :name => 'Category A', :restaurant => restaurant)
subcategory = FactoryGircl.create(:subcategory, :name => 'Subcategory A', :category => category)
