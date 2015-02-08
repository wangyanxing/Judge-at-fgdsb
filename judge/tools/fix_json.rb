require 'json'

@intro = JSON.parse File.read('../../app/problems/problems.json')
@intro.each { |p| p['source'] = 'Unknown' if not p['source'] }
File.write('../../app/problems/problems.json', JSON.pretty_generate(@intro))

def fix_json(file)
    filename = '../../app/problems/' + file
    prob = JSON.parse File.read(filename)
    intro =  @intro.select { |p| p['id'] == prob['id'] }[0]

    prob['difficulty'] = intro['difficulty']
    prob['time'] = intro['time']
    prob['source'] = intro['source']
    prob['tags'] = []

    output = JSON.pretty_generate(prob)
    output.sub! /"code_cpp"/, "\n  \"code_cpp\""
    output.sub! /"in_type_cpp"/, "\n  \"in_type_cpp\""
    output.sub! /"in_type_java"/, "\n  \"in_type_java\""
    output.sub! /"judge_call"/, "\n  \"judge_call\""
    output.sub! /"difficulty"/, "\n  \"difficulty\""

    File.write(filename, output)
end

excluded = %w(problems.json tags.json)
Dir.entries('../../app/problems/').each do |f|
    next if File.directory?(f) or File.extname(f) != '.json' or excluded.include? f
    puts "fixing: #{f}"
    fix_json f
end