class Crawler::ScrimperSeven < Crawler::Scrimper
  sidekiq_options queue: :scrimper_seven,
                  retry: true,
                  backtrace: true,
                  unique: :until_and_while_executing,
                  unique_expiration: 120 * 60
end
