require 'pips'

def update_title_on_programme(programme, title)
  programme.title = "#{title} "
  programme.commit_updates
  programme.title = title
  programme.commit_updates
end

def update_duration_on_programme(programme, duration)
  programme.duration = (duration == "00:00:01") ? "00:00:02" : "00:00:01"
  programme.commit_updates
  programme.duration = duration
  programme.commit_updates
end

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
      update_title_on_programme(programme, title)
    end
  end
end

task :update_episode do
  epid = ARGV[1]
  if epid.nil?
    print "Enter episode pid: "
    epid = STDIN.gets.chomp
  end

  puts "Finding episode with pid: #{epid}"
  episode = PIPS::XML::Episode.new(pid: epid)

  update_parents_for_programme(episode)

  title = episode.title
  puts "Updating Episode: #{title}"
  update_title_on_programme(episode, title)
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
  update_duration_on_programme(version, duration)



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
    update_duration_on_programme(ondemand, duration)
  end
end
