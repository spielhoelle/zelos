every :saturday, at: '03:00', roles: [:app] do
  rake 'letsencrypt:renew_certificate'
end

# nginx reload should happen after certificate was renewed
every :saturday, at: '03:01', roles: [:app] do
  command 'sudo service nginx reload'
end
