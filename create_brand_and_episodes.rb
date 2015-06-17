require 'pips'

PREFERENCES = {
  brand_title: 'Store Rights applied at Brand Level',
  series_title: 'This are Serious Series',
  rights_policy_pid: 'p00t4h2v'
}

def generate_on_air_id
  (0...4).map{(65+rand(26)).chr}.join +
    (0...3).map{rand(9).to_s}.join +
    (65+rand(26)).chr
end

brand = PIPS::XML::Brand.new
brand.save(title: PREFERENCES[:brand_title])
puts "Brand: #{brand.pid}"

series = PIPS::XML::Series.new
series.save(title: PREFERENCES[:series_title], brand: brand)
puts "Series: #{series.pid}"

rights_policy = PIPS::XML::RightsPolicy.new(pid: PREFERENCES[:rights_policy_pid])

rights_contract = PIPS::XML::RightsContract.new
rights_contract.save(
  odm_managed: true,
  rights_policy: rights_policy,
  start_date: Time.now + 10,
  brand: brand
)

puts "Rights Contract: #{rights_contract.pid}"

30.times do |i|

  on_air_id = generate_on_air_id

  episode = PIPS::XML::Episode.new
  episode.save(
    title: "Episode #{i+1}",
    presentation_title: "Episode #{i+1}",
    other_ids: [{type: 'uid', authority: 'onair', value: on_air_id}],
    series: series,
    series_index: i+1,
    brand: brand
  )
  puts "#{episode.title}: #{episode.pid}"

  version = PIPS::XML::Version.new
  version.save(
    episode: episode,
    other_ids: [{type: 'uid', authority: 'onair', value: "#{on_air_id}/01"}]
  )

end
