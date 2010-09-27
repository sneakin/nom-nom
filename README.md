Nom Nom
===

C is for copyright. (C) 2010 [Nolan Eakins](mailto:sneakin+nomnom@semanticgap.com)


Intro
---

NomNom is a consumer of RESTful APIs.

Status
---

Currently, NomNom can only eat sugar cookie. Only the simplest APIs
are accessible, Twitter still bad for NomNom. NomNom no like Twitter.


Examples
---

    require 'nom_nom'

    class Service
      include NomNom::Service

      resources :posts
      resources :users

      class Post
        include NomNom::Resource

        attr_accessor :id, :body, :user_id
        belongs_to :user
      end

      class User
        include NomNom::Resource

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


More for [Bitter](http://bitter.rubyforge.org/) and [Syncd](http://www.syncd.com/) can be found in [`./lib/nom_nom/services`](http://github.com/sneakin/nom-nom/tree/master/lib/nom_nom/services/).


License
===

Copyright (c) 2010 Nolan Eakins

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
