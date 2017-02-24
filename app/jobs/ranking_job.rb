class RankingJob
  include SuckerPunch::Job

  def perform(event)
    puts "event"
    puts event
    # Log.new(event).track
    r = Ranking.new
    r.global_ranking = 2
    r.date = Date.today + 1
    r.save
  end
end
