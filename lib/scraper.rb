require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  
  def get_page
    html = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
    
    Nokogiri::HTML(html)
  end

  def get_courses
    course = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
      course.css("#course-grid.block")
      
    #get_page.css(".post")  
  end
  
    
    def make_courses
      get_courses.each |course|
      course = Course.new(title,schedule, description)
      @title = course.css("h2").text
      @schedule = course.css(".date").text
      @description = course.css("p").text
    end


  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
end
