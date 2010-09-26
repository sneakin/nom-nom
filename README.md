Nom Nom
===

C is for copyright. (C) 2010 Nolan Eakins <sneakin+nomnom@semanticgap.com>


Intro
---

NomNom is a consumer of RESTful APIs.

Status
---

Currently, NomNom can only eat sugar cookie.


Examples
---

<code>
require 'nom_nom'
class Service < NomNom::Service
  resources :users

  class Post < NomNom::Resource
    attr_accessor :id, :body, :user_id
    belongs_to :user
  end

  class User < NomNom::Resource
    attr_accessor :id, :login, :email
    has_many :posts
  end
end

s = Service.new('https://example.com', 'user', 'password')
s.users.each do |u|
  puts u.login
  puts '=' * u.login.length
  puts "\t" + u.posts.collect { |p| p.body }.join("\n\t")
end
</code>

More for [Bitter](http://bitter.rubyforge.org/) and [Syncd](http://www.syncd.com/) can be found in `./examples`.