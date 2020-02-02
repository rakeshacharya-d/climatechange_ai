require 'kramdown'

# This file regenerates the resources page html using the data encoded in `resources_content.md`.
# To use, run `bundle exec ruby generate_resources_html.rb  > resources.md`

def to_html(text)
  Kramdown::Document.new(text).to_html.gsub(/<a href="h/, '<a target="_blank" href="h')
end

intro = <<-HTML
---
title: Climate Change AI - Resources
description: This page presents some readings, datasets, and tools for the areas outlined in our paper, "Tackling Climate Change with Machine Learning."
redirect_from:
  - /readings-datasets
---

# Resources

This page presents some readings, datasets, and tools for the areas outlined in our paper, <a href='{{ site.paper_url }}' target='_blank'>"Tackling Climate Change with Machine Learning."</a> These resources include general references about climate change, as well as resources organized by section of the paper.

If you find that we are missing some important resources, please submit them through <a href='https://forms.gle/BEhx2XobiyP7nNh28' target='_blank'>this form</a>!
HTML

f = File.read('resources_content.md')

sections = f.split(/^##\s/)[1..-1]

html = sections.map do |s|
  lines = s.split("\n")
  title = lines[0]
  body = lines[1..-1].join("\n")

  <<-HTML
<div class='card collapsible'>
  <header class='card-header collapsible-header'>
    <p class='card-header-title'>#{title}</p>
  </header>
  <div class='card-content collapsible-content'>
    <div class='content collapsible-content-inner'>

#{to_html(body)}

    </div>
  </div>
</div>
  HTML
end.join("\n")

puts intro
puts html
