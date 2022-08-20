p "hello"

expr = /\A([a-z_\.]+?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

def is_valid(email, expr)
    email =~ expr ? "Valid": "Invalid"
end

p is_valid "hello-@gmail.commercial.com", expr