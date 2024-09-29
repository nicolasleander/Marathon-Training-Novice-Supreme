require 'date'
require 'securerandom'

# Calculate start date (next Monday)
today = Date.today
days_until_monday = (1 - today.wday) % 7
start_date = today + days_until_monday
start_date += 7 if start_date == today  # If today is Monday, move to next Monday

# Program details
duration_weeks = 30
event_duration = 1  # Default duration in hours, adjust as needed

# Training schedule
training_schedule = [
  # Week 1 to 30
  ["Rest", "2.4 km run", "4.8 km run", "2.4 km run", "Rest", "4.8 km run", "30 min walk"],
  ["Rest", "2.4 km run", "4.8 km run", "2.4 km run", "Rest", "5.6 km run", "35 min walk"],
  ["Rest", "2.4 km run", "4.8 km run", "2.4 km run", "Rest", "4.8 km run", "40 min walk"],
  ["Rest", "3.2 km run", "4.8 km run", "8.1 km run", "Rest", "6.4 km run", "30 min walk"],
  ["Rest", "3.2 km run", "4.8 km run", "3.2 km run", "Rest", "4.8 km run", "45 min walk"],
  ["Rest", "3.2 km run", "4.8 km run", "3.2 km run", "Rest", "4.8 km run", "30 min walk"],
  ["Rest", "3.2 km run", "4.8 km run", "3.2 km run", "Rest", "4.8 km run", "50 min walk"],
  ["Rest", "3.2 km run", "4.8 km run", "3.2 km run", "Rest", "8.1 km run", "30 min walk"],
  ["Rest", "3.2 km run", "4.8 km run", "4 km run", "Rest", "4.8 km run", "55 min walk"],
  ["Rest", "3.2 km run", "4.8 km run", "4 km run", "Rest", "8.1 km run", "30 min walk"],
  ["Rest", "4.8 km run", "4.8 km run", "4.8 km run", "Rest", "4.8 km run", "60 min walk"],
  ["Rest", "4.8 km run", "4.8 km run", "4.8 km run", "Rest", "9.7 km run", "30 min walk"],
  ["Rest", "4.8 km run", "4.8 km run", "4.8 km run", "Rest", "9.7 km run", "Cross"],
  ["Rest", "4.8 km run", "4.8 km run", "4.8 km run", "Rest", "11.3 km run", "Cross"],
  ["Rest", "4.8 km run", "6.4 km run", "4.8 km run", "Rest", "8.1 km run", "Cross"],
  ["Rest", "4.8 km run", "6.4 km run", "4.8 km run", "Rest", "14.5 km run", "Cross"],
  ["Rest", "4.8 km run", "8.1 km run", "4.8 km run", "Rest", "16.1 km run", "Cross"],
  ["Rest", "4.8 km run", "8.1 km run", "4.8 km run", "Rest", "11.3 km run", "Cross"],
  ["Rest", "4.8 km run", "9.7 km run", "4.8 km run", "Rest", "19.3 km run", "Cross"],
  ["Rest", "4.8 km run", "9.7 km run", "4.8 km run", "Rest", "20.9 km run", "Cross"],
  ["Rest", "4.8 km run", "11.3 km run", "6.4 km run", "Rest", "16.1 km run", "Cross"],
  ["Rest", "4.8 km run", "11.3 km run", "6.4 km run", "Rest", "24.1 km run", "Cross"],
  ["Rest", "6.4 km run", "12.9 km run", "6.4 km run", "Rest", "25.8 km run", "Cross"],
  ["Rest", "6.4 km run", "12.9 km run", "8.1 km run", "Rest", "19.3 km run", "Cross"],
  ["Rest", "6.4 km run", "14.5 km run", "8.1 km run", "Rest", "29 km run", "Cross"],
  ["Rest", "8.1 km run", "14.5 km run", "8.1 km run", "Rest", "22.5 km run", "Cross"],
  ["Rest", "8.1 km run", "16.1 km run", "8.1 km run", "Rest", "32.1 km run", "Cross"],
  ["Rest", "8.1 km run", "12.9 km run", "6.4 km run", "Rest", "19.3 km run", "Cross"],
  ["Rest", "6.4 km run", "9.7 km run", "4.8 km run", "Rest", "12.9 km run", "Cross"],
  ["Rest", "4.8 km run", "6.4 km run", "3.2 km run", "Rest", "Rest", "Marathon"]
]

# Generate ICS content
ics_content = []
ics_content << "BEGIN:VCALENDAR"
ics_content << "VERSION:2.0"
ics_content << "PRODID:-//hacksw/handcal//NONSGML v1.0//EN"

training_schedule.each_with_index do |week, week_index|
  week.each_with_index do |activity, day_index|
    next if activity == "Rest"

    event_date = start_date + (week_index * 7) + day_index
    event_start = event_date.strftime("%Y%m%d") + "T090000"  # 9:00 AM start time
    event_end = (event_date + (event_duration / 24.0)).strftime("%Y%m%d") + "T" + (9 + event_duration).to_i.to_s.rjust(2, '0') + "0000"

    # Improved event naming
    event_name = case activity
    when /km run/
      "Run: #{activity}"
    when /min walk/
      "Walk: #{activity}"
    when "Cross"
      "Cross Training"
    when "Marathon"
      "MARATHON DAY!"
    else
      activity
    end

    event_name = "Week #{week_index + 1} - #{event_name}"

    ics_content << "BEGIN:VEVENT"
    ics_content << "UID:#{SecureRandom.uuid}"
    ics_content << "DTSTAMP:#{Time.now.strftime("%Y%m%dT%H%M%SZ")}"
    ics_content << "DTSTART:#{event_start}"
    ics_content << "DTEND:#{event_end}"
    ics_content << "SUMMARY:#{event_name}"
    ics_content << "DESCRIPTION:Marathon Training Program - Week #{week_index + 1}\\n\\nActivity: #{activity}"
    ics_content << "END:VEVENT"
  end
end

ics_content << "END:VCALENDAR"

# Write to file
File.write("marathon_training_program.ics", ics_content.join("\n"))

puts "ICS file 'marathon_training_program.ics' has been generated successfully."
puts "The program starts on #{start_date.strftime('%A, %B %d, %Y')}."
