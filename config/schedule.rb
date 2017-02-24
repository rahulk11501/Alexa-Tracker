set :output, "log/whenever.log"

every 1.days , :at => '00:01 am' do
  runner "RankingJob.new.perform('user.id')", filename: '/app/jobs/ranking_job.rb', environment:  'development'
end
