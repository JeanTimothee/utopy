namespace :assets do
  task :size => :environment do
    total_size = 0

    Rails.application.assets.each_file do |filename|
      asset = Rails.application.assets.find_asset(filename)
      total_size += asset.length
      puts "#{filename}: #{asset.length} bytes"
    end

    puts "Total assets size: #{total_size} bytes"
  end
end
