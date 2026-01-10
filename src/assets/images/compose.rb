require 'fileutils'
require "tty-progressbar"
require 'parallel'

sizes = %w[a-little a-lot]
actors = %w[i he she they you]
formats = %w[avif png webp]

size_permutations = sizes.repeated_permutation(2).to_a
actor_permutations = actors.repeated_permutation(2).to_a

bar = TTY::ProgressBar.new("generating images (:current/:total) [:bar] :percent", total: size_permutations.length * actor_permutations.length * formats.length)

Parallel.each(size_permutations) do |(left_height, right_height)|
  base_bg_image = "bg-#{left_height}-#{right_height}.png"

  unless File.exist?("base/#{base_bg_image}")
    puts "Missing #{base_bg_image}"
  end

  actor_permutations.each do |(left_actor, right_actor)|
    base_left_actor_image = left_height == 'a-lot' ? "tl-#{left_actor}-said.png" : "bl-#{left_actor}-said.png"
    base_right_actor_image = right_height == 'a-lot' ? "tr-#{right_actor}-read.png" : "br-#{right_actor}-read.png"

    unless File.exist?("base/#{base_left_actor_image}")
      puts "Missing #{base_left_actor_image}"
    end

    unless File.exist?("base/#{base_right_actor_image}")
      puts "Missing #{base_right_actor_image}"
    end

    formats.each do |fmt|
      output_image = "meme-#{left_actor}-said-#{left_height}-#{right_actor}-read-#{right_height}.#{fmt}"
      bar.log output_image
      `magick base/#{base_bg_image} base/#{base_left_actor_image} -gravity northwest -composite base/#{base_right_actor_image} -gravity northwest -composite #{output_image}`
      bar.advance
    end
  end
end
