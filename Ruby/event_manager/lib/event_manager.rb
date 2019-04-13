require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'



def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
                  address: zip,
                  levels: 'country',
                  roles: ['legislatorUpperBody', 'legislatorLowerBody'])
    legislators = legislators.officials
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_letters(id, form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename, "w") do |file|
    file.puts form_letter
  end

end

def check_phone_number(phone, id)
  phone = phone.tr('^0-9', '')
  if phone.length < 10
    puts "ID #{id}: bad number"
  elsif phone.length > 10
    if phone[0] == "1" && phone.length == 11
      phone = phone[1..-1]
    else puts "ID #{id}: bad number"
    end
  else phone
  end
end

puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
template_letter = File.read("form_letter.erb")
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  phone = check_phone_number(row[:homephone], id)

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  puts form_letter

  save_thank_letters(id, form_letter)

  11/12/08 10:47

end