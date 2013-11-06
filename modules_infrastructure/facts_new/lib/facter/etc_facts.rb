require 'facter'

if File.exist?('/etc/facts')
        Dir.glob('/etc/facts/*.txt') do |my_text_file|
                File.readlines(my_text_file).each do |line|
                    if line =~ /^(.+)=(.+)$/
                        var = $1; val = $2
                        Facter.add(var) do
                            setcode { val }
                                end
                        end
                end
        end
end
