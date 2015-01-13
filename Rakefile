require 'pips'

def update_parents_for_programme(programme)
  parents = []

  parent = programme.parent
  while parent do
    parents.unshift(parent)
    parent = parent.parent
  end

  parents.each do |programme|
    title = programme.title
    print "Update #{programme.class.to_s.split('::').last}: #{title}? [y/n] "
    response = STDIN.gets.chomp
    if response == 'y'
      programme.title = "#{title} "
      programme.commit_updates
      programme.title = title
      programme.commit_updates
    end
  end
end

task :update_version do
  vpid = ARGV[1]
  if vpid.nil?
    print "Enter version pid: "
    vpid = STDIN.gets.chomp
  end

  puts "Finding version with pid: #{vpid}"
  version = PIPS::XML::Version.new(pid: vpid)

  update_parents_for_programme(version)

  # update duration on the version

  duration = version.duration
  puts "Updating Version: #{version.pid}"
  version.duration = (duration == "00:00:01") ? "00:00:02" : "00:00:01"
  version.commit_updates
  version.duration = duration
  version.commit_updates




  # update source on all the media_assets

  puts "Finding media assets"
  media_assets = version.media_assets

  media_assets.each_with_index do |media_asset, index|
    source = media_asset.source
    puts "Updating Media Asset: #{index + 1} of #{media_assets.size}"
    media_asset.source = "#{source} "
    media_asset.commit_updates
    media_asset.source = source
    media_asset.commit_updates
  end



  # update duration on all the ondemands

  puts "Finding ondemands"
  ondemands = version.ondemands

  ondemands.each_with_index do |ondemand, index|
    duration = ondemand.duration
    puts "Updating OnDemand: #{index + 1} of #{ondemands.size}"
    ondemand.duration = (duration == "00:00:01") ? "00:00:02" : "00:00:01"
    ondemand.commit_updates
    ondemand.duration = duration
    ondemand.commit_updates
  end
end
