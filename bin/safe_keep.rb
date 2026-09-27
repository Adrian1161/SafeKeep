#!/usr/bin/env ruby
# frozen_string_literal: true

# RbConfig provides the path to the Ruby executable running this script.
require "rbconfig"

# Find the project root based on this file's location:
# bin/safe_keep.rb -> project root.
APP_ROOT = File.expand_path("..", __dir__)

# Run a Bundler command with the current Ruby and from the project root.
# For example, run_bundle_command("check") runs `bundle check`.
def run_bundle_command(*args)
  system(RbConfig.ruby, "-S", "bundle", *args, chdir: APP_ROOT)
end

# Set up the app when the user runs `ruby bin/safe_keep.rb --install`.
def install!
  # Install any gems listed in the Gemfile that are not installed yet.
  puts "Installing Ruby dependencies..."
  return false unless run_bundle_command("install")

  # Create the database and apply any available schema or migrations.
  puts "Preparing the database..."
  return false unless run_bundle_command("exec", "rails", "db:prepare")

  # Installation is finished. The user can start SafeKeep with a normal run.
  puts "Setup complete. Run `ruby bin/safe_keep.rb` to start SafeKeep."
  true
end

# Check that the gems in the project's bundle are installed.
# Run this before loading Rails so missing gems produce a clear message.
def dependencies_ready?
  run_bundle_command("check")
end

# Check whether the app can use its database.
def database_ready?
  # Read the database configuration after the Rails environment has loaded.
  config = ActiveRecord::Base.connection_db_config

  # For SQLite, confirm the configured database file exists before connecting.
  # This avoids treating a newly created, empty database file as ready.
  if config.adapter == "sqlite3"
    database_path = File.expand_path(config.database, APP_ROOT)
    return false unless File.file?(database_path)
  end

  # A simple query confirms the app can connect and use the database.
  ActiveRecord::Base.connection.select_value("SELECT 1")

  # Fail the check if Rails migrations still need to be applied.
  ActiveRecord::Migration.check_all_pending!

  true
rescue StandardError => e
  # Report the reason for a failed database check to help with setup.
  warn "Database check failed: #{e.message}"
  false
end

# Load the first terminal menu and pass control to it.
# This expects login_menu.rb to define LoginMenu with a `call` method.
def start_login_menu
  require_relative "../lib/cli/login_menu"

  unless defined?(LoginMenu)
    warn "Expected lib/cli/login_menu.rb to define LoginMenu."
    return false
  end

  LoginMenu.new.call
  true
end

# Main launcher flow.
def run
  # Make relative paths and Rails commands work from the project root,
  # even if the user started SafeKeep from another directory.
  Dir.chdir(APP_ROOT)

  # Install mode prepares gems and the database, then exits.
  if ARGV == ["--install"]
    return install! ? 0 : 1
  end

  # Reject unrecognized arguments and show the supported command.
  unless ARGV.empty?
    warn "Usage: ruby bin/safe_keep.rb [--install]"
    return 2
  end

  # Check gems before booting Rails, which depends on those gems.
  unless dependencies_ready?
    warn "Dependencies are missing. Run: ruby bin/safe_keep.rb --install"
    return 1
  end

  # Load the Rails app so Active Record and the database configuration
  # are available to the database check and CLI.
  begin
    require_relative "../config/environment"
  rescue LoadError, StandardError => e
    warn "Could not load the Rails environment: #{e.message}"
    return 1
  end

  # Do not start the login menu if the database check fails.
  unless database_ready?
    warn "The database is not ready. Run: ruby bin/safe_keep.rb --install"
    return 1
  end

  # Start the terminal UI after setup checks pass.
  start_login_menu ? 0 : 1
end

# Return the launcher's result as the process exit code.
exit(run)