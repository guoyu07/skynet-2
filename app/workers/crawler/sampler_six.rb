class Crawler::SamplerSix < Crawler::Sampler
  sidekiq_options queue: :sampler_six,
                  retry: true,
                  backtrace: true,
                  unique: :until_and_while_executing,
                  unique_expiration: 120 * 60

  def next_type
    @type ||= 'ScrimperSix'
  end
end
