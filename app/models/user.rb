class User < ApplicationRecord
    has_secure_password

    validates :username, :email, :fullname, presence: {message: "must exists"}

    validates :username, length: {minimum: 3, maximum: 30}, uniqueness: true

    validates :email, format: {with: /\A([^-]+?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}, uniqueness: true

    validates :fullname, length: {minimum: 5, maximum: 50}, format: {with: /\A[a-z]+ [a-z]+\z/i}

    validate :password_is_valid


    def password_is_valid
        if !password_digest
            errors.add(:password, "Password can't be empty")
            return
        end
        
        if !!username && password.upcase == username.upcase
            errors.add(:password_digest, "Can't make password same as username")
        end

        if password.size < 10 || password.size > 50 
            message = password.size < 10? "Too short password": "Too long password"
            errors.add(:password_digest, message)
        end
        
        password_regex = [/[A-Z]/, /[a-z]/, /[\d]/, /[^A-Za-z\d]/]

        
        messages_prefix = "Must include at least one"

        regex_error_messages = 
        [
        "#{messages_prefix} uppercase letter",
        "#{messages_prefix} lowercase letter", 
        "#{messages_prefix} digit",
        "#{messages_prefix} special character"
        ]

        password_regex.each_with_index {|regex, index| 
            errors.add(:password_digest, regex_error_messages[index]) unless password.match?(regex)
        }

        errors.add(:password_digest, "Password can't include spaces") unless !password.match?(/ /)
        
    end

end
