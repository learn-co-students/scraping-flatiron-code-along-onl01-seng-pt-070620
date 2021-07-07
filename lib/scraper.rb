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
  end
  
    
  def make_courses
    course = Course.new
      get_courses.each do |block|

      course.title = block.css("h2").text
      course.schedule = block.css(".date").text
      course.description = block.css("p").text
      end
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
