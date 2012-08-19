set_deploy 'beta'

role :web, 'lab.mabarroso.com'
role :app, 'lab.mabarroso.com'
role :db, 'lab.mabarroso.com', :primary => true

after "deploy:migrate", "deploy:seed", "assets:precompile"