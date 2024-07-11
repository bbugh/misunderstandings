require 'fileutils'
require "tty-progressbar"

sizes = %w[small big]
actors = %w[i he she they you]

size_permutations = sizes.repeated_permutation(2).to_a
actor_permutations = actors.repeated_permutation(2).to_a

bar = TTY::ProgressBar.new("generating images (:current/:total) [:bar] :percent", total: size_permutations.length * actor_permutations.length)

size_permutations.each do |(left_height, right_height)|
  bg_image = "bg-#{left_height}-#{right_height}.png"

  unless File.exist?("base/#{bg_image}")
    puts "Missing #{bg_image}"
  end

  actor_permutations.each do |(left_actor, right_actor)|
    left_actor_image = left_height == 'big' ? "tl-#{left_actor}-said.png" : "bl-#{left_actor}-said.png"
    right_actor_image = right_height == 'big' ? "tr-#{right_actor}-read.png" : "br-#{right_actor}-read.png"

    unless File.exist?("base/#{left_actor_image}")
      puts "Missing #{left_actor_image}"
    end

    unless File.exist?("base/#{right_actor_image}")
      puts "Missing #{right_actor_image}"
    end

    output_image = "#{left_actor}-said-#{left_height}-#{right_actor}-read-#{right_height}.png"
    bar.log output_image
    `convert base/#{bg_image} base/#{left_actor_image} -gravity northwest -composite base/#{right_actor_image} -gravity northwest -composite meme-#{output_image}`

    bar.advance
  end
end
