require "net/http"
require "uri"

dry_run = false

# From https://nekonenene.hatenablog.com/entry/homebrew-tap-sha256-updater
# Return SHA256 hash string or nil
def fetch_sha256(url)
    response_body =
        loop do
            is_loop_end = true

            uri = URI.parse(url)
            response = Net::HTTP.get_response(uri)

            case response
            when Net::HTTPSuccess
                break response.body
            when Net::HTTPNotFound
                puts "Not found: \"#{url}\""
            when Net::HTTPRedirection
                url = response["location"]
                is_loop_end = false
            else
                puts "#{response.code} error occured while connecting to \"#{url}\""
            end

            break if is_loop_end
        end

    Digest::SHA256.hexdigest(response_body) if !response_body.nil?
end


def update_hash_in_formula(formula_io)
    lines = formula_io.readlines
    for i in 0...lines.size - 2
        match_url = lines[i].match(/\s+url\s+['"]([^'"]+)['"]/)
        match_sha256 = lines[i + 1].match(/\s+sha256\s+['"]([^'"]*)['"]/)
        if match_url && match_sha256
            url = match_url[1]
            old_sha256 = match_sha256[1]
            sha256 = fetch_sha256(url)
            if sha256
                if old_sha256 != sha256
                    puts "Updating SHA256(#{url}): #{old_sha256} -> #{sha256}"
                end
                lines[i + 1].sub!(/['"][^'"]*['"]/, "'#{sha256}'")
            end
        end
    end
    lines
end

class UpdateHash
    def main
        formula_path = nil
        ARGV.each do |arg|
            if arg == '--dry-run'
                $dry_run = true
            elsif formula_path.nil?
                formula_path = arg
            else
                puts "Invalid argument: #{arg}"
                exit 1
            end
        end
        File.open(formula_path, 'r+') do |formula_io|
            updated_lines = update_hash_in_formula(formula_io)
            if updated_lines && !$dry_run
                formula_io.rewind
                formula_io.write(updated_lines.join)
            end
        end
    end
end

UpdateHash.new.main
