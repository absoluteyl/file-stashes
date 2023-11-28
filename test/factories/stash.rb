FactoryBot.define do
  factory :stash do
    attachment { Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'stash_attachment.txt'), 'text/plain') }
  end
end
