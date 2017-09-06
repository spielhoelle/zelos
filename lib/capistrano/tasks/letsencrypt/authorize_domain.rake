namespace :letsencrypt do
  task :authorize_domain do
    on roles(:app) do
      letsencrypt_dir = fetch(:letsencrypt_dir) || raise('Missing letsencrypt directory')
      letsencrypt_authorize_domains = fetch(:letsencrypt_authorize_domains) ||
                                      raise('Missing letsencrypt authorize domains')
      private_key_path = fetch(:letsencrypt_private_key_path) ||
                         raise('Missing private key path')

      # We need an ACME server to talk to, see github.com/letsencrypt/boulder
      # WARNING: This endpoint is the production endpoint, which is rate limited
      # and will produce valid certificates.
      # You should probably use the staging endpoint for all your experimentation:
      # endpoint = 'https://acme-staging.api.letsencrypt.org/'
      endpoint = fetch(:letsencrypt_endpoint) || raise('Missing letsencrypt endpoint')


      private_key = OpenSSL::PKey::RSA.new(capture(:cat, private_key_path))

      # Initialize the client
      require 'acme-client'
      client = Acme::Client.new(private_key: private_key, endpoint: endpoint)

      letsencrypt_authorize_domains.split.each do |domain|
        info "Domain: #{domain}"

        authorization_uri_file = "#{letsencrypt_dir}/authorization_uri_#{domain}.txt"
        authorization = client.authorize(domain: domain)

        run_verification = false

        unless test("[ -f #{authorization_uri_file} ]")
          # This example is using the http-01 challenge type.
          # Other challenges are dns-01 or tls-sni-01.
          challenge = authorization.http01

          # The http-01 method will require you to respond to a HTTP request.

          # You can retrieve the challenge token
          info challenge.token # => "some_token"

          # You can retrieve the expected path for the file.
          info challenge.filename # => ".well-known/acme-challenge/:some_token"

          # You can generate the body of the expected response.
          info challenge.file_content # => 'string token and JWK thumbprint'

          # You are not required to send a Content-Type.
          # This method will return the right Content-Type should you decide to include one.
          info challenge.content_type

          # save the authorization uri for use at another time
          upload! StringIO.new(authorization.uri), authorization_uri_file

          run_verification = true
        end


        authorization_uri = capture :cat, authorization_uri_file

        # Load a challenge based on authorization uri.
        challenge = client.fetch_authorization(authorization_uri).http01

        # Save the file. We'll create a public directory to serve it from,
        # and inside it we'll create the challenge file.
        execute :mkdir, "-p #{release_path}/public/#{File.dirname(challenge.filename)}"

        # We'll write the content of the file
        challenge_public_path = "#{release_path}/public/#{challenge.filename}"
        upload! StringIO.new(challenge.file_content), challenge_public_path
        execute :chmod, "+r #{challenge_public_path}"


        if run_verification
          # Once you are ready to serve the confirmation request you can proceed.
          challenge.request_verification # => true
          info "Verify status: #{challenge.verify_status}" # => 'pending'

          # Wait a bit for the server to make the request, or just blink. It should be fast.
          sleep(3)

          info "Verify status: #{challenge.verify_status}" # => 'valid'
        else
          info "Skipped verification of challenge. It's already verified."
          info "If you want to verify different domain please remove file:"
          info "#{authorization_uri_file} and run the task again."
        end
      end
    end
  end
end
