=begin
require 'json'

path = '../fgdsb_judge/package.json'
content = File.read(path)
pkg = JSON.parse(content)

pkg['dev'] = false
f = File.new(path, 'w')
f.write JSON.pretty_generate(pkg)
f.close

puts 'building...'
`node build.js`

pkg['dev'] = true
f = File.new(path, 'w')
f.write JSON.pretty_generate(pkg)
f.close
=end

require 'net/http'
require 'uri'
require 'ruby-progressbar'
require 'colorize'

def download_file(url)  
  url_base, url_path = url.split('/')[2], '/'+url.split('/')[3..-1].join('/')
  @counter = 0
   
  Net::HTTP.start(url_base) do |http|
    response = http.request_head(URI.escape(url_path))
    length = response['content-length'].to_i
    bar = ProgressBar.create(:format => "#{File.basename(url)} (#{length/(1024**2)}MB) |%b>%i| %p%% done")

    File.open(File.basename(url), 'w') do |f|
      http.get(URI.escape(url_path)) do |str|
        f.write str
        @counter += str.length
        bar.progress = @counter * 100 / length
        line = bar.to_s + "\r"
        print line
        $stdout.flush
      end
    end  
  end
end

url = "http://dldir1.qq.com/qqfile/QQforMac/QQ_V3.1.1.dmg"
download_file url










