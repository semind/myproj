proj_root_dir = File.expand_path("../../../../", __FILE__)
worker_processes 4
listen      "#{proj_root_dir}/shared/run/universe.sock"
pid         "#{proj_root_dir}/current/tmp/pids/unicorn.pid"
stderr_path "#{proj_root_dir}/current/log/unicorn.log"
stdout_path "#{proj_root_dir}/current/log/unicorn.log"

# graceful restart用の設定 (Masterプロセスがシームレスに切り替わる)
before_fork do |server, worker|
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

