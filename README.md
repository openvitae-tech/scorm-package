# Scorm Packaging gem

## Local development with Host Application

### Installation

1. Build the gem

   ```zsh
      gem build scorm_package
   ```

2. Add this line to your application's Gemfile:

   ```ruby
    # ..existing gems
    gem 'scorm-package', path: "<PATH_TO_SCORM_PACKAGE>"
   ```

3. And then execute:

   ```zsh
   bundle install
   ```
