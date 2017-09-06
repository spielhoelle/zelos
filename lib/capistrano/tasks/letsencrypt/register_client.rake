namespace :letsencrypt do
  task :register_client do
    on roles(:app) do
      contact_email = fetch(:letsencrypt_contact_email) || raise('Missing contact email')
      letsencrypt_dir = fetch(:letsencrypt_dir) || raise('Missing letsencrypt directory')
      private_key_path = fetch(:letsencrypt_private_key_path) ||
                         raise('Missing private key path')

      # We need an ACME server to talk to, see github.com/letsencrypt/boulder
      # WARNING: This endpoint is the production endpoint, which is rate limited
      # and will produce valid certificates.
      # You should probably use the staging endpoint for all your experimentation:
      # endpoint = 'https://acme-staging.api.letsencrypt.org/'
      endpoint = fetch(:letsencrypt_endpoint) || raise('Missing letsencrypt endpoint')


      # make the config letsencrypt dir
      execute :mkdir, "-p #{letsencrypt_dir}"

      if test("[ -f #{private_key_path} ]")
        info "Private key file already exists at #{private_key_path}"
        info "If you want to generate a new private key then please" <<
             "remove the current private key"
        info "and then run task again."
      else
        # We're going to need a private key.
        require 'openssl'
        private_key = OpenSSL::PKey::RSA.new(4096)
        upload! StringIO.new(private_key.to_pem), private_key_path

        # Initialize the client
        require 'acme-client'
        client = Acme::Client.new(private_key: private_key, endpoint: endpoint)

        # If the private key is not known to the server,
        # we need to register it for the first time.
        registration = client.register(contact: "mailto:#{contact_email}")

        # You may need to agree to the terms of service
        # (that's up the to the server to require it or not but boulder does by default)
        registration.agree_terms
      end
    end
  end
end

