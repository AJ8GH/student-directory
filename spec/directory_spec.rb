# require 'directory'

describe '#print menu' do
  context 'on startup' do
    let(:menu) { ['1. Input students', '2. Show the students', '3. Show the cohorts',
                  '4. Save students to file', '5. Load student file', '6. Print source code',
                  '7. Delete student', '8. Delete cohort', '9. Exit'] }

    it 'outputs the correct menu' do
      expect { require_relative './../lib/directory.rb' }.to output(/["#{menu.join("\n")}"]/).to_stdout
    end
  end
end
