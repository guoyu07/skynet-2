class Recorder::Base < Worker
  sidekiq_options queue: :recorder,
                  retry: true,
                  backtrace: true
                  # unique: :until_executed,
                  # unique_job_expiration: 24 * 60

  def cloud
    @cloud ||= Cloud.new(@container)
  end
end
