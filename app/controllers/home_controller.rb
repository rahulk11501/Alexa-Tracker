class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
  end

  def search_alexa
    websites = [params[:website_one], params[:website_two], params[:website_three]]
    @search_result=[]

    websites.each do |website|

      if website.present?
        hash={}
        url = "http://alexa.com/siteinfo/"+ website
        doc = Nokogiri::HTML(open(url))

        unless doc.at_css("title").text == "Website Traffic, Statistics and Analytics - Alexa"
          global_ranking = doc.at_css('#traffic-rank-content > div > span.span-col.last > div:nth-child(1) > span > span > div > strong').text.strip
          hash['global_ranking']= global_ranking
          country_ranking = doc.at_css('#traffic-rank-content > div > span.span-col.last > div:nth-child(2) > span > span > div > strong').text.strip
          hash['country_ranking']= country_ranking
          hash['website']=website
          @search_result.push(hash)
        end

      end
    end
    ap @search_result

    #Error handler
    # fail
    respond_to do |format|
      format.js
    end
    # RankingJob.new.perform('user.id')
  end

  # whenever.log
  # if wrong website name
  # if not login redirect to login page -> "Please login before using this awesome app"
  # graph dates
  # graph global_ranking/country_ranking
  # seed file
  # read everything from porblem and write according in readme
  # screenshot on github
  # write job if possible

end
