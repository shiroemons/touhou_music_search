Redis.current = if Rails.env.production?
                  Redis.new(url: ENV['REDIS_URL'])
                else
                  Redis.new
                end
