class Crawler::SamplerThree < Crawler::Sampler
  sidekiq_options queue: :sampler_three,
                  retry: true,
                  backtrace: true,
                  unique: :until_and_while_executing,
                  unique_expiration: 120 * 60

  def next_type
    @type ||= 'ScrimperThree'
  end
end
