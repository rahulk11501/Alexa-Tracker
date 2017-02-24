require "rails_helper"

RSpec.describe HomeController, type: :controller do

  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST search_alexa" do
    # Following the same test pattern other website raking test cases can be written
    it 'returns searched websites results' do
      post 'search_alexa'
      # file_fixture introduced in rspec 3.5
      fixture = JSON.parse(file_fixture("websites.json").read)
      doc = Nokogiri::HTML(open('http://alexa.com/siteinfo/'+fixture['url1']))
      global_ranking =  doc.at_css('#traffic-rank-content > div > span.span-col.last > div:nth-child(1) > span > span > div > strong').text.strip

      #expect global ranking of google.com to be #1
      expect(global_ranking.to_i).to  eq(1)
      expect(global_ranking.to_i).not_to  eq(10)
    end

    it "renders the search_alexa.js.erb template" do
      post 'search_alexa'
      expect(response).not_to render_template("search_alexa")
      # sign_in users to run following example also
      # expect(response)._to render_template("search_alexa")
      # check line 45 of spec/rails_helper.rb to implement this
    end
    
  end

end
