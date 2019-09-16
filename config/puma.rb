threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count
port        ENV["PORT"]     || 4000
environment ENV["RACK_ENV"] || "development"
plugin :tmp_restart
