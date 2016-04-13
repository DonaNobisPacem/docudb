FactoryGirl.define do
  factory :document do
    control "[OVPD" + DateTime.now.strftime("%Y]") + "-" + SecureRandom.hex
    office 1
    date DateTime.now
    received_by {FFaker::NameDA.name}
    subject {FFaker::Movie.title}
    action_subject {FFaker::NameDA.name}
    action_done {FFaker::Movie.title}
    outgoing true
    archival false
  end
end
