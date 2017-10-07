namespace :letsencrypt do
  task :renew_certificate do
    if Rails.env.production?
      endpoint = 'https://acme-v01.api.letsencrypt.org/'
      certificate_request_domains = YAML.load_file("./config/secrets.yml")["production"]["domain"]
      app_dir = YAML.load_file("./config/secrets.yml")["production"]["deploy_path"]
      certificate_dir = "#{app_dir}/shared/config/letsencrypt/certificate"
      private_key_path = "#{app_dir}/shared/config/letsencrypt/private_key.pem"
    else
      # Use staging endpoint to generate test certificate for you non production environment.
      # Your browser will detect it as unknown certificate.
      endpoint = 'https://acme-staging.api.letsencrypt.org/'
      certificate_request_domains = 'staging.example.com'
      app_dir = YAML.load_file("./config/secrets.yml")["production"]["deploy_path"]
      certificate_dir = "#{app_dir}/shared/config/letsencrypt/certificate"
      private_key_path = "#{app_dir}/shared/config/letsencrypt/private_key.pem"
    end

    cert_privkey_path = "#{certificate_dir}/privkey.pem"
    cert_path = "#{certificate_dir}/cert.pem"
    cert_chain_path = "#{certificate_dir}/chain.pem"
    cert_fullchain_path = "#{certificate_dir}/fullchain.pem"

    if File.exists?(cert_privkey_path) && File.exists?(cert_path) &&
      File.exists?(cert_chain_path) && File.exists?(cert_fullchain_path)

      private_key = OpenSSL::PKey::RSA.new(File.read(private_key_path))

      # Initialize the client
      require 'acme-client'
      client = Acme::Client.new(private_key: private_key, endpoint: endpoint)

      # We're going to need a certificate signing request. If not explicitly
      # specified, the first name listed becomes the common name.
      csr = Acme::Client::CertificateRequest.new(names: certificate_request_domains.split)

      # We can now request a certificate. You can pass anything that returns
      # a valid DER encoded CSR when calling to_der on it. For example an
      # OpenSSL::X509::Request should work too.
      certificate = client.new_certificate(csr) # => #<Acme::Client::Certificate ....>

      # Save the certificate and the private key to files
      File.write(cert_privkey_path, certificate.request.private_key.to_pem)
      File.write(cert_path, certificate.to_pem)
      File.write(cert_chain_path, certificate.chain_to_pem)
      File.write(cert_fullchain_path, certificate.fullchain_to_pem)

      puts "[#{Time.now}] Certificate renewed!"
    else
      puts "[#{Time.now}] Current certificate doesn't exist so you cannot renew it."
      puts "Please deploy app to generate a new certificate."
    end
  end
end
