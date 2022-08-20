require 'rails_helper'

RSpec.describe User, type: :model do
  
  context 'Presence tests' do  
    it 'email present' do   
      user = User.new(fullname: "mazen medhat", username: "killowa", password_digest: "psw").save
      expect(user).to eq(false)  
    end

    it 'fullname present' do   
      user = User.new(email: "mazen@yahoo.com", username: "killowa", password_digest: "psw").save
      expect(user).to eq(false)  
    end

    it 'username present' do   
      user = User.new(fullname: "mazen medhat", email: "mazen@yahoo.com", password_digest: "psw").save
      expect(user).to eq(false)  
    end

    it "All fields are filled" do
      user = User.new(password_digest: "pswA@124123", fullname: "mazen medhat", email: "mazen@yahoo.com", username: "killowa").save
      expect(user).to eq(true)  
    end
  end

  context 'username tests' do
    it 'length < 3 is invalid' do
      user = User.new(username: "me")
      user.save
      expect(user.errors[:username].join(' ')).to include('minimum is 3 characters')
    end
    
    it 'length > 30 is invalid' do
      longUsername = Array.new(31, "a").join
      user = User.new(username: longUsername)
      user.save
      expect(user.errors[:username].join(' ')).to include('maximum is 30 characters')
    end
  end

  context 'Password validation test' do
    it 'password < 10 is too short' do
      user = User.new(username: "killowa", password_digest: "psw")
      user.save
      expect(user.errors[:password_digest].join(', ')).to include('Too short password')
    end

    it 'password > 50 is too long' do
      longPassword = Array.new(51, "a").join('')
      user = User.new(username: "killowa", password_digest: longPassword)
      user.save
      expect(user.errors[:password_digest].join(', ')).to include('Too long password')
    end

    it 'password must include at least one uppercase character' do
      user = User.new(username: "killowa", password_digest: "psw")
      user.save
      expect(user.errors[:password_digest].join(', ')).to include('uppercase')
    end

    it 'password must include at least one lowercase character' do
      user = User.new(username: "killowa", password_digest: "PSW")
      user.save
      expect(user.errors[:password_digest].join(', ')).to include('lowercase')
    end

    it 'password must include at least one special character' do
      user = User.new(username: "killowa", password_digest: "psw")
      user.save
      expect(user.errors[:password_digest].join(', ')).to include('special character')
    end

    it 'password must include at least one digit' do
      user = User.new(username: "killowa", password_digest: "psw")
      user.save
      expect(user.errors[:password_digest].join(', ')).to include('digit')
    end

    it 'password can\'t have spaces' do
      user = User.new(username: "killowa", password_digest: "password validati@N")
      user.save
      expect(user.errors[:password_digest].join(', ')).to include('spaces')
    end
  end

  context 'Email validation' do
    it 'Email must include one @ character' do
      user = User.new(email: "mazengmail.com")
      user.save
      expect(user.errors[:email]).not_to be_empty
    end

    it 'Email must end with .xxx' do
      user = User.new(email: "mazen@gmail")
      user.save
      expect(user.errors[:email]).not_to be_empty
    end

    it 'Email substring after (.) must include no special characters' do
      user = User.new(email: "mazen@gmail.c-")
      user.save
      expect(user.errors[:email]).not_to be_empty
    end

    it 'Email accepts any character before @ character except -' do
      user = User.new(email: "mazen$-@gmail.com")
      user.save
      expect(user.errors[:email]).not_to be_empty
    end

    it 'Email should be unique' do
      user = User.new(email: "mazen@gmail.com")
      user.save
      user2 = User.new(email: "mazen@gmail.com")
      saved = user2.save
      expect(saved).to eq(false)
    end
  end

  context 'Full name validation' do
    it 'Full name must not include special characters' do
      user = User.new(fullname: "mazen@ medhat")
      user.save
      expect(user.errors[:fullname]).not_to be_empty
    end

    it 'Full name length < 5 is invalid' do
      user = User.new(fullname: "hat")
      user.save
      expect(user.errors[:fullname].join(' ')).to include("minimum is 5 characters")
    end

    it 'Full name length > 50 is invalid' do
      longFullname = Array.new(51, "a").join
      user = User.new(fullname: longFullname)
      user.save
      expect(user.errors[:fullname].join(' ')).to include("maximum is 50 characters")
    end

    it 'Full name 5 < length < 50 is valid' do
      user = User.new(fullname: "mazen medhat")
      user.save
      expect(user.errors[:fullname]).to be_empty
    end
  end

end
