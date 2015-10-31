class Post < ActiveRecord::Base

  validates(:title, {presence:   true,
                    uniqueness: {message: "was used already"},
                    length:     {minimum: 3}})

  validates :body, presence:   true,
                   uniqueness: {scope: :title}



end
