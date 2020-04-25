require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: Settings.aws[:access_key],
        aws_secret_access_key: Settings.aws[:secret_access_key],
        region: Settings.aws[:region]
    }

    config.fog_directory  = Settings.aws[:s3_bucket]
    config.fog_provider = 'fog/aws'
    config.cache_storage = :fog
  end
end
